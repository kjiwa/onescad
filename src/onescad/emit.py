"""Writes the bundle body: hoisted parameters, a hidden sentinel, then each namespace's kept
statements re-sliced from source with only renamed tokens rewritten."""

import os
import re
from bisect import bisect_left
from collections.abc import Iterable, Sequence
from dataclasses import dataclass
from pathlib import Path

from onescad import syntax as ast
from onescad.customizer import HoistPlan
from onescad.flatten import Definition, Entry, Piece, RefIndex, Stream, flatten_graph
from onescad.lexer import TRIVIA, Kind, Token, lex
from onescad.loader import Graph, SourceFile, includes_in
from onescad.rename import Renames, plan_renames
from onescad.resolver import Kind as RefKind
from onescad.resolver import Resolution, TopLevel
from onescad.shake import shake

SENTINEL = "/* [Hidden] */\n"
_DEFINITION_HEAD = re.compile(r"(?:module|function)(?:\s+|/\*.*?\*/|//[^\n]*)*", re.DOTALL)
_EXTERNAL_FILE_CALLS = frozenset({"import", "surface"})


@dataclass(frozen=True)
class Emission:
    text: str
    # Source files that contributed kept code, in emission order.
    files: tuple[Path, ...]
    # Renamed definition back to its original name.
    renamed: dict[str, str]
    fonts: tuple[str, ...]
    external_files: tuple[str, ...]
    warnings: tuple[str, ...]


def display_path(path: Path, roots: Sequence[Path]) -> str:
    """Relative to the first root that contains it, else to the first root."""
    for root in roots:
        if path.is_relative_to(root):
            return path.relative_to(root).as_posix()
    return Path(os.path.relpath(path, roots[0])).as_posix()


def neutralize(text: str) -> str:
    """Comment text safe above the hoisted block and the Hidden sentinel: a single-line block
    comment there would change the Customizer group of what follows, so it becomes a line
    comment."""
    out: list[str] = []
    for token in lex(text):
        if token.kind is Kind.COMMENT and token.text.startswith("/*") and "\n" not in token.text:
            out.append(f"// {token.text[2:-2].strip()}".rstrip())
        else:
            out.append(token.text)
    return "".join(out).strip()


def leading_block(source: str) -> str:
    """The comments before the first token of a file."""
    gap = ""
    for token in lex(source):
        if token.kind not in TRIVIA:
            break
        gap += token.text
    return neutralize(gap)


def emit(graph: Graph, refs: Resolution, plan: HoistPlan, roots: Sequence[Path]) -> Emission:
    """`roots` are the directories files are named relative to in `// onescad:` markers."""
    streams = flatten_graph(graph, plan)
    index = RefIndex(refs, graph)
    main_file = graph.main.root
    hoisted = frozenset(TopLevel(main_file, RefKind.VARIABLE, p.name) for p in plan.params)
    kept = shake(streams, index, main_file)
    renames = plan_renames(streams, kept, hoisted, index, graph.files)
    writer = _Writer(index, renames, kept, roots, main_file)
    blocks = [block for stream in streams for block in writer.blocks(stream)]
    sections = [plan.render(), SENTINEL, "\n\n".join(blocks) + "\n"]
    text = "\n".join(section for section in sections if section)
    calls = _scan_calls(text)
    return Emission(
        text=text,
        files=tuple(writer.files),
        renamed={new: key.name for key, new in renames.names.items()},
        fonts=calls.fonts,
        external_files=calls.external_files,
        warnings=(*writer.warnings, *calls.warnings),
    )


