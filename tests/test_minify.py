from onescad.minify import minify


def test_comments_are_dropped() -> None:
    assert minify("a = 1; // note\n/* block\n*/ b = 2;\n") == "a = 1;\nb = 2;\n"


def test_line_breaks_stay_and_blank_lines_and_indentation_go() -> None:
    assert minify("module m() {\n\n    cube(1);\n\n}\n") == "module m() {\ncube(1);\n}\n"


def test_an_inline_block_comment_leaves_a_separator() -> None:
    assert minify("a/*x*/b") == "a b\n"
    assert minify("a - /* x */ -1") == "a - -1\n"


def test_comment_markers_inside_strings_are_untouched() -> None:
    source = 's = "// not /* a comment */"; t = "  x  ";\n'
    assert minify(source) == source


def test_leading_and_trailing_trivia_are_dropped() -> None:
    assert minify("\n\n  // c\n a = 1;  \n\n") == "a = 1;\n"


def test_minify_is_idempotent() -> None:
    once = minify("// c\nmodule m() {\n  /* x */ cube(1); // y\n}\n")
    assert minify(once) == once
