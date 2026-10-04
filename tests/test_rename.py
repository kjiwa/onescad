from pathlib import Path

import pytest

from helpers import analyze, write
from onescad.emit import emit
from onescad.errors import BundleError


def bundle(tmp_path: Path, files: dict[str, str]):  # type: ignore[no-untyped-def]
    graph, refs, plan = analyze(tmp_path, files)
    return emit(graph, refs, plan, [tmp_path.resolve()])


def test_a_definition_that_would_capture_a_builtin_call_is_renamed(tmp_path: Path) -> None:
    out = bundle(
        tmp_path,
        {
            "m.scad": "use <l.scad>\nmodule cube(s) lib(s);\ncube(1);\n",
            "l.scad": "module lib(s) cube(s);\n",
        },
    )
    assert out.renamed == {"cube__1": "cube"}
    assert "module cube__1(s) lib(s);" in out.text
    assert "cube__1(1);" in out.text
    assert "module lib(s) cube(s);" in out.text


def test_same_name_in_two_namespaces_is_split_apart(tmp_path: Path) -> None:
    out = bundle(
        tmp_path,
        {
            "m.scad": "use <a.scad>\nuse <b.scad>\nx = fa() + fb();\n",
            "a.scad": "function f() = 1;\nfunction fa() = f();\n",
            "b.scad": "function f() = 2;\nfunction fb() = f();\n",
        },
    )
    assert out.renamed == {"f__1": "f"}
    assert "function f() = 1;" in out.text
    assert "function fa() = f();" in out.text
    assert "function f__1() = 2;" in out.text
    assert "function fb() = f__1();" in out.text


def test_fresh_names_avoid_every_word_in_the_bundle(tmp_path: Path) -> None:
    out = bundle(
        tmp_path,
        {
            "m.scad": "use <l.scad>\nmodule cube(s) lib(s);\ncube__1 = 1;\ncube(cube__1);\n",
            "l.scad": "module lib(s) cube(s);\n",
        },
    )
    assert out.renamed == {"cube__2": "cube"}


def test_a_main_variable_that_would_capture_a_library_reference_is_an_error(
    tmp_path: Path,
) -> None:
    files = {"m.scad": "use <l.scad>\nw = 5;\nx = f();\n", "l.scad": "function f() = w;\n"}
    with pytest.raises(BundleError, match="conflicting definitions"):
        bundle(tmp_path, files)


def test_a_forward_reference_to_a_variable_of_its_own_namespace_is_not_a_conflict(
    tmp_path: Path,
) -> None:
    out = bundle(tmp_path, {"m.scad": "a = b;\nb = 1 + 1;\n"})
    assert out.renamed == {}


def test_a_rename_that_splits_a_call_target_is_an_error(tmp_path: Path) -> None:
    files = {
        "m.scad": "use <a.scad>\nuse <b.scad>\nx = f(1) + g();\n",
        "a.scad": "function sin(x) = x;\nfunction f(sin) = sin(1);\n",
        "b.scad": "function g() = sin(0);\n",
    }
    with pytest.raises(BundleError, match="renaming would split"):
        bundle(tmp_path, files)


def test_the_main_namespace_outranks_used_ones(tmp_path: Path) -> None:
    out = bundle(
        tmp_path,
        {
            "m.scad": "use <l.scad>\nfunction h() = 1;\nx = h() + g();\n",
            "l.scad": "function h() = 2;\nfunction g() = h();\n",
        },
    )
    assert list(out.renamed.values()) == ["h"]
    assert "function h() = 1;" in out.text
    assert "function g() = h__1();" in out.text


def test_write_returns_the_first_file(tmp_path: Path) -> None:
    assert write(tmp_path, {"a.scad": "", "b/c.scad": ""}) == tmp_path / "a.scad"
