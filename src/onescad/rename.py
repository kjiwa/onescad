"""Renames top-level definitions so one global scope behaves like the original namespaces.

The bundle puts every namespace in a single scope. A definition is renamed when it would be
visible to a reference that resolved elsewhere (another definition, a builtin, undef); fresh
names avoid every word in the kept source, so renamed code can never be captured either. This
needs no list of builtins.
"""

import re
from collections.abc import Iterable, Mapping
from pathlib import Path

from onescad.errors import BundleError
from onescad.flatten import Occurrence, Piece, RefIndex, Stream
from onescad.lexer import line_col
from onescad.loader import SourceFile
from onescad.resolver import Kind, TopLevel

_WORDS = re.compile(r"\$?[A-Za-z0-9_]+")
Scope = dict[tuple[Kind, str], list[TopLevel]]


class Renames:
    def __init__(self, files: Mapping[Path, SourceFile], taken: set[str]) -> None:
        self.names: dict[TopLevel, str] = {}
        self._files = files
        self._taken = taken

    def name_of(self, key: TopLevel) -> str:
        return self.names.get(key, key.name)

    def assign(self, key: TopLevel) -> None:
        if key in self.names:
            raise BundleError(f"cannot give {_describe(key)} a unique name")
        serial = 1
        while f"{key.name}__{serial}" in self._taken:
            serial += 1
        self.names[key] = f"{key.name}__{serial}"
        self._taken.add(self.names[key])

    def new_name(self, occurrence: Occurrence) -> str | None:
        """The name a reference must be rewritten to, or None to keep it.

        A reference whose possible targets would end up under different names cannot be
        rewritten: for example a parameter and an outer function, one of them renamed.
        """
        names = {self.name_of(key) for key in occurrence.top}
        if occurrence.free:
            names.add(occurrence.ref.name)
        if len(names) > 1:
            ref = occurrence.ref
            line, col = line_col(self._files[ref.file].source, ref.start)
            raise BundleError(
                f"{ref.file}:{line}:{col}: renaming would split the targets of '{ref.name}' "
                f"({', '.join(sorted(names))})"
            )
        if not occurrence.top:
            return None
        (name,) = names
        return None if name == occurrence.ref.name else name


def plan_renames(
    streams: tuple[Stream, ...],
    kept: frozenset[TopLevel],
    hoisted: frozenset[TopLevel],
    index: RefIndex,
    files: Mapping[Path, SourceFile],
) -> Renames:
    keys = sorted((k for k in kept | hoisted if not k.name.startswith("$")), key=_order)
    occurrences, taken = _gather(streams, kept, index)
    renames = Renames(files, taken | {k.name for k in keys})
    main = next(s.namespace for s in streams if s.main)
    weights = {s.namespace: 0 if s.main else 1 + i for i, s in enumerate(streams)}
    while victims := _victims(keys, occurrences, renames, weights, main):
        for key in sorted(victims, key=_order):
            renames.assign(key)
    return renames


def _order(key: TopLevel) -> tuple[str, str, str]:
    return str(key.namespace), key.kind.name, key.name


def _describe(key: TopLevel) -> str:
    return f"{key.kind.name.lower()} '{key.name}' of {key.namespace}"


def _gather(
    streams: tuple[Stream, ...], kept: frozenset[TopLevel], index: RefIndex
) -> tuple[list[Occurrence], set[str]]:
    """Every reference of a kept statement, and every word of the kept source."""
    occurrences: list[Occurrence] = []
    words: set[str] = set()
    for stream in streams:
        for entry in stream.entries:
            if isinstance(entry, Piece):
                scanned, shown = entry, [entry]
            elif entry.key in kept:
                scanned, shown = entry.body, list(entry.pieces)
            else:
                continue
            occurrences.extend(index.occurrences(stream, scanned))
            for piece in shown:
                words.update(_WORDS.findall(piece.source.source[piece.stmt.start : piece.stmt.end]))
                for target in index.nested_sources(piece):
                    words.update(_WORDS.findall(target.source))
    return occurrences, words


def _scope(keys: Iterable[TopLevel], renames: Renames) -> Scope:
    scope: Scope = {}
    for key in keys:
        scope.setdefault((key.kind, renames.name_of(key)), []).append(key)
    return scope


def _visible(scope: Scope, kind: Kind, name: str) -> list[TopLevel]:
    """A call sees functions and variables, and a function beats a variable in one scope."""
    if kind is Kind.FUNCTION:
        return scope.get((Kind.FUNCTION, name)) or scope.get((Kind.VARIABLE, name), [])
    return scope.get((kind, name), [])


def _extras(scope: Scope, occurrence: Occurrence, name: str) -> list[TopLevel]:
    extras = [k for k in _visible(scope, occurrence.ref.kind, name) if k not in occurrence.top]
    if occurrence.unresolved:
        # Unresolved next to a variable of its own namespace is a forward reference, which
        # keeps reading undef because the bundle preserves statement order.
        extras = [
            k
            for k in extras
            if not (k.kind is Kind.VARIABLE and k.namespace == occurrence.namespace)
        ]
    return extras


def _victims(
    keys: list[TopLevel],
    occurrences: list[Occurrence],
    renames: Renames,
    weights: Mapping[Path, int],
    main: Path,
) -> set[TopLevel]:
    scope = _scope(keys, renames)
    victims: set[TopLevel] = set()
    for occurrence in occurrences:
        if not (occurrence.top or occurrence.unresolved):
            continue
        name = renames.new_name(occurrence) or occurrence.ref.name
        extras = _extras(scope, occurrence, name)
        if extras:
            victims.update(_choose(extras, list(occurrence.top), weights, main))
    return victims


def _choose(
    extras: list[TopLevel], top: list[TopLevel], weights: Mapping[Path, int], main: Path
) -> list[TopLevel]:
    """Rename the intruders, or the intended targets when those are more movable. Main-file
    variables are Customizer parameters and never move; the main namespace outranks used ones."""

    def movable(keys: list[TopLevel]) -> bool:
        return all(not (k.namespace == main and k.kind is Kind.VARIABLE) for k in keys)

    def weight(keys: list[TopLevel]) -> int:
        return max(weights[k.namespace] for k in keys)

    if movable(extras) and (not top or weight(extras) >= weight(top) or not movable(top)):
        return extras
    if top and movable(top):
        return top
    names = ", ".join(sorted(_describe(k) for k in [*extras, *top]))
    raise BundleError(f"conflicting definitions cannot be renamed: {names}")
