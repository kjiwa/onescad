"""Decides which definitions the bundle keeps.

Roots are the main stream's instantiations, the main file's assignments, and top-level `$`
assignments. Everything else, library code in particular, is kept only when a kept statement
references it.
"""

from pathlib import Path

from onescad.errors import BundleError
from onescad.flatten import Definition, Piece, RefIndex, Stream
from onescad.resolver import Kind, TopLevel


def shake(streams: tuple[Stream, ...], index: RefIndex, main_file: Path) -> frozenset[TopLevel]:
    defined = {d.key: (s, d) for s in streams for d in s.definitions()}
    kept: set[TopLevel] = set()
    pending: list[tuple[Stream, Piece]] = []
    for stream in streams:
        for entry in stream.entries:
            if isinstance(entry, Piece):
                pending.append((stream, entry))
            elif _is_root(stream, entry, main_file):
                kept.add(entry.key)
                pending.append((stream, entry.body))
    while pending:
        stream, piece = pending.pop()
        for occurrence in index.occurrences(stream, piece):
            for key in occurrence.top:
                if key in defined and key not in kept:
                    kept.add(key)
                    owner, definition = defined[key]
                    pending.append((owner, definition.body))
    _reject_dynamic(streams, kept)
    return frozenset(kept)


def _is_root(stream: Stream, definition: Definition, main_file: Path) -> bool:
    if not stream.main:
        return False
    if definition.key.name.startswith("$"):
        return True
    return definition.key.kind is Kind.VARIABLE and any(
        piece.source.path == main_file for piece in definition.pieces
    )


def _reject_dynamic(streams: tuple[Stream, ...], kept: set[TopLevel]) -> None:
    """A `$` assignment in a used file is scoped to that file's code; once bundled it would
    reach every call."""
    for stream in streams:
        if stream.main or not any(key.namespace == stream.namespace for key in kept):
            continue
        for definition in stream.definitions():
            if definition.key.name.startswith("$"):
                raise BundleError(
                    f"{definition.head.source.path}: top-level '{definition.key.name}' in a used "
                    "file cannot be bundled: it would apply to every file"
                )
