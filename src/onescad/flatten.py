"""Turns each namespace into the ordered stream of statements the bundle may emit.

Duplicates collapse the way OpenSCAD evaluates them: a variable is assigned once at its first
position, a module or function keeps its last definition, and instantiations stay per occurrence.
Instantiations of a used namespace never run, so they are dropped.
"""

from bisect import bisect_left
from collections.abc import Iterator
from dataclasses import dataclass
from pathlib import Path

from onescad import syntax as ast
from onescad.customizer import HoistPlan
from onescad.loader import Graph, Namespace, SourceFile
from onescad.resolver import Kind, Local, Ref, Resolution, Target, TopLevel, Unresolved, flatten

_NOT_INSTANTIATIONS = (ast.Assign, ast.FunctionDef, ast.ModuleDef, ast.Use, ast.Include, ast.Empty)


@dataclass(frozen=True)
class Piece:
    """One statement of one file."""

    source: SourceFile
    stmt: ast.Stmt


@dataclass(frozen=True)
class Definition:
    """Every occurrence of one top-level name, in stream order."""

    key: TopLevel
    pieces: tuple[Piece, ...]

    @property
    def head(self) -> Piece:
        """Where the definition is placed: a variable's first occurrence, else the last."""
        return self.pieces[0] if self.key.kind is Kind.VARIABLE else self.pieces[-1]

    @property
    def body(self) -> Piece:
        """The occurrence whose value or body is kept."""
        return self.pieces[-1]


Entry = Definition | Piece


@dataclass(frozen=True)
class Stream:
    namespace: Path
    uses: tuple[Path, ...]
    main: bool
    entries: tuple[Entry, ...]

    def definitions(self) -> Iterator[Definition]:
        return (e for e in self.entries if isinstance(e, Definition))


@dataclass(frozen=True)
class Occurrence:
    """A reference seen from one namespace."""

    ref: Ref
    namespace: Path
    top: tuple[TopLevel, ...]
    # A target that keeps the reference's own name: a local, or a builtin / undef.
    free: bool
    unresolved: bool


class RefIndex:
    def __init__(self, refs: Resolution) -> None:
        by_file: dict[Path, list[tuple[Ref, frozenset[Target]]]] = {}
        for ref, targets in refs.items():
            by_file.setdefault(ref.file, []).append((ref, targets))
        self._refs = {p: sorted(found, key=lambda r: r[0].start) for p, found in by_file.items()}
        self._starts = {p: [r.start for r, _ in found] for p, found in self._refs.items()}

    def occurrences(self, stream: Stream, piece: Piece) -> list[Occurrence]:
        path = piece.source.path
        found = self._refs.get(path, [])
        starts = self._starts.get(path, [])
        lo = bisect_left(starts, piece.stmt.start)
        hi = bisect_left(starts, piece.stmt.end)
        return [_occurrence(stream, ref, targets) for ref, targets in found[lo:hi]]


def _occurrence(stream: Stream, ref: Ref, targets: frozenset[Target]) -> Occurrence:
    """A file shared by two namespaces carries the targets of both; keep this namespace's."""
    owners = {stream.namespace, *stream.uses}
    top = sorted(
        (t for t in targets if isinstance(t, TopLevel) and t.namespace in owners),
        key=lambda t: (str(t.namespace), t.kind.name, t.name),
    )
    return Occurrence(
        ref,
        stream.namespace,
        tuple(top),
        free=any(isinstance(t, Local | Unresolved) for t in targets),
        unresolved=Unresolved() in targets,
    )


def flatten_graph(graph: Graph, plan: HoistPlan) -> tuple[Stream, ...]:
    """Used namespaces first, dependencies before dependents, then the main stream."""
    used = (_stream(graph, ns, False, frozenset()) for ns in graph.used)
    return (*used, _stream(graph, graph.main, True, plan.dropped))


def _definition_key(root: Path, stmt: ast.Stmt) -> TopLevel | None:
    if isinstance(stmt, ast.Assign):
        return TopLevel(root, Kind.VARIABLE, stmt.name)
    if isinstance(stmt, ast.FunctionDef):
        return TopLevel(root, Kind.FUNCTION, stmt.name)
    if isinstance(stmt, ast.ModuleDef):
        return TopLevel(root, Kind.MODULE, stmt.name)
    return None


def _stream(
    graph: Graph, namespace: Namespace, main: bool, dropped: frozenset[tuple[Path, int]]
) -> Stream:
    placed: list[tuple[int, Entry]] = []
    occurrences: dict[TopLevel, list[tuple[int, Piece]]] = {}
    root = namespace.root
    for index, (source, stmt) in enumerate(flatten(graph, root, graph.files[root].tree.stmts)):
        piece = Piece(source, stmt)
        key = _definition_key(root, stmt)
        if key is not None:
            if (source.path, stmt.start) not in dropped:
                occurrences.setdefault(key, []).append((index, piece))
        elif main and not isinstance(stmt, _NOT_INSTANTIATIONS):
            placed.append((index, piece))
    for key, found in occurrences.items():
        definition = Definition(key, tuple(p for _, p in found))
        position = found[0][0] if key.kind is Kind.VARIABLE else found[-1][0]
        placed.append((position, definition))
    placed.sort(key=lambda item: item[0])
    return Stream(root, namespace.uses, main, tuple(entry for _, entry in placed))
