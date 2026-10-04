import json
import shutil
import subprocess
from pathlib import Path

import pytest

from onescad import syntax as ast
from onescad.customizer import CustomizerError, HoistPlan, plan_hoist
from onescad.lexer import Kind, lex
from onescad.loader import load
from onescad.parser import parse
from onescad.resolver import resolve

SUPPORT = {
    "inc.scad": "incv = 1;\nia = 2;\n",
    "inc_brace.scad": "module im() { }\n",
    "inc_y.scad": "iy = 1;\n",
}


def plan(tmp_path: Path, source: str) -> HoistPlan:
    for name, text in SUPPORT.items():
        (tmp_path / name).write_text(text)
    main = tmp_path / "main.scad"
    main.write_text(source)
    graph = load(main, (), {})
    return plan_hoist(graph, resolve(graph))


def ids(rows: list[tuple[str, ...]]) -> list[str]:
    return [r[0] for r in rows]


def names(tmp_path: Path, source: str) -> list[str]:
    return [p.name for p in plan(tmp_path, source).params]


LITERAL_ROWS = [
    ("1", True),
    ("-3", True),
    ("+4", True),
    ("0x1F", True),
    ("1e3", True),
    ("1.", True),
    (".5", True),
    ("-0x10", True),
    ("- -3", True),
    ("-+-1", True),
    ("(3)", True),
    ("((3))", True),
    ("(-3)", True),
    ("-(3)", True),
    ("-(-(3))", True),
    ('"a"', True),
    ('"esc\\"aped"', True),
    ('("a")', True),
    ("true", True),
    ("false", True),
    ("(true)", True),
    ("[1]", True),
    ("[1, 2, 3, 4]", True),
    ("[1, 2, ]", True),
    ("[(1), 2]", True),
    ("[-1, (+2), ((3))]", True),
    ("[-(1), 2]", True),
    ("([1, 2])", True),
    ("+[1, 2]", True),
    ("1\n// [0:5]\n", True),
    ("[1, 2, 3, 4, 5]", False),
    ("[]", False),
    ("[1, true]", False),
    ("[true, false]", False),
    ('["a"]', False),
    ("[1, undef]", False),
    ("[[1, 2]]", False),
    ("[1, [2]]", False),
    ("-[1, 2]", False),
    ("[0:5]", False),
    ("1 + 2", False),
    ("!true", False),
    ("-true", False),
    ('-"a"', False),
    ("undef", False),
    ("x", False),
    ("3d", False),
    ("f(1)", False),
    ("1 ? 2 : 3", False),
]


@pytest.mark.parametrize(("expr", "exposed"), LITERAL_ROWS, ids=[r[0] for r in LITERAL_ROWS])
def test_value_literal_forms(tmp_path: Path, expr: str, exposed: bool) -> None:
    assert names(tmp_path, f"p = {expr};") == (["p"] if exposed else [])


def test_dynamic_variable_is_a_parameter(tmp_path: Path) -> None:
    assert names(tmp_path, "$fn = 32;") == ["$fn"]


