from pathlib import Path

import pytest

from onescad.lexer import TRIVIA, Kind, ScadSyntaxError, lex, line_col

CORPUS = Path(__file__).parent / "corpus" / "BOSL2"
CORPUS_FILES = sorted(CORPUS.rglob("*.scad"))


def significant(source: str) -> list[tuple[Kind, str]]:
    return [(t.kind, t.text) for t in lex(source) if t.kind not in TRIVIA and t.kind != Kind.EOF]


def test_corpus_is_present() -> None:
    assert CORPUS_FILES


@pytest.mark.parametrize("path", CORPUS_FILES, ids=lambda p: str(p.relative_to(CORPUS)))
def test_corpus_round_trips(path: Path) -> None:
    source = path.read_bytes().decode("utf-8")
    assert "".join(t.text for t in lex(source)) == source


def test_trivia_is_kept() -> None:
    kinds = [t.kind for t in lex("a // c\n /* d */ b")]
    assert kinds == [
        Kind.IDENT,
        Kind.WS,
        Kind.COMMENT,
        Kind.WS,
        Kind.COMMENT,
        Kind.WS,
        Kind.IDENT,
        Kind.EOF,
    ]


def test_crlf_is_preserved() -> None:
    source = "a = 1;\r\n// x\r\nb = 2;\r\n"
    assert "".join(t.text for t in lex(source)) == source


@pytest.mark.parametrize("text", ["1", "1.", ".5", "1.5e-3", "2E+4", "10"])
def test_numbers(text: str) -> None:
    assert significant(text) == [(Kind.NUMBER, text)]


@pytest.mark.parametrize("text", ["3d", "1e", "2x3", "$fn", "_a", "$vpt"])
def test_identifiers(text: str) -> None:
    assert significant(text) == [(Kind.IDENT, text)]


def test_string_escapes_and_newlines() -> None:
    assert significant('"a\\"b\nc"') == [(Kind.STRING, '"a\\"b\nc"')]


def test_comment_markers_inside_string() -> None:
    assert significant('"// not a comment"') == [(Kind.STRING, '"// not a comment"')]


def test_multi_char_operators() -> None:
    texts = [t for _, t in significant("a<=b>=c==d!=e&&f||g<<h>>i")]
    assert texts == [
        "a",
        "<=",
        "b",
        ">=",
        "c",
        "==",
        "d",
        "!=",
        "e",
        "&&",
        "f",
        "||",
        "g",
        "<<",
        "h",
        ">>",
        "i",
    ]


@pytest.mark.parametrize("keyword", ["include", "use"])
def test_path_after_file_keyword(keyword: str) -> None:
    assert significant(f"{keyword} <dir/a b.scad>") == [
        (Kind.IDENT, keyword),
        (Kind.PATH, "<dir/a b.scad>"),
    ]


def test_less_than_elsewhere_is_an_operator() -> None:
    assert significant("a < b > c")[1] == (Kind.OP, "<")


@pytest.mark.parametrize(
    ("source", "message"),
    [
        ("/* open", "unterminated comment"),
        ('"open', "unterminated string"),
        ("a @ b", "unexpected"),
    ],
)
def test_errors(source: str, message: str) -> None:
    with pytest.raises(ScadSyntaxError, match=message):
        lex(source)


def test_line_col() -> None:
    assert line_col("ab\ncd", 4) == (2, 2)
