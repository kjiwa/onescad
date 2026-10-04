"""Finds the license files that cover the source files a bundle takes code from."""

from collections.abc import Iterable, Sequence
from dataclasses import dataclass
from pathlib import Path

_PREFIXES = ("LICENSE", "LICENCE", "COPYING")


@dataclass(frozen=True)
class License:
    path: Path
    # Source files that contributed code under this license.
    covers: tuple[Path, ...]

    def text(self) -> str:
        return self.path.read_text(encoding="utf-8", errors="replace")


def nearest_licenses(file: Path) -> list[Path]:
    """The LICENSE/COPYING files of the closest ancestor directory that has any."""
    for directory in file.parents:
        found = sorted(
            p for p in directory.iterdir() if p.is_file() and p.name.upper().startswith(_PREFIXES)
        )
        if found:
            return found
    return []


def collect(files: Iterable[Path]) -> tuple[list[License], list[Path]]:
    """Licenses in first-use order, and the files that have none."""
    covered: dict[Path, list[Path]] = {}
    unlicensed: list[Path] = []
    for file in files:
        found = nearest_licenses(file)
        if not found:
            unlicensed.append(file)
        for license_file in found:
            covered.setdefault(license_file, []).append(file)
    return [License(p, tuple(c)) for p, c in covered.items()], unlicensed


def component(license_file: Path, roots: Sequence[Path]) -> str:
    """The directory a license covers, named relative to the first root that contains it."""
    for root in roots:
        if license_file.parent.is_relative_to(root):
            relative = license_file.parent.relative_to(root).as_posix()
            return relative if relative != "." else root.name
    return license_file.parent.name
