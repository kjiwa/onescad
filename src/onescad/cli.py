"""Command line: bundle one OpenSCAD model into a single customizer-ready file."""

import argparse
import os
import sys
import tempfile
from collections.abc import Sequence
from dataclasses import dataclass
from pathlib import Path

from onescad import __version__
from onescad.customizer import CustomizerError, plan_hoist
from onescad.emit import Emission, display_path, emit, leading_block
from onescad.errors import BundleError
from onescad.header import Header, find_origin
from onescad.header import render as render_header
from onescad.licenses import collect
from onescad.loader import LoadError, load
from onescad.paths import library_dirs
from onescad.presets import copy_presets, find_presets, inert_keys
from onescad.resolver import resolve
from onescad.verify import openscad_available, verify

OK = 0
BUNDLE_ERROR = 1
USAGE = 2


@dataclass(frozen=True)
class Bundle:
    text: str
    emission: Emission
    presets: Path | None
    warnings: tuple[str, ...]


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="onescad", description="Bundle an OpenSCAD model into one customizer-ready file."
    )
    parser.add_argument("input", type=Path, metavar="INPUT", help="the model's .scad file")
    parser.add_argument("-o", "--output", type=Path, required=True, help="the bundle to write")
    parser.add_argument(
        "-L",
        "--library",
        action="append",
        default=[],
        type=Path,
        metavar="DIR",
        help="library directory to search for include and use (repeatable)",
    )
    parser.add_argument(
        "--verify",
        action="store_true",
        help="render the source and the bundle with openscad and compare them",
    )
    parser.add_argument(
        "--minify",
        action="store_true",
        help="strip comments and indentation after the Customizer parameters",
    )
    parser.add_argument("--version", action="version", version=f"onescad {__version__}")
    return parser


def _build(source: Path, libs: Sequence[Path], output: Path, minify: bool) -> Bundle:
    graph = load(source, libs, os.environ)
    refs = resolve(graph)
    plan = plan_hoist(graph, refs)
    search = [p.resolve() for p in library_dirs(libs, os.environ)]
    roots = [graph.main.root.parent, *search]
    emission = emit(graph, refs, plan, roots, minify)
    presets = find_presets(graph.main.root)
    warnings = list(emission.warnings)
    if presets:
        warnings += inert_keys(presets, {p.name for p in plan.params})
    licenses, unlicensed = collect(emission.files)
    warnings += [f"no license file found for {display_path(p, roots)}" for p in unlicensed]
    header = Header(
        version=__version__,
        origin=find_origin(graph.main.root),
        doc=leading_block(graph.files[graph.main.root].source),
        fonts=emission.fonts,
        external_files=emission.external_files,
        presets=output.with_suffix(".json").name if presets else None,
        licenses=licenses,
    )
    text = render_header(header, roots) + emission.text
    return Bundle(text, emission, presets, tuple(warnings))


def _check_presets_target(bundle: Bundle, output: Path) -> None:
    if not bundle.presets:
        return
    target = output.with_suffix(".json").resolve()
    if target in (bundle.presets.resolve(), output.resolve()):
        raise BundleError(f"the presets copy would overwrite {target.name}; choose another output")


def _write(bundle: Bundle, output: Path) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(bundle.text, encoding="utf-8")
    if bundle.presets:
        copy_presets(bundle.presets, output.with_suffix(".json"))


def _verify(source: Path, bundle: Bundle, output: Path, libs: Sequence[Path]) -> None:
    with tempfile.TemporaryDirectory() as scratch:
        candidate = Path(scratch) / output.name
        candidate.write_text(bundle.text, encoding="utf-8")
        search = library_dirs([p.resolve() for p in libs], os.environ)
        verify(source, candidate, search, bundle.emission.renamed, bundle.presets)


def _run(args: argparse.Namespace) -> int:
    source: Path = args.input.resolve()
    output: Path = args.output
    if output.resolve() == source:
        raise BundleError("the output would overwrite the input")
    if args.verify and not openscad_available():
        raise BundleError("--verify needs openscad on PATH")
    bundle = _build(source, args.library, output, args.minify)
    for warning in bundle.warnings:
        print(f"onescad: warning: {warning}", file=sys.stderr)
    _check_presets_target(bundle, output)
    if args.verify:
        _verify(source, bundle, output, args.library)
    _write(bundle, output)
    return OK


def main(argv: Sequence[str] | None = None) -> int:
    args = _parser().parse_args(argv)
    try:
        return _run(args)
    except (LoadError, CustomizerError, BundleError, OSError) as e:
        print(f"onescad: {e}", file=sys.stderr)
        return BUNDLE_ERROR
