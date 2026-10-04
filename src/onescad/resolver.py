"""Binds every identifier reference to the set of definitions OpenSCAD could pick for it.

Names starting with `$` are dynamic and never bound; named-argument names are not references.
The binding rules were probed against OpenSCAD and are exercised one by one in
tests/test_resolver.py.
"""

import sys
from collections.abc import Iterable, Iterator, Mapping, Sequence
from dataclasses import dataclass
from enum import Enum, auto
from pathlib import Path

from onescad import syntax as ast
from onescad.loader import Graph, Namespace, SourceFile


class Kind(Enum):
    VARIABLE = auto()
    FUNCTION = auto()
    MODULE = auto()


@dataclass(frozen=True)
class Ref:
    """One identifier occurrence: the token at `start` in `file`."""

    file: Path
    start: int
    name: str
    kind: Kind


@dataclass(frozen=True)
class Local:
    """A binder below the top level, identified by its node's position."""

    kind: Kind
    file: Path
    start: int


@dataclass(frozen=True)
class TopLevel:
    """A top-level definition of the namespace rooted at `namespace`, whatever file or include
    it came from: duplicates already collapse by name."""

    namespace: Path
    kind: Kind
    name: str


@dataclass(frozen=True)
class Unresolved:
    """A builtin, or a name that evaluates to undef."""


Target = Local | TopLevel | Unresolved
Resolution = dict[Ref, frozenset[Target]]

_UNRESOLVED = Unresolved()
_ALWAYS = sys.maxsize
# Statement-position calls that bind variables for their child.
_BINDING_CALLS = frozenset({"for", "intersection_for", "let"})
# Keywords that parse as calls but are not module references.
_KEYWORD_CALLS = frozenset({*_BINDING_CALLS, "echo", "assert"})


@dataclass(frozen=True)
class _Binding:
    # Position in the scope's statement sequence; -1 for parameters and loop variables.
    index: int
    target: Target


@dataclass(frozen=True)
class _Scope:
    variables: Mapping[str, _Binding]
    functions: Mapping[str, Target]
    modules: Mapping[str, Target]


@dataclass(frozen=True)
class _Frame:
    scope: _Scope
    # Variables first bound at or after `limit` are not visible: an assignment's right-hand
    # side sees only earlier variables, everything else sees them all.
    limit: int


_Env = tuple[_Frame, ...]
_Sequence = list[tuple[SourceFile, ast.Stmt]]


def resolve(graph: Graph) -> Resolution:
    namespaces = [graph.main, *graph.used]
    tops = {ns.root: _top_scope(graph, ns.root) for ns in namespaces}
    refs: Resolution = {}
    for ns in namespaces:
        _Walker(graph, ns.root, refs).run(tops[ns.root], _imports_scope(ns, tops))
    return refs


def flatten(
    graph: Graph, file: Path, stmts: Iterable[ast.Stmt]
) -> Iterator[tuple[SourceFile, ast.Stmt]]:
    """Splice includes and merge bare `{}` blocks into the enclosing scope, as OpenSCAD does."""
    for source, stmt in graph.splice(file, stmts):
        if isinstance(stmt, ast.Block) and not stmt.modifiers:
            yield from flatten(graph, source.path, stmt.stmts)
        else:
            yield source, stmt


def _target(kind: Kind, name: str, node: ast.Node, file: Path, owner: Path | None) -> Target:
    if owner is not None:
        return TopLevel(owner, kind, name)
    return Local(kind, file, node.start)


def _build_scope(
    seq: _Sequence, params: Sequence[ast.Param], file: Path, owner: Path | None
) -> _Scope:
    variables: dict[str, _Binding] = {}
    functions: dict[str, Target] = {}
    modules: dict[str, Target] = {}
    for param in params:
        target = _target(Kind.VARIABLE, param.name, param, file, owner)
        variables.setdefault(param.name, _Binding(-1, target))
    for index, (source, stmt) in enumerate(seq):
        path = source.path
        if isinstance(stmt, ast.Assign):
            target = _target(Kind.VARIABLE, stmt.name, stmt, path, owner)
            variables.setdefault(stmt.name, _Binding(index, target))
        elif isinstance(stmt, ast.FunctionDef):
            functions[stmt.name] = _target(Kind.FUNCTION, stmt.name, stmt, path, owner)
        elif isinstance(stmt, ast.ModuleDef):
            modules[stmt.name] = _target(Kind.MODULE, stmt.name, stmt, path, owner)
    return _Scope(variables, functions, modules)


