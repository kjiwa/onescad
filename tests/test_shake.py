from pathlib import Path

import pytest

from helpers import analyze
from onescad.errors import BundleError
from onescad.flatten import RefIndex, flatten_graph
from onescad.resolver import Kind, TopLevel
from onescad.shake import shake


def kept(tmp_path: Path, files: dict[str, str]) -> set[tuple[str, Kind, str]]:
    graph, refs, plan = analyze(tmp_path, files)
    streams = flatten_graph(graph, plan)
    found = shake(streams, RefIndex(refs, graph), graph.main.root)
    return {(k.namespace.name, k.kind, k.name) for k in found}


def test_unreferenced_library_definitions_are_dropped(tmp_path: Path) -> None:
    found = kept(
        tmp_path,
        {
            "m.scad": "use <l.scad>\nused();\n",
            "l.scad": "module used() cube(1);\nmodule spare() cube(2);\nfunction f() = 1;\n",
        },
    )
    assert found == {("l.scad", Kind.MODULE, "used")}


def test_reachability_follows_calls_across_kinds_and_namespaces(tmp_path: Path) -> None:
    found = kept(
        tmp_path,
        {
            "m.scad": "use <a.scad>\na();\n",
            "a.scad": "use <b.scad>\nmodule a() cube(f());\n",
            "b.scad": "function f() = g() + k;\nfunction g() = 1;\nk = 2;\nfunction spare() = 3;\n",
        },
    )
    assert found == {
        ("a.scad", Kind.MODULE, "a"),
        ("b.scad", Kind.FUNCTION, "f"),
        ("b.scad", Kind.FUNCTION, "g"),
        ("b.scad", Kind.VARIABLE, "k"),
    }


def test_main_assignments_and_dynamic_variables_are_roots(tmp_path: Path) -> None:
    found = kept(tmp_path, {"m.scad": "a = 1 + 1;\nmodule never() cube(1);\n$fn = 8 * 2;\n"})
    assert found == {("m.scad", Kind.VARIABLE, "a"), ("m.scad", Kind.VARIABLE, "$fn")}


def test_main_modules_are_kept_only_when_referenced(tmp_path: Path) -> None:
    found = kept(tmp_path, {"m.scad": "module a() cube(1);\nmodule b() cube(2);\na();\n"})
    assert found == {("m.scad", Kind.MODULE, "a")}


def test_used_namespace_assignments_are_never_roots(tmp_path: Path) -> None:
    found = kept(tmp_path, {"m.scad": "use <l.scad>\ncube(1);\n", "l.scad": "k = 1;\n"})
    assert found == set()


def test_included_library_code_is_shaken_like_any_other(tmp_path: Path) -> None:
    found = kept(
        tmp_path,
        {
            "m.scad": "include <i.scad>\nx = f();\n",
            "i.scad": "function f() = 1;\nfunction g() = 2;\n",
        },
    )
    assert found == {("m.scad", Kind.VARIABLE, "x"), ("m.scad", Kind.FUNCTION, "f")}


def test_a_dynamic_assignment_in_a_kept_used_file_is_an_error(tmp_path: Path) -> None:
    files = {"m.scad": "use <l.scad>\nx = f();\n", "l.scad": "$fn = 4;\nfunction f() = 1;\n"}
    with pytest.raises(BundleError, match=r"'\$fn' in a used file"):
        kept(tmp_path, files)


def test_a_dynamic_assignment_in_an_unused_file_is_ignored(tmp_path: Path) -> None:
    files = {"m.scad": "use <l.scad>\ncube(1);\n", "l.scad": "$fn = 4;\nfunction f() = 1;\n"}
    assert kept(tmp_path, files) == set()


def test_keys_are_top_level_targets(tmp_path: Path) -> None:
    graph, refs, plan = analyze(tmp_path, {"m.scad": "a = 1 + 1;\n"})
    found = shake(flatten_graph(graph, plan), RefIndex(refs, graph), graph.main.root)
    assert found == {TopLevel(graph.main.root, Kind.VARIABLE, "a")}
