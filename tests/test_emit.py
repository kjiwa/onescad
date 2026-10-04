from pathlib import Path

import pytest

from helpers import HAS_OPENSCAD, analyze, bundle_body, openscad
from onescad.emit import SENTINEL, display_path, leading_block, neutralize

LIB = "// Lib header, by Someone.\nfunction helper(x) = x * k;\nk = 3;\nmodule spare() cube(9);\n"


def test_output_order_is_params_sentinel_used_namespaces_then_main(tmp_path: Path) -> None:
    out = bundle_body(
        tmp_path,
        {
            "m.scad": "use <lib.scad>\n/* [Size] */\nw = 10; // [1:20]\ncube(helper(w));\n",
            "lib.scad": LIB,
        },
    )
    text = out.text
    order = [
        text.index("/* [Size] */"),
        text.index(SENTINEL),
        text.index("// onescad: lib.scad"),
        text.index("// onescad: m.scad"),
        text.index("cube(helper(w));"),
    ]
    assert order == sorted(order)
    assert "w = 10; // [1:20]" in text
    assert text.count("w = 10") == 1
    assert out.files == (tmp_path.resolve() / "lib.scad", tmp_path.resolve() / "m.scad")


def test_unused_library_code_is_shaken_out(tmp_path: Path) -> None:
    out = bundle_body(tmp_path, {"m.scad": "use <lib.scad>\nx = helper(1);\n", "lib.scad": LIB})
    assert "spare" not in out.text
    assert "function helper(x) = x * k;" in out.text
    assert "k = 3;" in out.text


def test_a_file_leading_comment_is_emitted_once_and_the_main_one_is_left_to_the_header(
    tmp_path: Path,
) -> None:
    out = bundle_body(
        tmp_path,
        {
            "m.scad": "// Main doc.\nuse <lib.scad>\nx = helper(1);\ny = helper(2);\n",
            "lib.scad": LIB,
        },
    )
    assert out.text.count("// Lib header, by Someone.") == 1
    assert "Main doc" not in out.text


def test_reassignment_keeps_the_first_position_and_the_last_expression(tmp_path: Path) -> None:
    out = bundle_body(tmp_path, {"m.scad": "a = 1 + 1;\nb = a + 5;\na = 7 * 3;\n"})
    assert out.text.index("a = 7 * 3;") < out.text.index("b = a + 5;")
    assert "1 + 1" not in out.text


def test_a_last_function_definition_wins(tmp_path: Path) -> None:
    out = bundle_body(tmp_path, {"m.scad": "function f() = 1;\nfunction f() = 2;\nx = f();\n"})
    assert "function f() = 2;" in out.text
    assert "function f() = 1;" not in out.text


def test_an_included_file_is_marked_and_its_definitions_collapse(tmp_path: Path) -> None:
    out = bundle_body(
        tmp_path,
        {
            "m.scad": "include <i.scad>\ninclude <i.scad>\nx = f();\n",
            "i.scad": "function f() = 1;\ncube(1);\n",
        },
    )
    assert out.text.count("function f() = 1;") == 1
    assert out.text.count("cube(1);") == 2
    assert "// onescad: i.scad" in out.text


def test_single_line_block_comments_before_kept_statements_become_line_comments(
    tmp_path: Path,
) -> None:
    out = bundle_body(
        tmp_path,
        {"m.scad": "w = 1;\n\n/* [Other] */\nmodule m() cube(w);\nm();\n"},
    )
    assert "/* [Other] */" not in out.text
    assert "// [Other]" in out.text


def test_fonts_and_external_files_are_reported(tmp_path: Path) -> None:
    out = bundle_body(
        tmp_path,
        {
            "m.scad": 'text("a", font = "Liberation Sans");\n'
            'import("part.stl");\nsurface(file = "h.dat");\nimport(name);\n'
        },
    )
    assert out.fonts == ("Liberation Sans",)
    assert out.external_files == ('"part.stl"', '"h.dat"', "<computed path>")
    assert len(out.warnings) == 3


