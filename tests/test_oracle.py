"""Bundles every fixture under tests/fixtures and checks it against a golden file and, when
openscad is present, against the source rendering.

A fixture holds `main.scad` plus its helpers and one of:
  expected.scad  golden bundle without its version line
  error.txt      text the error message must contain; the bundle must fail
Optional: `libs` (library dirs relative to the repo root, one per line), `warning.txt` (text a
warning must contain), `noverify` (skip the openscad comparison).
Regenerate goldens with ONESCAD_UPDATE_GOLDEN=1.
"""

import os
import shutil
from pathlib import Path

import pytest

from helpers import HAS_OPENSCAD
from onescad.cli import main

FIXTURES = Path(__file__).parent / "fixtures"
ROOT = Path(__file__).parent.parent
CASES = sorted(p.name for p in FIXTURES.iterdir() if p.is_dir())
BUNDLES = [c for c in CASES if not (FIXTURES / c / "error.txt").exists()]
FAILURES = [c for c in CASES if (FIXTURES / c / "error.txt").exists()]
VERIFIABLE = [c for c in BUNDLES if not (FIXTURES / c / "noverify").exists()]
CONTROL_FILES = {"expected.scad", "error.txt", "libs", "warning.txt", "noverify"}


@pytest.fixture(autouse=True)
def clean_environment(monkeypatch: pytest.MonkeyPatch, tmp_path: Path) -> None:
    monkeypatch.delenv("OPENSCADPATH", raising=False)
    monkeypatch.setenv("HOME", str(tmp_path / "home"))
    monkeypatch.setenv("USERPROFILE", str(tmp_path / "home"))


def stage(case: str, tmp_path: Path) -> Path:
    """Copy a fixture without its control files so the bundle never sees the golden."""
    dest = tmp_path / "src"
    if not dest.exists():
        shutil.copytree(
            FIXTURES / case,
            dest,
            ignore=lambda _dir, names: [n for n in names if n in CONTROL_FILES],
        )
    return dest / "main.scad"


def libraries(case: str) -> list[str]:
    libs = FIXTURES / case / "libs"
    if not libs.exists():
        return []
    return ["-L", *[str(ROOT / line) for line in libs.read_text().split()]]


def run(case: str, tmp_path: Path, out: str, *extra: str) -> tuple[int, Path]:
    target = tmp_path / out / "main.scad"
    code = main([str(stage(case, tmp_path)), "-o", str(target), *libraries(case), *extra])
    return code, target


def body(bundle: Path) -> str:
    return bundle.read_text().split("\n", 1)[1]


@pytest.mark.parametrize("case", BUNDLES)
def test_the_bundle_matches_its_golden(case: str, tmp_path: Path) -> None:
    code, target = run(case, tmp_path, "dist")
    assert code == 0
    golden = FIXTURES / case / "expected.scad"
    if os.environ.get("ONESCAD_UPDATE_GOLDEN"):
        golden.write_text(body(target))
    assert body(target) == golden.read_text()


@pytest.mark.parametrize("case", BUNDLES)
def test_two_runs_are_byte_identical(case: str, tmp_path: Path) -> None:
    _, first = run(case, tmp_path, "one")
    _, second = run(case, tmp_path, "two")
    assert first.read_bytes() == second.read_bytes()


@pytest.mark.parametrize("case", FAILURES)
def test_a_bad_model_is_refused(
    case: str, tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    code, target = run(case, tmp_path, "dist")
    err = capsys.readouterr().err
    assert code == 1
    assert err.startswith("onescad: ")
    assert (FIXTURES / case / "error.txt").read_text().strip() in err
    assert not target.exists()


@pytest.mark.parametrize("case", [c for c in BUNDLES if (FIXTURES / c / "warning.txt").exists()])
def test_a_risky_model_warns(case: str, tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    run(case, tmp_path, "dist")
    expected = (FIXTURES / case / "warning.txt").read_text().strip()
    assert f"onescad: warning: {expected}" in capsys.readouterr().err


@pytest.mark.oracle
@pytest.mark.skipif(not HAS_OPENSCAD, reason="needs openscad")
@pytest.mark.parametrize("case", VERIFIABLE)
def test_the_bundle_renders_like_its_source(case: str, tmp_path: Path) -> None:
    code, _ = run(case, tmp_path, "dist", "--verify")
    assert code == 0


@pytest.mark.oracle
@pytest.mark.skipif(not HAS_OPENSCAD, reason="needs openscad")
@pytest.mark.parametrize("case", VERIFIABLE)
def test_the_minified_bundle_renders_like_its_source(case: str, tmp_path: Path) -> None:
    code, _ = run(case, tmp_path, "dist", "--verify", "--minify")
    assert code == 0
