from pathlib import Path

from helpers import analyze
from onescad.flatten import Definition, Piece, RefIndex, flatten_graph
from onescad.resolver import Kind, TopLevel


def streams(tmp_path: Path, files: dict[str, str]):  # type: ignore[no-untyped-def]
    graph, refs, plan = analyze(tmp_path, files)
    return graph, refs, flatten_graph(graph, plan)


def definitions(stream) -> dict[tuple[Kind, str], Definition]:  # type: ignore[no-untyped-def]
    return {(d.key.kind, d.key.name): d for d in stream.definitions()}


def test_variable_is_placed_at_first_occurrence_and_keeps_the_last_expression(
    tmp_path: Path,
) -> None:
    _, _, found = streams(tmp_path, {"m.scad": "x = 1 + 1;\ny = 2 + 2;\nx = 3 + 3;\n"})
    main = found[-1]
    assert [e.key.name for e in main.entries if isinstance(e, Definition)] == ["x", "y"]
    x = definitions(main)[Kind.VARIABLE, "x"]
    assert x.head.stmt.start < x.body.stmt.start
    assert len(x.pieces) == 2


def test_function_and_module_keep_the_last_definition_at_its_position(tmp_path: Path) -> None:
    _, _, found = streams(
        tmp_path,
        {
            "m.scad": (
                "function f() = 1;\nmodule m() cube(1);\nfunction f() = 2;\nmodule m() cube(2);\n"
            )
        },
    )
    defs = definitions(found[-1])
    f = defs[Kind.FUNCTION, "f"]
    assert f.head is f.body and f.head.stmt.start == f.pieces[-1].stmt.start
    assert [e.key.name for e in found[-1].entries if isinstance(e, Definition)] == ["f", "m"]


def test_instantiations_stay_per_occurrence_and_a_repeated_include_collapses_definitions(
    tmp_path: Path,
) -> None:
    _, _, found = streams(
        tmp_path,
        {
            "m.scad": "include <i.scad>\ninclude <i.scad>\n",
            "i.scad": "function f() = 1;\ncube(1);\n",
        },
    )
    entries = found[-1].entries
    assert sum(isinstance(e, Piece) for e in entries) == 2
    assert len(definitions(found[-1])) == 1


def test_bare_blocks_merge_into_the_enclosing_stream(tmp_path: Path) -> None:
    _, _, found = streams(tmp_path, {"m.scad": "{ a = 1 + 1; }\nb = a;\n"})
    assert sorted(n for _, n in definitions(found[-1])) == ["a", "b"]


def test_used_namespaces_come_first_and_drop_instantiations(tmp_path: Path) -> None:
    _, _, found = streams(
        tmp_path,
        {
            "m.scad": "use <a.scad>\ncube(1);\n",
            "a.scad": "use <b.scad>\nfunction f() = 1;\ncube(2);\n",
            "b.scad": "function g() = 1;\n",
        },
    )
    assert [s.main for s in found] == [False, False, True]
    assert [s.namespace.name for s in found] == ["b.scad", "a.scad", "m.scad"]
    assert not any(isinstance(e, Piece) for s in found[:-1] for e in s.entries)


def test_hoisted_assignments_are_dropped_from_the_main_stream(tmp_path: Path) -> None:
    _, _, found = streams(tmp_path, {"m.scad": "w = 3;\nh = w * 2;\n"})
    assert sorted(n for _, n in definitions(found[-1])) == ["h"]


def test_hoisting_does_not_drop_a_used_namespace_assignment(tmp_path: Path) -> None:
    _, _, found = streams(
        tmp_path,
        {
            "m.scad": "include <i.scad>\nuse <u.scad>\nw = 3;\n",
            "i.scad": "w = 4;\n",
            "u.scad": "include <i.scad>\n",
        },
    )
    assert sorted(n for _, n in definitions(found[0])) == ["w"]


def test_a_shared_file_reports_only_the_targets_of_the_asking_namespace(tmp_path: Path) -> None:
    files = {
        "m.scad": "use <a.scad>\nuse <b.scad>\n",
        "a.scad": "include <s.scad>\n",
        "b.scad": "include <s.scad>\n",
        "s.scad": "function f() = 1;\nfunction g() = f();\n",
    }
    graph, refs, found = streams(tmp_path, files)
    index = RefIndex(refs, graph)
    for stream in found[:2]:
        g = definitions(stream)[Kind.FUNCTION, "g"].body
        (occurrence,) = index.occurrences(stream, g)
        assert occurrence.top == (TopLevel(stream.namespace, Kind.FUNCTION, "f"),)