CUTOFF_ROWS = [
    ("brace-ends-params-at-its-line", "a = 1;\nmodule m() {\n}\nb = 2;", ["a"]),
    ("same-line-assignment-excluded", "a = 1;\nb = 2; module m() { }", ["a"]),
    ("brace-in-string-counts", 'a = 1;\nb = "x{y";\nc = 3;', ["a"]),
    ("brace-in-line-comment-ignored", "// {\na = 1;", ["a"]),
    ("brace-in-block-comment-ignored", "/* { */\na = 1;", ["a"]),
    ("brace-in-include-ignored", "include <inc_brace.scad>\na = 1;", ["a"]),
    ("brace-in-string-in-include-ignored", "a = 1;\ninclude <inc_brace.scad>\nb = 2;", ["a", "b"]),
    ("multi-line-literal", "a = [1,\n  2];\nb = 1;", ["a", "b"]),
    ("reassignment-after-cutoff-removes", "a = 1;\nmodule m() {\n}\na = 2;", []),
    ("both-before-cutoff-collapse", "a = 1;\nb = 5;\na = 3;", ["a", "b"]),
    ("last-nonliteral-removes", "a = 1;\na = b;", []),
    ("first-nonliteral-kept-out-of-the-way", "a = b;\na = 1;", ["a"]),
    ("include-defines-no-parameters", "include <inc.scad>\na = 1;", ["a"]),
    ("include-reassignment-removes", "ia = 1;\ninclude <inc.scad>\nb = 1;", ["b"]),
    ("main-reassignment-of-included-keeps-it", "include <inc_y.scad>\niy = 2;", ["iy"]),
    ("order-is-first-position", "a = 1;\nb = 2;\na = 3;", ["a", "b"]),
    (
        "order-counts-included-first-position",
        "x1 = 1;\ninclude <inc_y.scad>\nx2 = 1;\niy = 2;",
        ["x1", "iy", "x2"],
    ),
    ("hidden-group-is-not-a-parameter", "/* [Hidden] */\na = 1;", []),
    ("hidden-group-is-case-sensitive", "/* [hidden] */\na = 1;", ["a"]),
    ("hidden-by-last-assignment", "/* [A] */\na = 1;\n/* [Hidden] */\na = 2;", []),
    ("shown-by-last-assignment", "/* [Hidden] */\na = 1;\n/* [B] */\na = 2;", ["a"]),
]


@pytest.mark.parametrize(
    ("source", "expected"), [r[1:] for r in CUTOFF_ROWS], ids=[r[0] for r in CUTOFF_ROWS]
)
def test_parameter_set(tmp_path: Path, source: str, expected: list[str]) -> None:
    assert names(tmp_path, source) == expected


def groups(tmp_path: Path, source: str) -> list[str | None]:
    return [p.group for p in plan(tmp_path, source).params]


GROUP_ROWS = [
    ("default", "a = 1;", ["Parameters"]),
    ("marker", "/* [G] */\na = 1;", ["G"]),
    ("marker-is-trimmed", "/* [ G ] */\na = 1;", ["G"]),
    ("marker-without-padding", "/*[G]*/\na = 1;", ["G"]),
    ("marker-with-text-around", "/* text [G] more */\na = 1;", ["G"]),
    ("doc-comment-marker", "/** [G] */\na = 1;", ["G"]),
    ("same-line-marker-applies-after", "/* [G] */ a = 1;\nb = 1;", ["Parameters", "G"]),
    ("trailing-marker-applies-after", "a = 1; /* [G] */\nb = 1;", ["Parameters", "G"]),
    ("last-marker-on-a-line-wins", "/* [A] */ /* [B] */\na = 1;", ["B"]),
    ("plain-block-comment-clears-group", "/* [G] */\n/* note */\na = 1;", [None]),
    ("blank-block-comment-clears-group", "/* */\na = 1;", [None]),
    ("empty-marker-clears-group", "/* [] */\na = 1;", [None]),
    ("unclosed-marker-clears-group", "/* [G */\na = 1;", [None]),
    ("multi-line-comment-leaves-group", "/* [G] */\n/* a\n b */\na = 1;", ["G"]),
    ("multi-line-marker-ignored", "/*\n [G]\n*/\na = 1;", ["Parameters"]),
    ("line-comment-is-not-a-marker", "// [G]\na = 1;", ["Parameters"]),
    ("line-comment-with-block-is-not-a-marker", "// x /* [G] */\na = 1;", ["Parameters"]),
    ("marker-in-string-ignored", 's = "/* [G] */";\na = 1;', ["Parameters", "Parameters"]),
    ("marker-with-punctuation", "/* [Tab, with: x] */\na = 1;", ["Tab, with: x"]),
    ("duplicate-takes-last-group", "/* [A] */\na = 1;\n/* [B] */\na = 2;", ["B"]),
]


@pytest.mark.parametrize(
    ("source", "expected"), [r[1:] for r in GROUP_ROWS], ids=[r[0] for r in GROUP_ROWS]
)
def test_group(tmp_path: Path, source: str, expected: list[str | None]) -> None:
    assert groups(tmp_path, source) == expected


def test_leading_comment_run_is_carried(tmp_path: Path) -> None:
    (param,) = plan(tmp_path, "// one\n// two\na = 1;").params
    assert param.leading == "// one\n// two\n"


