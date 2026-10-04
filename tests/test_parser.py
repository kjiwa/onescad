from dataclasses import fields
from pathlib import Path

import pytest

from onescad import syntax as ast
from onescad.lexer import ScadSyntaxError
from onescad.parser import parse

CORPUS = Path(__file__).parent / "corpus" / "BOSL2"
CORPUS_FILES = sorted(CORPUS.rglob("*.scad"))


def sexp(node: object) -> str:
    """Compact structural rendering, without spans."""
    if isinstance(node, ast.Node):
        parts = [type(node).__name__]
        parts += [
            sexp(getattr(node, f.name)) for f in fields(node) if f.name not in ("start", "end")
        ]
        return "(" + " ".join(parts) + ")"
    if isinstance(node, tuple):
        return "[" + " ".join(sexp(n) for n in node) + "]"
    return "-" if node is None else str(node)


def expr(text: str) -> str:
    (stmt,) = parse(f"x = {text};").stmts
    assert isinstance(stmt, ast.Assign)
    return sexp(stmt.value)


def stmt(text: str) -> str:
    (node,) = parse(text).stmts
    return sexp(node)


@pytest.mark.parametrize("path", CORPUS_FILES, ids=lambda p: str(p.relative_to(CORPUS)))
def test_corpus_parses(path: Path) -> None:
    parse(path.read_bytes().decode("utf-8"))


def test_spans_slice_the_source() -> None:
    source = "// c\nmodule m(a = 1) { cube(a); }\n"
    (module,) = parse(source).stmts
    assert source[module.start : module.end] == "module m(a = 1) { cube(a); }"
    assert isinstance(module, ast.ModuleDef)
    assert isinstance(module.body, ast.Block)
    assert source[module.body.start : module.body.end] == "{ cube(a); }"


def test_postfix_spans() -> None:
    source = "x = f(1)[0].y ;"
    (assign,) = parse(source).stmts
    assert isinstance(assign, ast.Assign)
    assert source[assign.value.start : assign.value.end] == "f(1)[0].y"


def test_include_and_use() -> None:
    assert stmt("include <a/b.scad>") == "(Include a/b.scad)"
    assert stmt("use <a.scad>") == "(Use a.scad)"


def test_include_in_module_body() -> None:
    assert stmt("module m() { include <a.scad> }") == (
        "(ModuleDef m [] (Block [(Include a.scad)] ))"
    )


def test_definitions() -> None:
    assert stmt("function f(a, b = 2,) = a + b;") == (
        "(FunctionDef f [(Param a -) (Param b (Number 2))] (Binary + (Ident a) (Ident b)))"
    )
    assert stmt("module m(a) cube(a);") == (
        "(ModuleDef m [(Param a -)] (ModuleCall cube [(Arg - (Ident a))] (Empty) ))"
    )


def test_dollar_assignment() -> None:
    assert stmt("$fn = 64;") == "(Assign $fn (Number 64))"


def test_if_else_chain() -> None:
    out = stmt("if (a) x(); else if (b) y(); else z();")
    assert out.count("(If ") == 2
    assert "(ModuleCall z [] (Empty) " in out


@pytest.mark.parametrize("mods", ["!", "#", "%", "*", "!#"])
def test_modifiers(mods: str) -> None:
    assert stmt(f"{mods}cube(1);").endswith(f" {mods})")
    assert stmt(f"{mods}{{ }}") == f"(Block [] {mods})"


def test_modifier_on_if() -> None:
    assert stmt("#if (a) b();").endswith(" #)")


def test_for_with_multiple_variables() -> None:
    out = stmt("for (i = [0:2], j = [1:3]) translate([i, j]) cube();")
    assert out.startswith("(ModuleCall for [(Arg i (Range") and "(Arg j (Range" in out


def test_intersection_for_and_statement_let() -> None:
    assert stmt("intersection_for (i = [0:1]) f(i);").startswith("(ModuleCall intersection_for")
    assert stmt("let (a = 1) f(a);").startswith("(ModuleCall let [(Arg a")


def test_empty_statement() -> None:
    assert stmt(";") == "(Empty)"


def test_binary_precedence() -> None:
    assert expr("1 + 2 * 3") == "(Binary + (Number 1) (Binary * (Number 2) (Number 3)))"
    assert expr("a || b && c") == "(Binary || (Ident a) (Binary && (Ident b) (Ident c)))"
    assert expr("a < b == c") == "(Binary == (Binary < (Ident a) (Ident b)) (Ident c))"
    assert expr("a | b & c << d") == (
        "(Binary | (Ident a) (Binary & (Ident b) (Binary << (Ident c) (Ident d))))"
    )


def test_binary_is_left_associative() -> None:
    assert expr("a - b - c") == "(Binary - (Binary - (Ident a) (Ident b)) (Ident c))"


