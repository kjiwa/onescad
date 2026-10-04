"""AST for OpenSCAD. Every node carries the half-open source span [start, end) of its tokens,
excluding surrounding trivia."""

from dataclasses import dataclass


@dataclass(frozen=True, kw_only=True)
class Node:
    start: int
    end: int


@dataclass(frozen=True, kw_only=True)
class Expr(Node):
    pass


@dataclass(frozen=True, kw_only=True)
class Stmt(Node):
    pass


@dataclass(frozen=True, kw_only=True)
class Arg(Node):
    name: str | None
    value: Expr


@dataclass(frozen=True, kw_only=True)
class Param(Node):
    name: str
    default: Expr | None


@dataclass(frozen=True, kw_only=True)
class Number(Expr):
    text: str


@dataclass(frozen=True, kw_only=True)
class String(Expr):
    text: str


@dataclass(frozen=True, kw_only=True)
class Keyword(Expr):
    """`true`, `false` or `undef`."""

    text: str


@dataclass(frozen=True, kw_only=True)
class Ident(Expr):
    name: str


@dataclass(frozen=True, kw_only=True)
class Vector(Expr):
    elements: tuple[Expr, ...]


@dataclass(frozen=True, kw_only=True)
class Range(Expr):
    first: Expr
    step: Expr | None
    last: Expr


@dataclass(frozen=True, kw_only=True)
class Unary(Expr):
    op: str
    operand: Expr


@dataclass(frozen=True, kw_only=True)
class Binary(Expr):
    op: str
    left: Expr
    right: Expr


@dataclass(frozen=True, kw_only=True)
class Ternary(Expr):
    cond: Expr
    then: Expr
    otherwise: Expr


@dataclass(frozen=True, kw_only=True)
class Call(Expr):
    callee: Expr
    args: tuple[Arg, ...]


@dataclass(frozen=True, kw_only=True)
class Index(Expr):
    base: Expr
    index: Expr


@dataclass(frozen=True, kw_only=True)
class Member(Expr):
    base: Expr
    name: str


@dataclass(frozen=True, kw_only=True)
class FunctionLiteral(Expr):
    params: tuple[Param, ...]
    body: Expr


@dataclass(frozen=True, kw_only=True)
class Let(Expr):
    assigns: tuple[Arg, ...]
    body: Expr


@dataclass(frozen=True, kw_only=True)
class Assert(Expr):
    args: tuple[Arg, ...]
    body: Expr | None


@dataclass(frozen=True, kw_only=True)
class Echo(Expr):
    args: tuple[Arg, ...]
    body: Expr | None


@dataclass(frozen=True, kw_only=True)
class Paren(Expr):
    inner: Expr


@dataclass(frozen=True, kw_only=True)
class ListFor(Expr):
    assigns: tuple[Arg, ...]
    body: Expr


@dataclass(frozen=True, kw_only=True)
class ListForC(Expr):
    init: tuple[Arg, ...]
    cond: Expr
    update: tuple[Arg, ...]
    body: Expr


@dataclass(frozen=True, kw_only=True)
class ListIf(Expr):
    cond: Expr
    then: Expr
    otherwise: Expr | None


@dataclass(frozen=True, kw_only=True)
class ListEach(Expr):
    body: Expr


@dataclass(frozen=True, kw_only=True)
class Include(Stmt):
    path: str


@dataclass(frozen=True, kw_only=True)
class Use(Stmt):
    path: str


@dataclass(frozen=True, kw_only=True)
class Assign(Stmt):
    name: str
    value: Expr


@dataclass(frozen=True, kw_only=True)
class ModuleDef(Stmt):
    name: str
    params: tuple[Param, ...]
    body: Stmt


@dataclass(frozen=True, kw_only=True)
class FunctionDef(Stmt):
    name: str
    params: tuple[Param, ...]
    body: Expr


@dataclass(frozen=True, kw_only=True)
class Empty(Stmt):
    pass


@dataclass(frozen=True, kw_only=True)
class Block(Stmt):
    stmts: tuple[Stmt, ...]
    modifiers: str


@dataclass(frozen=True, kw_only=True)
class ModuleCall(Stmt):
    """An instantiation. `for`, `intersection_for`, `let`, `echo` and `assert` are calls too;
    `child` is an `Empty` for a bare `;`."""

    name: str
    args: tuple[Arg, ...]
    child: Stmt
    modifiers: str


@dataclass(frozen=True, kw_only=True)
class If(Stmt):
    cond: Expr
    then: Stmt
    otherwise: Stmt | None
    modifiers: str


@dataclass(frozen=True, kw_only=True)
class File(Node):
    stmts: tuple[Stmt, ...]
