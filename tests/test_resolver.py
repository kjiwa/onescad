from pathlib import Path

import pytest

from onescad.loader import load
from onescad.resolver import Kind, Local, Resolution, TopLevel, Unresolved, resolve

CORPUS = Path(__file__).parent / "corpus"
V, F, M = Kind.VARIABLE, Kind.FUNCTION, Kind.MODULE

SUPPORT = {
    "a.scad": (
        'av = "a-var";\n'
        "function f(x) = [1, x];\n"
        "function ga() = av;\n"
        "function gafn() = f(0);\n"
        "module am() echo(av);\n"
        "module cube(s) echo(s);\n"
    ),
    "b.scad": "function f(x) = [2, x];\nfunction gb() = f(0);\n",
    "inc.scad": "function from_inc() = 1;\n",
    "c.scad": (
        "include <inc.scad>\nuse <a.scad>\n"
        "function gc() = ga();\nfunction via_a() = f(1);\ncv = 3;\n"
    ),
    "i.scad": "iv = 1;\n",
}


def describe(targets: frozenset[object]) -> set[str]:
    out = set()
    for target in targets:
        if isinstance(target, Local):
            out.add("local")
        elif isinstance(target, TopLevel):
            out.add(f"{target.namespace.stem}:{target.kind.name[0]}")
        else:
            assert isinstance(target, Unresolved)
            out.add("?")
    return out


def resolved(tmp_path: Path, source: str, libs: tuple[Path, ...] = ()) -> Resolution:
    for name, text in SUPPORT.items():
        (tmp_path / name).write_text(text)
    main = tmp_path / "main.scad"
    main.write_text(source)
    return resolve(load(main, libs, {}))


def last_ref(refs: Resolution, name: str, kind: Kind, file: str) -> frozenset[object]:
    matches = [r for r in refs if r.name == name and r.kind is kind and r.file.name == file]
    assert matches, f"no {kind.name} reference to {name} in {file}"
    return refs[max(matches, key=lambda r: r.start)]


# One row per probed lookup rule. The probed reference is the last one of its name and kind in
# the file; `expected` lists the possible targets as "local", "<namespace>:<V|F|M>" or "?".
VARIABLE_ROWS = [
    # top-level order
    ("forward-ref-is-undef", "a = b; b = 1;", "b", "?"),
    ("backward-ref-binds", "b = 1; a = b;", "b", "main:V"),
    ("self-ref-is-undef", "a = a + 1;", "a", "?"),
    ("reassign-binds-first-position", "c = 1; d = c; c = 2;", "c", "main:V"),
    ("instantiation-sees-later", "echo(x); x = 5;", "x", "main:V"),
    ("module-body-sees-later", "module m() echo(x); x = 1;", "x", "main:V"),
    ("function-body-sees-later", "function g() = y; z = g(); y = 7;", "y", "main:V"),
    ("function-literal-sees-later", "fl = function() late; late = 4;", "late", "main:V"),
    ("list-comprehension-is-immediate", "a = [for (i = [0]) later]; later = 1;", "later", "?"),
    ("let-body-is-immediate", "b = let(q = 1) lat + q; lat = 1;", "lat", "?"),
    # local scopes
    ("local-rhs-sees-earlier-only", "v = 100; module m() { p = v; v = 1; }", "v", "main:V"),
    ("local-rhs-forward-falls-outward", "module m() { q = r; r = 2; }", "r", "?"),
    ("local-child-sees-later", "module m() { echo(w); w = 3; }", "w", "local"),
    ("param-seen-by-later-rhs", "module m(a = 1) { b = a; a = 2; }", "a", "local"),
    ("module-body-assignment-beats-top", "v = 1; module m() { v = 2; echo(v); }", "v", "local"),
    ("module-arg-sees-later-caller-local", "module m() { n(lv); lv = 9; }", "lv", "local"),
    ("bare-block-merges-into-module", "module f() { { y = 2; } echo(y); }", "y", "local"),
    ("bare-block-merges-at-top-level", "{ bv = 1; } echo(bv);", "bv", "main:V"),
    ("call-block-is-a-scope", "module r() { translate([0]) { zz = 1; } echo(zz); }", "zz", "?"),
    ("if-block-is-a-scope", "module g() { if (true) { x = 2; } echo(x); }", "x", "?"),
    ("else-block-is-a-scope", "module g() { if (false) { } else { x = 2; } echo(x); }", "x", "?"),
    (
        "include-splices-into-module-body",
        "module m() { include <i.scad>\n echo(iv); }",
        "iv",
        "local",
    ),
    ("nested-function-sees-outer-local", "module m() { k = 3; function g() = k; }", "k", "local"),
    # default arguments bind in the definition scope
    ("module-default-skips-params", "module e(a = 1, b = a) { }", "a", "?"),
    ("module-default-sees-top-not-param", "d = 1; module e(d = 3, b = d) { }", "d", "main:V"),
    ("function-default-skips-params", "function f(a, b = a) = b;", "a", "?"),
    # sequential binders
    ("for-variables-are-sequential", "for (i = [1], j = i) echo(j);", "i", "local"),
    ("module-let-is-sequential", "let(i = 1, j = i) echo(j);", "i", "local"),
    ("let-expression-is-sequential", "x = let(s = 1, t = s + 1) t;", "s", "local"),
    ("let-binding-visible-to-child", "let(i = 1) echo(i);", "i", "local"),
    ("for-variable-is-gone-after-loop", "for (i = [0]) echo(i); echo(i);", "i", "?"),
    ("list-for-is-sequential", "x = [for (i = [1:2], j = [i]) j];", "i", "local"),
    ("list-for-variable-is-gone-after", "v = 100; x = [for (v = [1]) v]; y = v;", "v", "main:V"),
    ("c-style-for-body-sees-init", "x = [for (a = 0; a < 2; a = a + 1) a];", "a", "local"),
    ("function-literal-param", "x = function(n) n + 1;", "n", "local"),
    ("function-literal-captures-definition", "v = 1; fl = function(n) n + v;", "v", "main:V"),
    # use: only functions and modules cross
    ("used-variable-invisible", "use <a.scad>\necho(av);", "av", "?"),
    ("variable-namespace-ignores-module", "cube = 3; echo(cube);", "cube", "main:V"),
]