def test_power_binds_above_unary_minus() -> None:
    assert expr("-2 ^ 2") == "(Unary - (Binary ^ (Number 2) (Number 2)))"
    assert expr("2 ^ -1") == "(Binary ^ (Number 2) (Unary - (Number 1)))"
    assert expr("a ^ b ^ c") == "(Binary ^ (Ident a) (Binary ^ (Ident b) (Ident c)))"


def test_unary_operators() -> None:
    assert expr("!~+a") == "(Unary ! (Unary ~ (Unary + (Ident a))))"


def test_ternary_is_right_associative() -> None:
    assert expr("a ? b : c ? d : e") == (
        "(Ternary (Ident a) (Ident b) (Ternary (Ident c) (Ident d) (Ident e)))"
    )


def test_chained_postfix() -> None:
    assert expr("f(1)[2].x(3)") == (
        "(Call (Member (Index (Call (Ident f) [(Arg - (Number 1))]) (Number 2)) x) "
        "[(Arg - (Number 3))])"
    )


def test_named_arguments() -> None:
    assert expr("f(a = 1, 2,)") == "(Call (Ident f) [(Arg a (Number 1)) (Arg - (Number 2))])"


def test_literals() -> None:
    assert expr('[true, false, undef, "s", 1e3, 3d]') == (
        '(Vector [(Keyword true) (Keyword false) (Keyword undef) (String "s") (Number 1e3) '
        "(Ident 3d)])"
    )


def test_ranges() -> None:
    assert expr("[0:5]") == "(Range (Number 0) - (Number 5))"
    assert expr("[0:2:10]") == "(Range (Number 0) (Number 2) (Number 10))"
    assert expr("[a ? 1 : 2 : 3]") == (
        "(Range (Ternary (Ident a) (Number 1) (Number 2)) - (Number 3))"
    )


def test_empty_and_trailing_comma_vectors() -> None:
    assert expr("[]") == "(Vector [])"
    assert expr("[1, 2,]") == "(Vector [(Number 1) (Number 2)])"


def test_function_literal() -> None:
    assert expr("function(a, b = 1) a + b") == (
        "(FunctionLiteral [(Param a -) (Param b (Number 1))] (Binary + (Ident a) (Ident b)))"
    )
    assert expr("(function(a) a)(1)").startswith("(Call (Paren (FunctionLiteral")


def test_let_expression() -> None:
    assert expr("let (a = 1, b = 2) a + b").startswith("(Let [(Arg a (Number 1)) (Arg b")


def test_assert_and_echo_expressions() -> None:
    assert expr('assert(a, "m") a') == '(Assert [(Arg - (Ident a)) (Arg - (String "m"))] (Ident a))'
    assert expr("echo(a) a") == "(Echo [(Arg - (Ident a))] (Ident a))"
    assert expr("assert(a)") == "(Assert [(Arg - (Ident a))] -)"


def test_comprehension_for() -> None:
    assert expr("[for (i = [0:2]) i * 2]") == (
        "(Vector [(ListFor [(Arg i (Range (Number 0) - (Number 2)))] "
        "(Binary * (Ident i) (Number 2)))])"
    )


def test_comprehension_for_multiple_variables() -> None:
    out = expr("[for (i = a, j = b) [i, j]]")
    assert out.startswith("(Vector [(ListFor [(Arg i (Ident a)) (Arg j (Ident b))]")


def test_comprehension_c_style_for() -> None:
    assert expr("[for (i = 0; i < 3; i = i + 1) i]") == (
        "(Vector [(ListForC [(Arg i (Number 0))] (Binary < (Ident i) (Number 3)) "
        "[(Arg i (Binary + (Ident i) (Number 1)))] (Ident i))])"
    )


def test_comprehension_if_else() -> None:
    assert expr("[for (i = a) if (i) 1 else 2]").endswith(
        "(ListIf (Ident i) (Number 1) (Number 2)))])"
    )
    assert expr("[for (i = a) if (i) i]").endswith("(ListIf (Ident i) (Ident i) -))])")


def test_comprehension_let_and_each() -> None:
    assert expr("[for (i = a) let (j = i) j]").count("(Let ") == 1
    assert expr("[each a, each [1, 2]]") == (
        "(Vector [(ListEach (Ident a)) (ListEach (Vector [(Number 1) (Number 2)]))])"
    )


def test_each_over_generator() -> None:
    assert expr("[each for (i = a) [i]]").startswith("(Vector [(ListEach (ListFor")


def test_parenthesized_generators() -> None:
    assert expr("[(for (i = a) i), (if (b) 1)]").count("(Paren (List") == 2


def test_generator_in_let_body() -> None:
    assert expr("[let (a = 1) for (i = [0:a]) i]").startswith("(Vector [(Let [(Arg a")


def test_nested_comprehensions() -> None:
    assert expr("[for (i = a) for (j = b) i + j]").count("(ListFor") == 2


@pytest.mark.parametrize(
    "source",
    ["x = ;", "x = 1", "module () {}", "a(", "x = [1 2];", "if a b();", "{", "x = f(;"],
)
def test_syntax_errors(source: str) -> None:
    with pytest.raises(ScadSyntaxError):
        parse(source)
