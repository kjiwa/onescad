from pathlib import Path

import pytest

from helpers import HAS_OPENSCAD, write
from onescad.errors import BundleError
from onescad.verify import Render, VerifyError, _compare, verify

needs_openscad = pytest.mark.skipif(not HAS_OPENSCAD, reason="openscad is not installed")


def test_echoes_are_compared_after_restoring_renamed_names() -> None:
    want = Render("csg", ["ECHO: cube(1)"])
    got = Render("csg", ["ECHO: cube__1(1)"])
    _compare("x", want, got, {"cube__1": "cube"})
    with pytest.raises(VerifyError, match="echoes differently"):
        _compare("x", want, got, {})


def test_a_geometry_difference_is_reported_with_its_label() -> None:
    with pytest.raises(VerifyError, match="preset 'big'"):
        _compare("preset 'big'", Render("a", []), Render("b", []), {})


def test_a_verify_error_is_a_bundle_error() -> None:
    assert issubclass(VerifyError, BundleError)


@pytest.mark.oracle
@needs_openscad
def test_a_different_bundle_fails(tmp_path: Path) -> None:
    source = write(tmp_path, {"m.scad": "w = 1;\ncube(w);\n", "b.scad": "w = 1;\ncube(w + 1);\n"})
    with pytest.raises(VerifyError, match="renders differently"):
        verify(source, tmp_path / "b.scad", [], {}, None)


@pytest.mark.oracle
@needs_openscad
def test_different_parameters_fail(tmp_path: Path) -> None:
    source = write(tmp_path, {"m.scad": "w = 1;\ncube(1);\n", "b.scad": "v = 1;\ncube(1);\n"})
    with pytest.raises(VerifyError, match="different Customizer parameters"):
        verify(source, tmp_path / "b.scad", [], {}, None)


@pytest.mark.oracle
@needs_openscad
def test_a_bundle_that_needs_the_search_path_fails_alone(tmp_path: Path) -> None:
    libs = tmp_path / "libs"
    source = write(tmp_path, {"m.scad": "include <lib.scad>\n", "b.scad": "include <lib.scad>\n"})
    write(libs, {"lib.scad": "cube(1);\n"})
    with pytest.raises(VerifyError):
        verify(source, tmp_path / "b.scad", [libs], {}, None)


@pytest.mark.oracle
@needs_openscad
def test_a_syntax_error_in_the_bundle_is_reported(tmp_path: Path) -> None:
    source = write(tmp_path, {"m.scad": "cube(1);\n", "b.scad": "cube(;\n"})
    with pytest.raises(VerifyError, match="openscad failed"):
        verify(source, tmp_path / "b.scad", [], {}, None)