def _binders_scope(args: Sequence[ast.Arg], file: Path) -> _Scope:
    variables: dict[str, _Binding] = {}
    for index, arg in enumerate(args):
        if arg.name is not None:
            target = Local(Kind.VARIABLE, file, arg.start)
            variables.setdefault(arg.name, _Binding(index, target))
    return _Scope(variables, {}, {})


def _top_scope(graph: Graph, root: Path) -> _Scope:
    seq = list(flatten(graph, root, graph.files[root].tree.stmts))
    return _build_scope(seq, (), root, root)


def _imports_scope(namespace: Namespace, tops: Mapping[Path, _Scope]) -> _Scope:
    """What the namespace's `use` statements bring in; a later use wins over an earlier one."""
    functions: dict[str, Target] = {}
    modules: dict[str, Target] = {}
    for used in namespace.uses:
        functions.update({n: TopLevel(used, Kind.FUNCTION, n) for n in tops[used].functions})
        modules.update({n: TopLevel(used, Kind.MODULE, n) for n in tops[used].modules})
    return _Scope({}, functions, modules)


def _deferred(env: _Env) -> _Env:
    """The environment for code that runs later, once every variable has been assigned."""
    return tuple(_Frame(frame.scope, _ALWAYS) for frame in env)


def _visible(frame: _Frame, name: str) -> Target | None:
    binding = frame.scope.variables.get(name)
    if binding is not None and binding.index < frame.limit:
        return binding.target
    return None


def _lookup_variable(env: _Env, name: str) -> frozenset[Target]:
    for frame in env:
        if (target := _visible(frame, name)) is not None:
            return frozenset({target})
    return frozenset({_UNRESOLVED})


def _lookup_function(env: _Env, name: str) -> frozenset[Target]:
    """A function beats a variable in the same scope, a variable beats outer functions, and a
    variable that does not hold a function is skipped, so every variable passed stays possible."""
    found: set[Target] = set()
    for frame in env:
        if name in frame.scope.functions:
            found.add(frame.scope.functions[name])
            return frozenset(found)
        if (target := _visible(frame, name)) is not None:
            found.add(target)
    found.add(_UNRESOLVED)
    return frozenset(found)


def _lookup_module(env: _Env, name: str) -> frozenset[Target]:
    for frame in env:
        if name in frame.scope.modules:
            return frozenset({frame.scope.modules[name]})
    return frozenset({_UNRESOLVED})


