"""Customizer presets: the `<name>.json` that sits next to a model."""

import json
import shutil
from collections.abc import Collection
from pathlib import Path

from onescad.errors import BundleError


def find_presets(main: Path) -> Path | None:
    candidate = main.with_suffix(".json")
    return candidate if candidate.is_file() else None


def preset_sets(path: Path) -> dict[str, dict[str, object]]:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
        sets = data["parameterSets"]
        if not isinstance(sets, dict) or not all(isinstance(v, dict) for v in sets.values()):
            raise TypeError
    except (ValueError, KeyError, TypeError) as e:
        raise BundleError(f"{path}: not a Customizer preset file (no parameterSets object)") from e
    return dict(sets)


def inert_keys(path: Path, parameters: Collection[str]) -> list[str]:
    """Warnings for preset keys that match no Customizer parameter of the bundle."""
    return [
        f"{path.name}: preset '{name}' sets '{key}', which is not a Customizer parameter"
        for name, values in preset_sets(path).items()
        for key in values
        if key not in parameters
    ]


def copy_presets(source: Path, destination: Path) -> None:
    shutil.copyfile(source, destination)
