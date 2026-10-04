"""Include and use path resolution, restricted to what OpenSCAD searches reproducibly."""

import os
from collections.abc import Mapping, Sequence
from pathlib import Path


def library_dirs(extra: Sequence[Path], environ: Mapping[str, str]) -> tuple[Path, ...]:
    """Explicit directories first, then OPENSCADPATH."""
    from_env = [Path(p) for p in environ.get("OPENSCADPATH", "").split(os.pathsep) if p]
    return (*extra, *from_env)


def search_dirs(including_dir: Path, libs: Sequence[Path]) -> tuple[Path, ...]:
    return (including_dir, *libs)


def resolve(ref: str, including_dir: Path, libs: Sequence[Path]) -> Path | None:
    """Return the realpath of the first match.

    A symlinked file's own includes resolve relative to its target's directory, so the
    including directory must come from a realpath.
    """
    for directory in search_dirs(including_dir, libs):
        candidate = directory / ref
        if candidate.is_file():
            return candidate.resolve()
    return None
