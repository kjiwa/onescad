"""Builds the file graph: parses sources, resolves include/use targets, and groups files into
namespaces (the main file plus its include closure, and one per distinct used file)."""

from collections.abc import Iterable, Iterator, Mapping, Sequence
from dataclasses import dataclass, field
from pathlib import Path

from onescad import syntax as ast
from onescad.lexer import ScadSyntaxError, line_col
from onescad.parser import parse
from onescad.paths import library_dirs, resolve, search_dirs


class LoadError(Exception):
    pass


@dataclass(frozen=True)
class SourceFile:
    path: Path
    source: str
    tree: ast.File


@dataclass(frozen=True)
class Namespace:
    root: Path
    files: tuple[Path, ...]
    uses: tuple[Path, ...]


@dataclass
class Graph:
    main: Namespace
    used: list[Namespace] = field(default_factory=list)
    files: dict[Path, SourceFile] = field(default_factory=dict)
    links: dict[tuple[Path, int], Path] = field(default_factory=dict)

    def included(self, file: Path, stmt: ast.Include) -> SourceFile:
        return self.files[self.links[(file, stmt.start)]]

    def splice(
        self, file: Path, stmts: Iterable[ast.Stmt]
    ) -> Iterator[tuple[SourceFile, ast.Stmt]]:
        """Yield `stmts` with every include replaced, recursively, by the included file's
        statements. Works at any scope."""
        for stmt in stmts:
            if isinstance(stmt, ast.Include):
                target = self.files[self.links[(file, stmt.start)]]
                yield from self.splice(target.path, target.tree.stmts)
            else:
                yield self.files[file], stmt


def load(main: Path, extra_dirs: Sequence[Path], environ: Mapping[str, str]) -> Graph:
    return _Loader(library_dirs(extra_dirs, environ)).load(main)


def _nested(stmt: ast.Stmt) -> tuple[ast.Stmt, ...]:
    if isinstance(stmt, ast.Block):
        return stmt.stmts
    if isinstance(stmt, ast.ModuleDef):
        return (stmt.body,)
    if isinstance(stmt, ast.ModuleCall):
        return (stmt.child,)
    if isinstance(stmt, ast.If):
        return (stmt.then,) if stmt.otherwise is None else (stmt.then, stmt.otherwise)
    return ()


def includes_in(stmts: Iterable[ast.Stmt]) -> Iterator[ast.Include]:
    """Every include in `stmts` at any depth, without following into the included files."""
    for stmt in stmts:
        if isinstance(stmt, ast.Include):
            yield stmt
        else:
            yield from includes_in(_nested(stmt))


class _Loader:
    def __init__(self, libs: Sequence[Path]) -> None:
        self._libs = libs
        self._files: dict[Path, SourceFile] = {}
        self._links: dict[tuple[Path, int], Path] = {}
        self._namespaces: dict[Path, Namespace] = {}
        self._used: list[Namespace] = []

    def load(self, main: Path) -> Graph:
        root = main.resolve()
        if not root.is_file():
            raise LoadError(f"{main}: no such file")
        namespace = self._namespace(root, [])
        return Graph(namespace, self._used, self._files, self._links)

    def _read(self, path: Path) -> SourceFile:
        if path not in self._files:
            try:
                source = path.read_bytes().decode("utf-8-sig")
            except (OSError, UnicodeDecodeError) as e:
                raise LoadError(f"{path}: cannot read: {e}") from e
            try:
                tree = parse(source)
            except ScadSyntaxError as e:
                line, col = line_col(source, e.pos)
                raise LoadError(f"{path}:{line}:{col}: {e}") from e
            self._files[path] = SourceFile(path, source, tree)
        return self._files[path]

    def _namespace(self, root: Path, using: list[Path]) -> Namespace:
        if root in using:
            chain = " -> ".join(str(p) for p in [*using[using.index(root) :], root])
            raise LoadError(f"use cycle: {chain}")
        if root not in self._namespaces:
            self._namespaces[root] = self._build_namespace(root, using)
        return self._namespaces[root]

    def _build_namespace(self, root: Path, using: list[Path]) -> Namespace:
        closure = [root]
        uses: list[Path] = []
        file = self._read(root)
        self._walk(file, file.tree.stmts, True, [root], closure, uses)
        namespace = Namespace(root, tuple(closure), tuple(dict.fromkeys(uses)))
        for used in namespace.uses:
            self._namespace(used, [*using, root])
        if using:
            self._used.append(namespace)
        return namespace

    def _walk(
        self,
        file: SourceFile,
        stmts: Iterable[ast.Stmt],
        top_level: bool,
        stack: list[Path],
        closure: list[Path],
        uses: list[Path],
    ) -> None:
        for stmt in stmts:
            if isinstance(stmt, ast.Include):
                target = self._link(file, stmt)
                if target in stack:
                    chain = " -> ".join(str(p) for p in [*stack[stack.index(target) :], target])
                    raise self._error(file, stmt, f"include cycle: {chain}")
                if target not in closure:
                    closure.append(target)
                included = self._read(target)
                self._walk(
                    included, included.tree.stmts, top_level, [*stack, target], closure, uses
                )
            elif isinstance(stmt, ast.Use):
                if not top_level:
                    raise self._error(file, stmt, "use is only allowed at top level")
                uses.append(self._link(file, stmt))
            else:
                self._walk(file, _nested(stmt), False, stack, closure, uses)

    def _link(self, file: SourceFile, stmt: ast.Include | ast.Use) -> Path:
        target = resolve(stmt.path, file.path.parent, self._libs)
        if target is None:
            searched = ", ".join(str(d) for d in search_dirs(file.path.parent, self._libs))
            raise self._error(file, stmt, f"cannot find '{stmt.path}'; searched: {searched}")
        self._links[(file.path, stmt.start)] = target
        return target

    @staticmethod
    def _error(file: SourceFile, stmt: ast.Stmt, message: str) -> LoadError:
        line, col = line_col(file.source, stmt.start)
        return LoadError(f"{file.path}:{line}:{col}: {message}")