class _Writer:
    def __init__(
        self,
        index: RefIndex,
        renames: Renames,
        kept: frozenset[TopLevel],
        roots: Sequence[Path],
        main_file: Path,
    ) -> None:
        self.files: list[Path] = []
        self.warnings: list[str] = []
        self._index = index
        self._renames = renames
        self._kept = kept
        self._roots = roots
        # The main file's leading comment goes in the header.
        self._announced = {main_file}
        self._tokens: dict[Path, tuple[list[Token], list[int]]] = {}

    def blocks(self, stream: Stream) -> list[str]:
        out: list[str] = []
        current: Path | None = None
        for entry in stream.entries:
            if isinstance(entry, Definition) and entry.key not in self._kept:
                continue
            head = entry.head if isinstance(entry, Definition) else entry
            if head.source.path != current:
                current = head.source.path
                out.append(self._marker(head.source))
            out.append(self._entry(stream, entry))
            self._note_contribution(stream, entry)
        return out

    def _marker(self, source: SourceFile) -> str:
        marker = f"// onescad: {display_path(source.path, self._roots)}"
        if source.path in self._announced:
            return marker
        self._announced.add(source.path)
        return "\n".join(part for part in (marker, leading_block(source.source)) if part)

    def _note_contribution(self, stream: Stream, entry: Entry) -> None:
        pieces = entry.pieces if isinstance(entry, Definition) else (entry,)
        for piece in pieces:
            if self._contributes(entry, piece):
                for source in [piece.source, *self._index.nested_sources(piece)]:
                    if source.path not in self.files:
                        self.files.append(source.path)
        if isinstance(entry, Definition) and entry.key.kind is RefKind.VARIABLE and not stream.main:
            self.warnings.append(
                f"{display_path(entry.head.source.path, self._roots)}: top-level variable "
                f"'{entry.key.name}' of a used file is evaluated once in the bundle; OpenSCAD "
                "re-evaluates it on every call"
            )

    @staticmethod
    def _contributes(entry: Entry, piece: Piece) -> bool:
        return not isinstance(entry, Definition) or piece in (entry.head, entry.body)

    def _entry(self, stream: Stream, entry: Entry) -> str:
        if isinstance(entry, Definition):
            leading = self._leading(entry.head)
            return leading + self._definition(stream, entry)
        return self._leading(entry) + self._render(stream, entry, entry.stmt.start, entry.stmt.end)

    def _definition(self, stream: Stream, definition: Definition) -> str:
        head, body = definition.head, definition.body
        new_name = self._renames.names.get(definition.key)
        name_edit = _name_edit(head, new_name)
        first, last = head.stmt, body.stmt
        if head is not body and isinstance(first, ast.Assign) and isinstance(last, ast.Assign):
            text = self._render(stream, head, first.start, first.value.start, name_edit)
            return text + self._render(stream, body, last.value.start, last.end)
        return self._render(stream, body, body.stmt.start, body.stmt.end, name_edit)

    def _render(
        self,
        stream: Stream,
        piece: Piece,
        start: int,
        end: int,
        extra: list[tuple[int, int, str]] | None = None,
    ) -> str:
        return self._splice(stream, piece.source, start, end, includes_in([piece.stmt]), extra)

    def _splice(
        self,
        stream: Stream,
        source: SourceFile,
        start: int,
        end: int,
        includes: Iterable[ast.Include],
        extra: list[tuple[int, int, str]] | None = None,
    ) -> str:
        """`source[start:end]` with renamed tokens rewritten and every include inside the range
        replaced by the included file, so the bundle needs no other file."""
        edits = list(extra or [])
        for occurrence in self._index.within(stream, source.path, start, end):
            new = self._renames.new_name(occurrence)
            if new is not None:
                edits.append(
                    (occurrence.ref.start, occurrence.ref.start + len(occurrence.ref.name), new)
                )
        for include in includes:
            if start <= include.start and include.end <= end:
                target = self._index.target(source, include)
                text = self._splice(
                    stream, target, 0, len(target.source), includes_in(target.tree.stmts)
                )
                edits.append((include.start, include.end, text))
        out: list[str] = []
        pos = start
        for lo, hi, new in sorted(edits):
            if start <= lo and hi <= end:
                out.extend((source.source[pos:lo], new))
                pos = hi
        out.append(source.source[pos:end])
        return "".join(out)

    def _leading(self, piece: Piece) -> str:
        """Comments between the previous statement and this one, minus the previous statement's
        trailing comment. The file's first comments belong to the file marker."""
        tokens, starts = self._file_tokens(piece.source)
        end = bisect_left(starts, piece.stmt.start)
        begin = end
        while begin > 0 and tokens[begin - 1].kind in TRIVIA:
            begin -= 1
        if begin == 0:
            return ""
        gap = "".join(t.text for t in tokens[begin:end])
        comments = neutralize(gap.partition("\n")[2])
        return f"{comments}\n" if comments else ""

    def _file_tokens(self, source: SourceFile) -> tuple[list[Token], list[int]]:
        if source.path not in self._tokens:
            tokens = lex(source.source)
            self._tokens[source.path] = (tokens, [t.start for t in tokens])
        return self._tokens[source.path]


def _name_edit(head: Piece, new_name: str | None) -> list[tuple[int, int, str]]:
    """The edit renaming the name token that a definition's head statement starts with."""
    if new_name is None:
        return []
    stmt = head.stmt
    if isinstance(stmt, ast.Assign):
        offset = stmt.start
    elif isinstance(stmt, ast.FunctionDef | ast.ModuleDef):
        keyword = _DEFINITION_HEAD.match(head.source.source, stmt.start)
        if keyword is None:
            return []
        offset = keyword.end()
    else:
        return []
    return [(offset, offset + len(stmt.name), new_name)]


@dataclass(frozen=True)
class _Calls:
    fonts: tuple[str, ...]
    external_files: tuple[str, ...]
    warnings: tuple[str, ...]


def _scan_calls(text: str) -> _Calls:
    """Fonts named by `font=` strings, and files read by `import()` or `surface()`."""
    tokens = [t for t in lex(text) if t.kind not in TRIVIA]
    fonts: set[str] = set()
    files: list[str] = []
    for i, token in enumerate(tokens):
        following = tokens[i + 1 : i + 5]
        if token.kind is Kind.IDENT and token.text == "font" and _is_string_after(following, "="):
            fonts.add(following[1].text[1:-1])
        elif token.text in _EXTERNAL_FILE_CALLS and following and following[0].text == "(":
            files.append(_external_file(following[1:]))
    warnings = tuple(f"the bundle reads the external file {name} at render time" for name in files)
    return _Calls(tuple(sorted(fonts)), tuple(files), warnings)


def _is_string_after(tokens: list[Token], op: str) -> bool:
    return len(tokens) >= 2 and tokens[0].text == op and tokens[1].kind is Kind.STRING


def _external_file(args: list[Token]) -> str:
    """The first argument, or the one named `file`, when it is a string literal."""
    if len(args) >= 3 and args[0].text == "file" and args[1].text == "=":
        args = args[2:]
    return args[0].text if args and args[0].kind is Kind.STRING else "<computed path>"
