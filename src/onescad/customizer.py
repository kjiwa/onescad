"""Emulates which top-level assignments OpenSCAD's Customizer exposes, and plans hoisting them.

The rules were probed against `openscad -o x.param`; tests/test_customizer.py cross-checks them
whenever openscad is on PATH.
"""

import re
from bisect import bisect_left, bisect_right
from dataclasses import dataclass
from pathlib import Path

from onescad import syntax as ast
from onescad.lexer import TRIVIA, Kind, Token, lex, line_col
from onescad.loader import Graph, SourceFile
from onescad.resolver import Kind as RefKind
from onescad.resolver import Resolution, Unresolved, flatten

DEFAULT_GROUP = "Parameters"
HIDDEN_GROUP = "Hidden"
_MAX_VECTOR = 4
_GROUP_MARKER = re.compile(r"\[([^\]]*)\]")


class CustomizerError(Exception):
    pass


@dataclass(frozen=True)
class Param:
    name: str
    group: str | None
    leading: str
    text: str
    trailing: str


@dataclass(frozen=True)
class HoistPlan:
    params: tuple[Param, ...]
    # (file, start) of every top-level assignment to a hoisted name, parameters included.
    dropped: frozenset[tuple[Path, int]]

    def render(self) -> str:
        """The hoisted block. Group markers are regenerated because reordering would strand the
        originals."""
        out: list[str] = []
        previous: tuple[str | None] | None = None
        for param in self.params:
            if previous != (param.group,):
                out.append(("\n" if previous else "") + _marker(param.group))
                previous = (param.group,)
            out.append(f"{param.leading}{param.text}{param.trailing}\n")
        return "".join(out)


def _marker(group: str | None) -> str:
    # `/* */` is the comment form that leaves a parameter without a group.
    return "/* */\n" if group is None else f"/* [{group}] */\n"


class _Lines:
    def __init__(self, source: str) -> None:
        self._starts = [0] + [m.end() for m in re.finditer("\n", source)]

    def of(self, pos: int) -> int:
        return bisect_right(self._starts, pos)

    def count(self) -> int:
        return len(self._starts)


@dataclass(frozen=True)
class _Scan:
    lines: _Lines
    cutoff: int
    groups: list[str | None]
    # Line comments by line, and the lines on which they start in column 0.
    comments: dict[int, Token]
    banners: frozenset[int]
    code: dict[int, list[tuple[int, int]]]


def _scan(source: str) -> _Scan:
    lines = _Lines(source)
    tokens = lex(source)
    comments: dict[int, Token] = {}
    code: dict[int, list[tuple[int, int]]] = {}
    for token in tokens:
        line = lines.of(token.start)
        if token.kind is Kind.COMMENT and token.text.startswith("//"):
            comments.setdefault(line, token)
        elif token.kind not in TRIVIA and token.kind is not Kind.EOF:
            code.setdefault(line, []).append((token.start, token.end))
    banners = frozenset(
        line for line, token in comments.items() if token.start == _line_start(source, token.start)
    )
    return _Scan(
        lines, _cutoff(tokens, lines), _group_states(tokens, lines), comments, banners, code
    )


def _line_start(source: str, pos: int) -> int:
    return source.rfind("\n", 0, pos) + 1


def _cutoff(tokens: list[Token], lines: _Lines) -> int:
    """The first line holding a `{` token, a `{` inside a string included; params end before it."""
    for token in tokens:
        if token.kind in (Kind.OP, Kind.STRING) and "{" in token.text:
            return lines.of(token.start)
    return lines.count() + 1


def _group_states(tokens: list[Token], lines: _Lines) -> list[str | None]:
    """`states[n]` is the group in force at the start of line n. A single-line block comment sets
    the group from the line after it: to the bracketed text, or to none when there is none."""
    directives: dict[int, str | None] = {}
    for token in tokens:
        if token.kind is Kind.COMMENT and token.text.startswith("/*") and "\n" not in token.text:
            found = _GROUP_MARKER.search(token.text)
            directives[lines.of(token.start)] = (found[1].strip() or None) if found else None
    states: list[str | None] = [DEFAULT_GROUP, DEFAULT_GROUP]
    for line in range(1, lines.count() + 1):
        states.append(directives.get(line, states[line]))
    return states


def _is_number(expr: ast.Expr) -> bool:
    if isinstance(expr, ast.Paren):
        return _is_number(expr.inner)
    if isinstance(expr, ast.Unary):
        return expr.op in ("+", "-") and _is_number(expr.operand)
    return isinstance(expr, ast.Number)