@pytest.mark.parametrize(
    "source",
    [
        "// cap\n\na = 1;",
        "   // cap\na = 1;",
        "\t// cap\na = 1;",
        "/* cap */\na = 1;",
        "b = 2; // cap\na = 1;",
        "/* [G] */\na = 1;",
    ],
    ids=["blank-line", "spaces", "tab", "block-comment", "code-line", "marker"],
)
def test_comment_not_directly_above_is_not_carried(tmp_path: Path, source: str) -> None:
    assert plan(tmp_path, source).params[-1].leading == ""


def test_run_stops_at_a_marker(tmp_path: Path) -> None:
    (param,) = plan(tmp_path, "// far\n/* [G] */\n// near\na = 1;").params
    assert param.leading == "// near\n"


def test_statements_sharing_a_line_share_the_caption(tmp_path: Path) -> None:
    a, b = plan(tmp_path, "// cap\na = 1; b = 2;").params
    assert a.leading == b.leading == "// cap\n"


TRAILING_ROWS = [
    ("widget", "a = 1; // [0:5]", " // [0:5]"),
    ("no-space", "a = 1;// [0:5]", " // [0:5]"),
    ("other-comment", "a = 1; // note", " // note"),
    ("block-comment-dropped", "a = 1; /* [G] */", ""),
    ("block-then-line", "a = 1; /* [G] */ // note", " // note"),
    ("second-statement-voids", "a = 1; b = 2; // [0:5]", ""),
    ("multi-line-statement-voids", "a = [1,\n 2]; // [0:3]", ""),
    ("none", "a = 1;", ""),
]


@pytest.mark.parametrize(
    ("source", "expected"), [r[1:] for r in TRAILING_ROWS], ids=[r[0] for r in TRAILING_ROWS]
)
def test_trailing_comment(tmp_path: Path, source: str, expected: str) -> None:
    assert plan(tmp_path, source).params[-1].trailing == expected


def test_first_line_comment_inside_a_multi_line_statement_is_kept(tmp_path: Path) -> None:
    (param,) = plan(tmp_path, "a = [1, // [0:4]\n  2];").params
    assert param.text == "a = [1, // [0:4]\n  2];"


def test_dropped_covers_every_assignment_of_a_hoisted_name(tmp_path: Path) -> None:
    result = plan(tmp_path, "include <inc_y.scad>\niy = 2;\nc = 1;\nc = 2;")
    graph = load(tmp_path / "main.scad", (), {})
    starts = {
        (source.path.name, stmt.start)
        for source, stmt in graph.splice(graph.main.root, graph.files[graph.main.root].tree.stmts)
        if isinstance(stmt, ast.Assign) and stmt.name in ("iy", "c")
    }
    assert {(p.name, s) for p, s in result.dropped} == starts
    assert [p.name for p in result.params] == ["iy", "c"]


def test_render_regenerates_markers_on_change_only(tmp_path: Path) -> None:
    source = "/* [A] */\n// cap\na = 1; // [0:5]\nb = 2;\n/* [B] */\nc = 3;\n/* */\nd = 4;"
    assert plan(tmp_path, source).render() == (
        "/* [A] */\n// cap\na = 1; // [0:5]\nb = 2;\n\n/* [B] */\nc = 3;\n\n/* */\nd = 4;\n"
    )


def test_read_before_first_assignment_is_an_error(tmp_path: Path) -> None:
    with pytest.raises(CustomizerError, match=r"main\.scad:1:1: reads 'y' before"):
        plan(tmp_path, "x = y;\ny = 1;")


@pytest.mark.parametrize(
    "source",
    [
        "y = 1;\nx = y;",
        "a = 1;\nx = a;\na = 2;",
        "x = function() y;\ny = 1;",
        "module m() echo(y);\ny = 1;",
        "x = let(y = 2) y;\ny = 1;",
        "x = 1;\ny = x;",
    ],
    ids=["after", "reassigned-later", "function-literal", "module-body", "shadowed", "other-name"],
)
def test_reads_that_hoisting_cannot_change_are_fine(tmp_path: Path, source: str) -> None:
    plan(tmp_path, source)