FUNCTION_ROWS = [
    (
        "function-beats-variable-in-scope",
        "function h() = 1; h = function() 2; echo(h());",
        "h",
        "main:F",
    ),
    (
        "local-variable-beats-outer-function",
        "function k() = 1; module m() { k = 3; echo(k()); }",
        "k",
        "local main:F",
    ),
    (
        "local-function-beats-variable",
        "module m() { function ff() = 1; ff = 2; echo(ff()); }",
        "ff",
        "local",
    ),
    (
        "param-skipped-when-not-function",
        "function o(x) = x; function p(o) = o(3);",
        "o",
        "local main:F",
    ),
    (
        "local-function-beats-top-function",
        "function t() = 1; module m() { function t() = 2; echo(t()); }",
        "t",
        "local",
    ),
    ("builtin-falls-through", "echo(sin(0));", "sin", "?"),
    ("variable-skipped-for-builtin", "sin = 5; echo(sin(90));", "sin", "main:V ?"),
    ("param-skipped-for-builtin", "function lf(cos) = cos(0);", "cos", "local ?"),
    ("redefinition-collapses", "function d() = 1; function d() = 2; echo(d());", "d", "main:F"),
    (
        "function-vs-module-namespaces",
        "function n() = 1; module n() echo(); echo(n());",
        "n",
        "main:F",
    ),
    ("callee-expression-is-walked", "function f(a) = a; v = f(1)(2);", "f", "main:F"),
    (
        "recursion-binds-to-self",
        "function fact(n) = n <= 1 ? 1 : n * fact(n - 1);",
        "fact",
        "main:F",
    ),
    ("call-in-default-binds-outward", "function g() = 1; module m(a = g()) { }", "g", "main:F"),
    # use
    ("use-last-wins", "use <a.scad>\nuse <b.scad>\necho(f(1));", "f", "b:F"),
    ("use-after-use", "use <b.scad>\nuse <a.scad>\necho(f(1));", "f", "a:F"),
    ("use-takes-effect-file-wide", "echo(f(2));\nuse <b.scad>", "f", "b:F"),
    ("own-function-beats-used", "use <a.scad>\nfunction ga() = 0;\necho(ga());", "ga", "main:F"),
    ("own-variable-kept-alongside-used", "use <a.scad>\nf = 5;\necho(f(1));", "f", "main:V a:F"),
    ("used-function-beats-builtin-variable-chain", "use <a.scad>\necho(f(1));", "f", "a:F"),
    ("nested-use-not-re-exported", "use <c.scad>\necho(ga());", "ga", "?"),
    ("include-in-used-file-is-exported", "use <c.scad>\necho(from_inc());", "from_inc", "c:F"),
]

MODULE_ROWS = [
    ("module-binds-top-level", "module m() { } m();", "m", "main:M"),
    ("module-defined-later", "m(); module m() { }", "m", "main:M"),
    ("variable-does-not-shadow-module", "cube = 3; cube(1);", "cube", "?"),
    ("local-module-beats-top", "module t() { } module m() { module t() { } t(); }", "t", "local"),
    ("used-module-beats-builtin", "use <a.scad>\ncube(1);", "cube", "a:M"),
    ("own-module-beats-used", "use <a.scad>\nmodule am() { }\nam();", "am", "main:M"),
    ("used-module", "use <a.scad>\nam();", "am", "a:M"),
    ("builtin-module", "cube(1);", "cube", "?"),
    ("modifier-leaves-name-alone", "#cube(1);", "cube", "?"),
]