class _Walker:
    def __init__(self, graph: Graph, root: Path, refs: Resolution) -> None:
        self._graph = graph
        self._root = root
        self._refs = refs
        self._file = root

    def run(self, top: _Scope, imports: _Scope) -> None:
        seq = list(flatten(self._graph, self._root, self._graph.files[self._root].tree.stmts))
        self._sequence(seq, top, (_Frame(imports, _ALWAYS),))

    def _record(self, kind: Kind, name: str, start: int, targets: frozenset[Target]) -> None:
        ref = Ref(self._file, start, name, kind)
        self._refs[ref] = self._refs.get(ref, frozenset()) | targets

    def _sequence(self, seq: _Sequence, scope: _Scope, outer: _Env) -> None:
        saved = self._file
        for index, (source, stmt) in enumerate(seq):
            self._file = source.path
            if isinstance(stmt, ast.Assign):
                self._expr(stmt.value, (_Frame(scope, index), *outer))
            else:
                self._stmt(stmt, (_Frame(scope, _ALWAYS), *outer))
        self._file = saved

    def _stmt(self, stmt: ast.Stmt, env: _Env) -> None:
        if isinstance(stmt, ast.FunctionDef):
            self._callable(stmt.params, stmt.body, env)
        elif isinstance(stmt, ast.ModuleDef):
            self._module_def(stmt, env)
        elif isinstance(stmt, ast.ModuleCall):
            self._module_call(stmt, env)
        elif isinstance(stmt, ast.If):
            self._if(stmt, env)
        elif isinstance(stmt, ast.Block):
            self._child(stmt, env)

    def _child(self, stmt: ast.Stmt, env: _Env) -> None:
        """A statement run in a scope of its own."""
        stmts = stmt.stmts if isinstance(stmt, ast.Block) else (stmt,)
        seq = list(flatten(self._graph, self._file, stmts))
        self._sequence(seq, _build_scope(seq, (), self._file, None), env)

    def _if(self, stmt: ast.If, env: _Env) -> None:
        self._expr(stmt.cond, env)
        self._child(stmt.then, env)
        if stmt.otherwise is not None:
            self._child(stmt.otherwise, env)

    def _defaults(self, params: Sequence[ast.Param], env: _Env) -> None:
        """Defaults bind in the definition scope: they do not see the parameters."""
        for param in params:
            if param.default is not None:
                self._expr(param.default, env)

    def _callable(self, params: Sequence[ast.Param], body: ast.Expr, env: _Env) -> None:
        later = _deferred(env)
        self._defaults(params, later)
        scope = _build_scope([], params, self._file, None)
        self._expr(body, (_Frame(scope, _ALWAYS), *later))

    def _module_def(self, stmt: ast.ModuleDef, env: _Env) -> None:
        later = _deferred(env)
        self._defaults(stmt.params, later)
        body = stmt.body.stmts if isinstance(stmt.body, ast.Block) else (stmt.body,)
        seq = list(flatten(self._graph, self._file, body))
        self._sequence(seq, _build_scope(seq, stmt.params, self._file, None), later)

    def _module_call(self, stmt: ast.ModuleCall, env: _Env) -> None:
        if stmt.name in _BINDING_CALLS:
            env = self._binders(stmt.args, env)
        else:
            self._args(stmt.args, env)
        if stmt.name not in _KEYWORD_CALLS:
            self._record(Kind.MODULE, stmt.name, stmt.name_start, _lookup_module(env, stmt.name))
        if not isinstance(stmt.child, ast.Empty):
            self._child(stmt.child, env)

    def _args(self, args: Sequence[ast.Arg], env: _Env) -> None:
        for arg in args:
            self._expr(arg.value, env)

    def _binders(self, args: Sequence[ast.Arg], env: _Env) -> _Env:
        """Sequential bindings: each value sees the earlier ones; the body sees all."""
        scope = _binders_scope(args, self._file)
        for index, arg in enumerate(args):
            self._expr(arg.value, (_Frame(scope, index), *env))
        return (_Frame(scope, _ALWAYS), *env)

    def _expr(self, expr: ast.Expr, env: _Env) -> None:
        if isinstance(expr, ast.Ident):
            self._ident(expr, env)
        elif isinstance(expr, ast.Call):
            self._call(expr, env)
        elif isinstance(expr, ast.FunctionLiteral):
            self._callable(expr.params, expr.body, env)
        elif isinstance(expr, ast.Let | ast.ListFor):
            self._expr(expr.body, self._binders(expr.assigns, env))
        elif isinstance(expr, ast.ListForC):
            self._list_for_c(expr, env)
        else:
            for child in _subexpressions(expr):
                self._expr(child, env)

    def _ident(self, expr: ast.Ident, env: _Env) -> None:
        if not expr.name.startswith("$"):
            self._record(Kind.VARIABLE, expr.name, expr.start, _lookup_variable(env, expr.name))

    def _call(self, expr: ast.Call, env: _Env) -> None:
        callee = expr.callee
        if isinstance(callee, ast.Ident):
            if not callee.name.startswith("$"):
                targets = _lookup_function(env, callee.name)
                self._record(Kind.FUNCTION, callee.name, callee.start, targets)
        else:
            self._expr(callee, env)
        self._args(expr.args, env)

    def _list_for_c(self, expr: ast.ListForC, env: _Env) -> None:
        inner = self._binders(expr.init, env)
        self._expr(expr.cond, inner)
        self._args(expr.update, inner)
        self._expr(expr.body, inner)


def _subexpressions(expr: ast.Expr) -> Iterator[ast.Expr]:
    """The sub-expressions of a node that opens no scope."""
    if isinstance(expr, ast.Vector):
        yield from expr.elements
    elif isinstance(expr, ast.Range):
        yield expr.first
        if expr.step is not None:
            yield expr.step
        yield expr.last
    elif isinstance(expr, ast.Unary):
        yield expr.operand
    elif isinstance(expr, ast.Binary):
        yield expr.left
        yield expr.right
    elif isinstance(expr, ast.Ternary):
        yield expr.cond
        yield expr.then
        yield expr.otherwise
    elif isinstance(expr, ast.Index):
        yield expr.base
        yield expr.index
    elif isinstance(expr, ast.Member):
        yield expr.base
    elif isinstance(expr, ast.Paren):
        yield expr.inner
    elif isinstance(expr, ast.Assert | ast.Echo):
        yield from (a.value for a in expr.args)
        if expr.body is not None:
            yield expr.body
    elif isinstance(expr, ast.ListIf):
        yield expr.cond
        yield expr.then
        if expr.otherwise is not None:
            yield expr.otherwise
    elif isinstance(expr, ast.ListEach):
        yield expr.body