def _is_literal(expr: ast.Expr) -> bool:
    """What the Customizer accepts as a value. Parentheses and unary plus are transparent; unary
    minus only applies to numbers."""
    if isinstance(expr, ast.Paren):
        return _is_literal(expr.inner)
    if isinstance(expr, ast.Unary):
        return _is_literal(expr.operand) if expr.op == "+" else _is_number(expr)
    if isinstance(expr, ast.Vector):
        return 1 <= len(expr.elements) <= _MAX_VECTOR and all(map(_is_number, expr.elements))
    if isinstance(expr, ast.Keyword):
        return expr.text in ("true", "false")
    return isinstance(expr, ast.Number | ast.String)


def plan_hoist(graph: Graph, refs: Resolution) -> HoistPlan:
    root = graph.main.root
    main = graph.files[root]
    scan = _scan(main.source)
    stream = list(flatten(graph, root, main.tree.stmts))
    first: dict[str, int] = {}
    last: dict[str, tuple[SourceFile, ast.Assign]] = {}
    for index, (source, stmt) in enumerate(stream):
        if isinstance(stmt, ast.Assign):
            first.setdefault(stmt.name, index)
            last[stmt.name] = (source, stmt)
    params = [
        _param(main, last[name][1], scan)
        for name in sorted(first, key=first.__getitem__)
        if _exposed(last[name][0], last[name][1], main, scan)
    ]
    hoisted = {p.name for p in params}
    dropped = frozenset(
        (source.path, stmt.start)
        for source, stmt in stream
        if isinstance(stmt, ast.Assign) and stmt.name in hoisted
    )
    _check_reads(stream, {n: first[n] for n in hoisted}, dropped, refs)
    return HoistPlan(tuple(params), dropped)


def _exposed(source: SourceFile, stmt: ast.Assign, main: SourceFile, scan: _Scan) -> bool:
    line = scan.lines.of(stmt.start)
    return (
        source is main
        and line < scan.cutoff
        and _is_literal(stmt.value)
        and scan.groups[line] != HIDDEN_GROUP
    )


def _param(main: SourceFile, stmt: ast.Assign, scan: _Scan) -> Param:
    line = scan.lines.of(stmt.start)
    return Param(
        name=stmt.name,
        group=scan.groups[line],
        leading=_leading(line, scan),
        text=main.source[stmt.start : stmt.end],
        trailing=_trailing(stmt, scan),
    )


def _leading(line: int, scan: _Scan) -> str:
    """The run of column-0 `//` lines directly above: Customizer reads the last as the caption."""
    first = line
    while first - 1 in scan.banners:
        first -= 1
    return "".join(f"{scan.comments[n].text}\n" for n in range(first, line))


def _trailing(stmt: ast.Assign, scan: _Scan) -> str:
    """A line comment after the statement, which Customizer reads as a widget, but only when the
    statement is alone on one line: a second statement or a second line voids it."""
    line = scan.lines.of(stmt.start)
    if scan.lines.of(stmt.end - 1) != line:
        return ""
    if any(not stmt.start <= s < stmt.end for s, _ in scan.code.get(line, [])):
        return ""
    comment = scan.comments.get(line)
    return f" {comment.text}" if comment and comment.start >= stmt.end else ""


def _check_reads(
    stream: list[tuple[SourceFile, ast.Stmt]],
    first: dict[str, int],
    dropped: frozenset[tuple[Path, int]],
    refs: Resolution,
) -> None:
    """Hoisting defines a name before its first assignment; a kept assignment above that point
    reading the name saw undef before and would see the value now."""
    forward = _forward_reads(refs, set(first))
    for index, (source, stmt) in enumerate(stream):
        if not isinstance(stmt, ast.Assign) or (source.path, stmt.start) in dropped:
            continue
        reads = forward.get(source.path, [])
        for _, name in reads[
            bisect_left(reads, (stmt.start, "")) : bisect_left(reads, (stmt.end, ""))
        ]:
            if index < first[name]:
                line, col = line_col(source.source, stmt.start)
                raise CustomizerError(
                    f"{source.path}:{line}:{col}: reads '{name}' before its first assignment; "
                    "hoisting the Customizer parameters would change its value"
                )


def _forward_reads(refs: Resolution, names: set[str]) -> dict[Path, list[tuple[int, str]]]:
    """Sorted positions and names of reads of `names` that currently evaluate to undef."""
    reads: dict[Path, list[tuple[int, str]]] = {}
    for ref, targets in refs.items():
        if ref.kind is RefKind.VARIABLE and ref.name in names and Unresolved() in targets:
            reads.setdefault(ref.file, []).append((ref.start, ref.name))
    for found in reads.values():
        found.sort()
    return reads