def run_row(tmp_path: Path, row: tuple[str, str, str, str], kind: Kind) -> None:
    _, source, name, expected = row
    got = last_ref(resolved(tmp_path, source), name, kind, "main.scad")
    assert describe(got) == set(expected.split())


@pytest.mark.parametrize("row", VARIABLE_ROWS, ids=lambda r: r[0])
def test_variable_lookup(tmp_path: Path, row: tuple[str, str, str, str]) -> None:
    run_row(tmp_path, row, V)


@pytest.mark.parametrize("row", FUNCTION_ROWS, ids=lambda r: r[0])
def test_function_lookup(tmp_path: Path, row: tuple[str, str, str, str]) -> None:
    run_row(tmp_path, row, F)


@pytest.mark.parametrize("row", MODULE_ROWS, ids=lambda r: r[0])
def test_module_lookup(tmp_path: Path, row: tuple[str, str, str, str]) -> None:
    run_row(tmp_path, row, M)


def test_used_file_sees_its_own_variables(tmp_path: Path) -> None:
    refs = resolved(tmp_path, "use <a.scad>")
    assert describe(last_ref(refs, "av", V, "a.scad")) == {"a:V"}


def test_used_file_resolves_through_its_own_uses(tmp_path: Path) -> None:
    refs = resolved(tmp_path, "use <c.scad>")
    assert describe(last_ref(refs, "ga", F, "c.scad")) == {"a:F"}
    assert describe(last_ref(refs, "f", F, "c.scad")) == {"a:F"}


def test_used_file_does_not_see_the_using_file(tmp_path: Path) -> None:
    refs = resolved(tmp_path, "use <a.scad>\nav = 1;\nfunction f(x) = 0;")
    assert describe(last_ref(refs, "f", F, "a.scad")) == {"a:F"}
    assert describe(last_ref(refs, "av", V, "a.scad")) == {"a:V"}


def test_used_file_variable_does_not_see_main_variable(tmp_path: Path) -> None:
    (tmp_path / "u.scad").write_text("function g() = mv;\n")
    main = tmp_path / "main.scad"
    main.write_text("use <u.scad>\nmv = 1;")
    refs = resolve(load(main, (), {}))
    assert describe(last_ref(refs, "mv", V, "u.scad")) == {"?"}


def test_dynamic_variables_are_not_bound(tmp_path: Path) -> None:
    refs = resolved(tmp_path, "$fn = 3; echo($fn, $t);")
    assert not [r for r in refs if r.name.startswith("$")]


def test_named_argument_names_are_not_references(tmp_path: Path) -> None:
    refs = resolved(tmp_path, "size = 1; cube(size = size, center = true);")
    assert [r.start for r in refs if r.name == "size"] == [len("size = 1; cube(size = ")]
    assert not [r for r in refs if r.name == "center"]


def test_keyword_calls_are_not_module_references(tmp_path: Path) -> None:
    refs = resolved(
        tmp_path, "for (i = [0]) echo(i); let(a = 1) assert(a); intersection_for(j=[0]) a();"
    )
    assert {r.name for r in refs if r.kind is M} == {"a"}


def test_every_reference_points_at_its_token(tmp_path: Path) -> None:
    source = "# cube(1);\n!  sphere(r = q);\nx = f(y)[0] + z.w;\nmodule m() { %child(); }"
    refs = resolved(tmp_path, source)
    assert {r.name for r in refs} == {"cube", "sphere", "q", "f", "y", "z", "child"}
    for ref in refs:
        assert source[ref.start : ref.start + len(ref.name)] == ref.name


def test_repeated_include_unions_its_targets(tmp_path: Path) -> None:
    (tmp_path / "r.scad").write_text("x = rv;\n")
    main_src = "include <r.scad>\nrv = 1;\ninclude <r.scad>\n"
    refs = resolved(tmp_path, main_src)
    assert describe(last_ref(refs, "rv", V, "r.scad")) == {"?", "main:V"}


def test_resolves_bosl2_through_include_and_use(tmp_path: Path) -> None:
    main = tmp_path / "main.scad"
    main.write_text("include <BOSL2/std.scad>\ncuboid(10);")
    refs = resolve(load(main, (CORPUS.resolve(),), {}))
    assert describe(last_ref(refs, "cuboid", M, "main.scad")) == {"main:M"}
    namespaces = {t.namespace.name for ts in refs.values() for t in ts if isinstance(t, TopLevel)}
    assert "builtins.scad" in namespaces
