from pathlib import Path

import pytest

from onescad import syntax as ast
from onescad.loader import Graph, LoadError, load
from onescad.paths import library_dirs, resolve

CORPUS = Path(__file__).parent / "corpus"


def write(root: Path, name: str, text: str) -> Path:
    path = root / name
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)
    return path.resolve()


def load_graph(main: Path, libs: tuple[Path, ...] = (), **env: str) -> Graph:
    return load(main, libs, env)


def spliced_names(graph: Graph, root: Path) -> list[str]:
    stmts = graph.files[root].tree.stmts
    return [s.name for _, s in graph.splice(root, stmts) if isinstance(s, ast.Assign)]


def test_include_is_spliced_in_place(tmp_path: Path) -> None:
    write(tmp_path, "a.scad", "a = 1;")
    main = write(tmp_path, "main.scad", "x = 0;\ninclude <a.scad>\ny = 2;")
    graph = load_graph(main)
    assert spliced_names(graph, main) == ["x", "a", "y"]
    assert graph.main.files == (main, tmp_path.resolve() / "a.scad")


def test_splice_attributes_statements_to_their_file(tmp_path: Path) -> None:
    a = write(tmp_path, "a.scad", "a = 1;")
    main = write(tmp_path, "main.scad", "include <a.scad>\nx = 0;")
    graph = load_graph(main)
    files = [f.path for f, _ in graph.splice(main, graph.files[main].tree.stmts)]
    assert files == [a, main]


def test_repeated_include_is_spliced_each_time(tmp_path: Path) -> None:
    write(tmp_path, "a.scad", "a = 1;")
    main = write(tmp_path, "main.scad", "include <a.scad>\ninclude <a.scad>")
    graph = load_graph(main)
    assert spliced_names(graph, main) == ["a", "a"]
    assert len(graph.main.files) == 2


def test_include_inside_module_body(tmp_path: Path) -> None:
    write(tmp_path, "a.scad", "a = 1;")
    main = write(tmp_path, "main.scad", "module m() { include <a.scad> }")
    graph = load_graph(main)
    (module,) = graph.files[main].tree.stmts
    assert isinstance(module, ast.ModuleDef)
    assert isinstance(module.body, ast.Block)
    names = [s.name for _, s in graph.splice(main, module.body.stmts) if isinstance(s, ast.Assign)]
    assert names == ["a"]


def test_use_makes_a_namespace_of_the_used_file_and_its_includes(tmp_path: Path) -> None:
    inc = write(tmp_path, "inc.scad", "i = 1;")
    lib = write(tmp_path, "lib.scad", "include <inc.scad>\nmodule m() {}")
    main = write(tmp_path, "main.scad", "use <lib.scad>")
    graph = load_graph(main)
    assert graph.main.uses == (lib,)
    assert [(n.root, n.files) for n in graph.used] == [(lib, (lib, inc))]


def test_used_namespaces_are_ordered_dependencies_first(tmp_path: Path) -> None:
    c = write(tmp_path, "c.scad", "")
    b = write(tmp_path, "b.scad", "use <c.scad>")
    a = write(tmp_path, "a.scad", "use <b.scad>\nuse <c.scad>")
    main = write(tmp_path, "main.scad", "use <a.scad>\nuse <c.scad>")
    assert [n.root for n in load_graph(main).used] == [c, b, a]


def test_nested_use_is_not_reexported(tmp_path: Path) -> None:
    b = write(tmp_path, "b.scad", "")
    a = write(tmp_path, "a.scad", "use <b.scad>")
    main = write(tmp_path, "main.scad", "use <a.scad>")
    graph = load_graph(main)
    assert graph.main.uses == (a,)
    assert [n.root for n in graph.used] == [b, a]


def test_use_in_an_included_file_joins_the_namespace(tmp_path: Path) -> None:
    lib = write(tmp_path, "lib.scad", "")
    write(tmp_path, "inc.scad", "use <lib.scad>")
    main = write(tmp_path, "main.scad", "include <inc.scad>")
    assert load_graph(main).main.uses == (lib,)


def test_library_dirs_and_search_order(tmp_path: Path) -> None:
    write(tmp_path, "near/x.scad", "near = 1;")
    far = write(tmp_path, "far/x.scad", "far = 1;")
    write(tmp_path, "far/y.scad", "")
    write(tmp_path, "env/y.scad", "")
    main = write(tmp_path, "near/main.scad", "include <x.scad>\ninclude <y.scad>")
    env = {"OPENSCADPATH": str(tmp_path / "env")}
    graph = load(main, [tmp_path / "far"], env)
    assert spliced_names(graph, main) == ["near"]
    assert graph.links[(main, main.read_text().index("include <y"))] == far.with_name("y.scad")


def test_library_dirs_splits_openscadpath() -> None:
    dirs = library_dirs([Path("l")], {"OPENSCADPATH": "a:b::c"})
    assert dirs == (Path("l"), Path("a"), Path("b"), Path("c"))


def test_nested_include_searches_its_own_directory_not_the_main_one(tmp_path: Path) -> None:
    write(tmp_path, "c.scad", "")
    write(tmp_path, "sub/s.scad", "include <c.scad>")
    main = write(tmp_path, "main.scad", "include <sub/s.scad>")
    with pytest.raises(LoadError, match=r"cannot find 'c\.scad'"):
        load_graph(main)