def test_read_by_a_hoisted_assignment_is_not_an_error(tmp_path: Path) -> None:
    plan(tmp_path, "y = 1;\nx = y + 1;\nx = 5;\ny = 2;")


# Cross-check against a real openscad: every case must expose the same parameters, and the
# hoisted block in front of the original source (with the hoisted assignments and the group
# markers removed) must expose them again.
RAW_CASES = {
    "kinds": r"""
/* [Tab One] */
// width description
width = 10; // [5:50]
// height
height = 2.5e1;
neg = -3;
pos = +4;
hx = 0x1F;
name = "hello"; // [hello, world]
flag = true;
off = false;

// a vector
vec = [1, 2, 3];
mat = [[1,2],[3,4]];
mixed = [1, "a"];
expr = 1 + 2;
ref = width;
und = undef;
$fn = 32;
dup = 1;
dup = 2;
paren = (3);
strvec = ["a","b"];
rng = [0:5];
fl = .5;

/* [Tab Two] */
// second
second = 5;
function f() = 1;
after = 3;
re = 1;
re = 2;
""",
    "widgets": r"""
// desc one
// desc two
multi = 1;

// separated by blank

sep = 2;
/* block desc */
blk = 3;
tr = 4; // trailing note
sl = 5; // [0:10]
sl2 = 6; // [0:2:10]
sl3 = 6; // [0:2:10] after
opts = 7; // [5, 6, 7]
opts2 = 7; // [5:five, 6:six, 7:seven]
sopts = "a"; // [a:Alpha, b:Beta]
big = 7; /* [0:10] */
vslider = [1,2,3]; // [0:10]
txt = "x"; // 20
/* [Hidden] */
hid = 1;
/* [Global] */
glob = 2;
""",
    "forms": r"""
p1 = (-3);
p2 = -(3);
p3 = [(1), 2];
p4 = [-1, +2];
p5 = !true;
p6 = [];
p7 = [true, false];
p8 = ((3));
p9 = - -3;
p10 = [1, 2, 3, 4, 5];
p11 = "a" ;
p12 = 1e3;
p13 = 1.;
p15 = [1, [2]];
p16 = -[1,2];
p18 = "esc\"aped";
p19 = [1,2,]; 
p20 = 0x10 ;
p21 = 5 /*c*/;
p22 = true;
p23 = 07;
p24 = -0x10;
p25 = [0x10, 1e2];
p26 = 1  // [0:5]
;
q4 = [1,2,3,4];
q1 = [1];
qb = [1, true];
qn = [-(1), 2];
qsign = -+-1;
k1 = (true);
k2 = ("a");
k4 = +[1,2];
k5 = ([1,2]);
""",
    "groups": r"""
// order probe
a = 1;
b = 2;
a = 3;
x = 1; /* [G1] */
y = 2;
/* [G2] */
z = 3;
/* block */
w = 4;
// [G3]
v = 5;
/*[G4]*/
u = 6;
/* [ G5 ] */
t = 7;
/* [Hidden] */
h1 = 1;
/* [Shown] */
s1 = 1;
/* [hidden] */
h2 = 2;
/* [G6] */ g6 = 1;
/* [G7] */
/* [G8] */
g8 = 1;
/* [G9] extra */
g9 = 1;
/* text [G10] */
g10 = 1;
/** [G11] */
g11 = 1;
/* */
g12 = 1;
/* [G13] */
/* multi
line */
g13 = 1;
/* [] */
g14 = 1;
//* [G15] */
g15 = 1;
/* [G16 */
g16 = 1;
/* [G17] */
// cap17
g17 = 1;
/* [G18] */ /* [G19] */
g19 = 1;
/* [Global] */
g20 = 1;
/* [Tab, with comma: x] */
g21 = 1;
""",
    "duplicates": r"""
/* [A] */
// cap1
re = 1; // [0:5]
/* [B] */
// cap2
re = 2; // [0:9]
r2 = 1; // trailing
r3 = 2;
r4 = [1,
   2]; // [0:3]
// cap5
r5 = [1, // [0:4]
  2];
   //   spaced caption   
r6 = 1;
r7 = 1;/* [C] */// cap-after
r8 = 1;
// c1
/* [D] */
r9 = 1;
/* [Hidden] */
hd = 1;
/* [E] */
hd = 2;
/* [Hidden] */
hd2 = 1;
hd2 = 2; // [0:2]
/* [F] */
hd3 = 1;
/* [Hidden] */
hd3 = 3;
""",
    "layout": r"""
include <inc.scad>
ia = 1;
nl1 = 1;
nl1 = ia;
nl2 = ia;
nl2 = 2;
// plain
   // indented
n1 = 1;
// trailing space   
n2 = 1;
//no space
n3 = 1;
	// tab indented
n4 = 1;
n5 = 1; n6 = 2; // [0:3]
n7 = 1; // [0:3]  
n8 = 1; //[0:3]
n9 = "s"; // 20
n10 = "s"; // [a:b]
n11 = 5; // [1, 2, 3.5]
// cap
m1 = 1; m2 = 2;
// cap b
m3 = 1; /* [Z] */ m4 = 2;
m5 = 1;
x = 1;
module m() {}
nl3 = 1;
""",
    "cutoff": r"""
include <inc_brace.scad>
b1 = 1;
s = "/* [S] */";
b2 = 1;
// foo /* [L] */
b3 = 1;
c1 = "a{b";
c2 = 2;
c3 = 3; module m() {
c4 = 4;
}
c5 = 5;
re = 1;
""",
    "reassign": r"""
d1 = 1;
d2 = 2;
d3 = [1,
  2];
d4 = 3; d5 = 4;
d6 = 1; d6 = 2; module q() {} d6 = 3;
keep = 1;
module q2() {
}
keep = 2;
gone = 1;
module q3() {}
""",
    "include-order": r"""
x1 = 1;
include <inc_y.scad>
x2 = 1;
iy = 2;
// cap
m1 = 1; m2 = 2;
module m() {
}
""",
}