def test_a_variable_of_a_used_file_warns(tmp_path: Path) -> None:
    out = bundle_body(tmp_path, {"m.scad": "use <lib.scad>\nx = helper(1);\n", "lib.scad": LIB})
    assert any("'k' of a used file" in w for w in out.warnings)


def test_display_path_is_relative_to_the_first_containing_root(tmp_path: Path) -> None:
    lib = tmp_path / "lib"
    assert display_path(lib / "a" / "b.scad", [tmp_path / "x", lib]) == "a/b.scad"
    assert display_path(tmp_path / "o.scad", [lib]) == "../o.scad"


def test_neutralize_rewrites_only_single_line_block_comments() -> None:
    text = "/* [G] */\n/* multi\nline */\n// kept\n"
    assert neutralize(text) == "// [G]\n/* multi\nline */\n// kept"


def test_leading_block_stops_at_the_first_token() -> None:
    assert leading_block("// a\n\n// b\nx = 1;\n// c\n") == "// a\n\n// b"
    assert leading_block("x = 1;\n") == ""


MODELS = {
    "shadow": {
        "m.scad": "use <l.scad>\nmodule cube(s) lib(s);\ncube(2);\necho(g(3));\n",
        "l.scad": "module lib(s) cube(s);\nfunction g(x) = x * 2;\n",
    },
    "params": {
        "m.scad": "/* [A] */\nw = 4;\n/* [B] */\nh = w * 2;\n$fn = 12;\ncube([w, h, 1]);\n"
        "sphere(1);\n",
    },
    "include": {
        "m.scad": "include <i.scad>\nmodule m() { include <i.scad> }\nm();\n",
        "i.scad": "k = 3;\nf = function(x) x + k;\n",
    },
}


@pytest.mark.oracle
@pytest.mark.skipif(not HAS_OPENSCAD, reason="openscad is not installed")
@pytest.mark.parametrize("case", sorted(MODELS))
def test_bundle_renders_like_the_source(tmp_path: Path, case: str) -> None:
    files = MODELS[case]
    out = bundle_body(tmp_path / "src", files)
    bundle = tmp_path / "bundle" / "out.scad"
    bundle.parent.mkdir()
    bundle.write_text(out.text)
    assert openscad(bundle) == openscad(tmp_path / "src" / "m.scad")


def test_analyze_returns_the_hoist_plan(tmp_path: Path) -> None:
    _, _, plan = analyze(tmp_path, {"m.scad": "w = 1;\n"})
    assert [p.name for p in plan.params] == ["w"]


@pytest.mark.parametrize(
    "site",
    [
        "module m() {\n  include <i.scad>\n}\nm();\n",
        "module m() include <i.scad>\nm();\n",
        "if (true) {\n  include <i.scad>\n}\n",
        "translate([0, 0, 0]) {\n  include <i.scad>\n}\n",
        "module m() {\n  if (true) include <i.scad>\n}\nm();\n",
    ],
)
def test_an_include_below_the_top_level_is_spliced_and_its_references_kept(
    tmp_path: Path, site: str
) -> None:
    files = {
        "m.scad": "use <lib.scad>\n" + site,
        "lib.scad": "function helper(x) = x;\nfunction spare() = 1;\n",
        "i.scad": "cube(helper(1));\n",
    }
    text = bundle_body(tmp_path, files).text
    assert "include" not in text
    assert "cube(helper(1));" in text
    assert "function helper(x) = x;" in text
    assert "spare" not in text


def test_a_name_used_only_by_a_nested_include_is_not_chosen_as_a_fresh_name(
    tmp_path: Path,
) -> None:
    files = {
        "m.scad": "use <b.scad>\nmodule m() {\n  include <i.scad>\n}\nm();\necho(norm([3, 4]));\n",
        "b.scad": "use <a.scad>\nfunction bn(v) = norm(v);\n",
        "a.scad": "function norm(v) = 99;\n",
        "i.scad": "echo(bn([1]), norm_1);\n",
    }
    text = bundle_body(tmp_path, files).text
    assert "function norm_1(" not in text