def test_symlinked_file_resolves_relative_includes_from_its_target(tmp_path: Path) -> None:
    write(tmp_path, "proj/b.scad", "wrong = 1;")
    write(tmp_path, "store/b.scad", "right = 1;")
    write(tmp_path, "store/a.scad", "include <b.scad>")
    (tmp_path / "proj" / "lnk.scad").symlink_to(tmp_path / "store" / "a.scad")
    main = write(tmp_path, "proj/main.scad", "include <lnk.scad>")
    graph = load_graph(main)
    assert spliced_names(graph, main) == ["right"]


def test_symlinked_directory_resolves_relative_includes_from_its_target(tmp_path: Path) -> None:
    write(tmp_path, "store/pkg/d.scad", "right = 1;")
    write(tmp_path, "store/pkg/e.scad", "include <d.scad>")
    (tmp_path / "proj").mkdir()
    (tmp_path / "proj" / "lnk").symlink_to(tmp_path / "store" / "pkg")
    main = write(tmp_path, "proj/main.scad", "include <lnk/e.scad>")
    assert spliced_names(load_graph(main), main) == ["right"]


def test_symlink_and_target_are_one_file(tmp_path: Path) -> None:
    target = write(tmp_path, "a.scad", "a = 1;")
    (tmp_path / "link.scad").symlink_to(target)
    main = write(tmp_path, "main.scad", "include <a.scad>\ninclude <link.scad>")
    graph = load_graph(main)
    assert graph.main.files == (main, target)
    assert len(graph.files) == 2


def test_resolve_prefers_files_over_directories(tmp_path: Path) -> None:
    (tmp_path / "x.scad").mkdir()
    assert resolve("x.scad", tmp_path, ()) is None


def test_absolute_reference(tmp_path: Path) -> None:
    target = write(tmp_path, "abs.scad", "")
    assert resolve(str(target), tmp_path / "elsewhere", ()) == target


def test_missing_file_lists_searched_directories(tmp_path: Path) -> None:
    main = write(tmp_path, "main.scad", "\n  include <nope.scad>")
    lib = tmp_path / "lib"
    with pytest.raises(LoadError) as info:
        load_graph(main, (lib,))
    message = str(info.value)
    assert f"{main}:2:3:" in message
    assert "cannot find 'nope.scad'" in message
    assert f"searched: {tmp_path.resolve()}, {lib}" in message


def test_missing_main_file(tmp_path: Path) -> None:
    with pytest.raises(LoadError, match="no such file"):
        load_graph(tmp_path / "none.scad")


def test_include_cycle(tmp_path: Path) -> None:
    write(tmp_path, "a.scad", "include <b.scad>")
    write(tmp_path, "b.scad", "include <a.scad>")
    main = write(tmp_path, "main.scad", "include <a.scad>")
    with pytest.raises(LoadError, match=r"include cycle: .*a\.scad -> .*b\.scad -> .*a\.scad"):
        load_graph(main)


def test_self_include_is_a_cycle(tmp_path: Path) -> None:
    main = write(tmp_path, "main.scad", "include <main.scad>")
    with pytest.raises(LoadError, match="include cycle"):
        load_graph(main)


def test_use_cycle(tmp_path: Path) -> None:
    write(tmp_path, "a.scad", "use <b.scad>")
    write(tmp_path, "b.scad", "use <a.scad>")
    main = write(tmp_path, "main.scad", "use <a.scad>")
    with pytest.raises(LoadError, match="use cycle"):
        load_graph(main)


@pytest.mark.parametrize(
    "body",
    ["module m() { use <a.scad> }", "if (true) { use <a.scad> }", "cube() use <a.scad>;"],
)
def test_use_outside_top_level(tmp_path: Path, body: str) -> None:
    write(tmp_path, "a.scad", "")
    main = write(tmp_path, "main.scad", body)
    with pytest.raises(LoadError, match="use is only allowed at top level"):
        load_graph(main)


def test_use_in_a_file_included_from_a_module_body(tmp_path: Path) -> None:
    write(tmp_path, "lib.scad", "")
    write(tmp_path, "inc.scad", "use <lib.scad>")
    main = write(tmp_path, "main.scad", "module m() { include <inc.scad> }")
    with pytest.raises(LoadError, match="use is only allowed at top level"):
        load_graph(main)


def test_syntax_error_names_file_and_position(tmp_path: Path) -> None:
    main = write(tmp_path, "main.scad", "a = 1;\nb = ;")
    with pytest.raises(LoadError, match=r"main.scad:2:5: expected expression"):
        load_graph(main)


def test_undecodable_file(tmp_path: Path) -> None:
    main = tmp_path / "main.scad"
    main.write_bytes(b"\xff\xfe")
    with pytest.raises(LoadError, match="cannot read"):
        load_graph(main)


def test_bosl2_std_loads_with_corpus_on_the_search_path(tmp_path: Path) -> None:
    main = write(tmp_path, "main.scad", "include <BOSL2/std.scad>\ncuboid(10);")
    graph = load_graph(main, (CORPUS,))
    root = CORPUS.resolve() / "BOSL2" / "std.scad"
    assert root in graph.main.files
    assert any(n.root.name == "builtins.scad" for n in graph.used)


def test_a_byte_order_mark_is_ignored(tmp_path: Path) -> None:
    path = tmp_path / "m.scad"
    path.write_bytes(b"\xef\xbb\xbfx = 1;\n")
    assert load(path, [], {}).files[path.resolve()].source == "x = 1;\n"
