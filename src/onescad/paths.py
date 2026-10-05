"""Include and use path resolution over the directories OpenSCAD searches."""

import os
import sys
from collections.abc import Mapping, Sequence
from pathlib import Path


def user_library_dir(environ: Mapping[str, str], platform: str) -> Path | None:
    """OpenSCAD's user library directory, or None when the home directory is unknown."""
    if platform == "win32":
        home = environ.get("USERPROFILE")
        return Path(home) / "Documents" / "OpenSCAD" / "libraries" if home else None
    home = environ.get("HOME")
    if not home:
        return None
    if platform == "darwin":
        return Path(home) / "Documents" / "OpenSCAD" / "libraries"
    return Path(home) / ".local" / "share" / "OpenSCAD" / "libraries"


def library_dirs(
    extra: Sequence[Path], environ: Mapping[str, str], platform: str = sys.platform
) -> tuple[Path, ...]:
    """Explicit directories first, then OPENSCADPATH, then the user library directory."""
    from_env = [Path(p) for p in environ.get("OPENSCADPATH", "").split(os.pathsep) if p]
    user = user_library_dir(environ, platform)
    return (*extra, *from_env, *([user] if user else []))


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