CASES = {name: text.removeprefix("\n") for name, text in RAW_CASES.items()}


def openscad_params(path: Path) -> list[dict[str, object]]:
    out = path.with_suffix(".param")
    subprocess.run(  # noqa: S603
        ["openscad", "-o", str(out), str(path)],  # noqa: S607
        check=True,
        capture_output=True,
    )
    return list(json.loads(out.read_text())["parameters"])


def removals(source: str, result: HoistPlan, main: Path) -> list[tuple[int, int]]:
    """Hoisted statements, includes (their hoisted assignments are dropped from the bundle), and
    single-line block comments, which could mark groups."""
    dropped = {start for path, start in result.dropped if path == main.resolve()}
    spans = [
        (s.start, s.end)
        for s in parse(source).stmts
        if s.start in dropped or isinstance(s, ast.Include)
    ]
    spans += [
        (t.start, t.end)
        for t in lex(source)
        if t.kind is Kind.COMMENT and t.text.startswith("/*") and "\n" not in t.text
    ]
    merged: list[tuple[int, int]] = []
    for start, end in sorted(spans):
        if merged and start < merged[-1][1]:
            merged[-1] = (merged[-1][0], max(end, merged[-1][1]))
        else:
            merged.append((start, end))
    return merged


def bundled(source: str, result: HoistPlan, main: Path) -> str:
    rest = source
    for start, end in reversed(removals(source, result, main)):
        rest = rest[:start] + rest[end:]
    return f"{result.render()}\n/* [Hidden] */\n{rest}"


@pytest.mark.oracle
@pytest.mark.skipif(shutil.which("openscad") is None, reason="openscad is not installed")
@pytest.mark.parametrize("case", CASES)
def test_matches_openscad(tmp_path: Path, case: str) -> None:
    source = CASES[case]
    result = plan(tmp_path, source)
    main = tmp_path / "main.scad"
    original = openscad_params(main)
    assert [p.name for p in result.params] == [str(p["name"]) for p in original]
    assert [p.group for p in result.params] == [p.get("group") for p in original]
    twin = tmp_path / "twin.scad"
    twin.write_text(bundled(source, result, main))
    assert openscad_params(twin) == original
