import os
import shutil
import subprocess
from collections.abc import Mapping, Sequence
from pathlib import Path

from onescad.customizer import HoistPlan, plan_hoist
from onescad.emit import Emission, emit
from onescad.loader import Graph, load
from onescad.resolver import Resolution, resolve

HAS_OPENSCAD = shutil.which("openscad") is not None


def write(root: Path, files: Mapping[str, str]) -> Path:
    """Write `files` under `root` and return the first one."""
    paths = []
    for name, text in files.items():
        path = root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        paths.append(path)
    return paths[0]


def analyze(
    root: Path, files: Mapping[str, str], libs: Sequence[Path] = ()
) -> tuple[Graph, Resolution, HoistPlan]:
    """Load `files`, the first being the main file."""
    graph = load(write(root, files), libs, {})
    refs = resolve(graph)
    return graph, refs, plan_hoist(graph, refs)


def bundle_body(root: Path, files: Mapping[str, str], libs: Sequence[Path] = ()) -> Emission:
    graph, refs, plan = analyze(root, files, libs)
    return emit(graph, refs, plan, [root.resolve(), *libs])


def openscad(path: Path, *args: str, libs: Sequence[Path] = ()) -> str:
    """Run openscad on `path` with a clean home and only `libs` on the search path; return the
    CSG followed by the ECHO lines."""
    home = path.parent / "home"
    home.mkdir(exist_ok=True)
    env = {
        "PATH": os.environ["PATH"],
        "HOME": str(home),
        "OPENSCADPATH": os.pathsep.join(map(str, libs)),
    }
    out = path.with_suffix(".csg")
    run = subprocess.run(  # noqa: S603
        ["openscad", *args, "-o", str(out), str(path)],  # noqa: S607
        check=True,
        capture_output=True,
        text=True,
        env=env,
    )
    echoes = [line for line in run.stderr.splitlines() if line.startswith("ECHO:")]
    return out.read_text() + "\n".join(echoes)
