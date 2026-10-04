"""Checks a bundle against its source by rendering both with a real openscad."""

import json
import os
import re
import shutil
import subprocess
import tempfile
from collections.abc import Mapping, Sequence
from dataclasses import dataclass
from pathlib import Path

from onescad.errors import BundleError
from onescad.presets import preset_sets

_WORD = re.compile(r"\w+")


class VerifyError(BundleError):
    pass


@dataclass(frozen=True)
class Render:
    csg: str
    echoes: list[str]


@dataclass(frozen=True)
class Runner:
    """Runs openscad on one file with a fixed environment."""

    scad: Path
    home: Path
    search: str

    def run(self, out: Path, options: Sequence[str] = ()) -> str:
        """Write `out` and return the stderr of the run."""
        env = {"PATH": os.environ.get("PATH", ""), "HOME": str(self.home)}
        if self.search:
            env["OPENSCADPATH"] = self.search
        try:
            run = subprocess.run(  # noqa: S603
                ["openscad", *options, "-o", str(out), str(self.scad)],  # noqa: S607
                capture_output=True,
                text=True,
                env=env,
                check=False,
            )
        except OSError as e:
            raise VerifyError(f"cannot run openscad: {e}") from e
        if run.returncode != 0:
            raise VerifyError(f"openscad failed on {self.scad}:\n{run.stderr.strip()}")
        return run.stderr

    def render(self, work: Path, options: Sequence[str]) -> Render:
        csg = work / "out.csg"
        stderr = self.run(csg, options)
        echoes = [line for line in stderr.splitlines() if line.startswith("ECHO:")]
        return Render(csg.read_text(), echoes)

    def params(self, work: Path) -> dict[str, object]:
        out = work / "out.param"
        self.run(out)
        found: dict[str, object] = json.loads(out.read_text())
        found.pop("title", None)
        return found


def openscad_available() -> bool:
    return shutil.which("openscad") is not None


def verify(
    source: Path,
    bundle: Path,
    libs: Sequence[Path],
    renamed: Mapping[str, str],
    presets: Path | None,
) -> None:
    """Raise VerifyError unless the bundle matches the source for the defaults and every preset.

    The source sees only `libs` on OPENSCADPATH; the bundle sees none, so it must stand alone.
    Both run with an empty HOME.
    """
    names = list(preset_sets(presets)) if presets else []
    with tempfile.TemporaryDirectory() as scratch:
        work = Path(scratch)
        (work / "home").mkdir()
        want = Runner(source, work / "home", os.pathsep.join(map(str, libs)))
        got = Runner(bundle, work / "home", "")
        if want.params(work) != got.params(work):
            raise VerifyError("the bundle exposes different Customizer parameters than the source")
        for name in [None, *names]:
            options = ["-p", str(presets), "-P", name] if presets and name else []
            label = f"preset '{name}'" if name else "the default parameters"
            _compare(label, want.render(work, options), got.render(work, options), renamed)


def _compare(label: str, want: Render, got: Render, renamed: Mapping[str, str]) -> None:
    if want.csg != got.csg:
        raise VerifyError(f"the bundle renders differently from the source for {label}")
    restored = [_WORD.sub(lambda m: renamed.get(m.group(), m.group()), e) for e in got.echoes]
    if want.echoes != restored:
        raise VerifyError(f"the bundle echoes differently from the source for {label}")
