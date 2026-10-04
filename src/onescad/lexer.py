"""Lossless OpenSCAD lexer: whitespace and comments are tokens, so token texts concatenate
back to the source."""

import re
from dataclasses import dataclass
from enum import Enum, auto


class Kind(Enum):
    WS = auto()
    COMMENT = auto()
    IDENT = auto()
    NUMBER = auto()
    STRING = auto()
    PATH = auto()
    OP = auto()
    EOF = auto()


TRIVIA = frozenset({Kind.WS, Kind.COMMENT})


@dataclass(frozen=True, slots=True)
class Token:
    kind: Kind
    text: str
    start: int

    @property
    def end(self) -> int:
        return self.start + len(self.text)


class ScadSyntaxError(Exception):
    def __init__(self, message: str, pos: int) -> None:
        super().__init__(message)
        self.pos = pos


def line_col(source: str, pos: int) -> tuple[int, int]:
    line = source.count("\n", 0, pos) + 1
    return line, pos - (source.rfind("\n", 0, pos) + 1) + 1


_WS = re.compile(r"\s+")
_LINE_COMMENT = re.compile(r"//[^\n]*")
_BLOCK_COMMENT = re.compile(r"/\*.*?\*/", re.DOTALL)
# OpenSCAD's lexer is flex: longest match wins and ties go to the earlier rule, so `3d` is an
# identifier while `3` and `2e3` are numbers.
_NUMBER = re.compile(r"0x[0-9a-fA-F]+|(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?")
_IDENT = re.compile(r"\$?[A-Za-z0-9_]+")
_STRING = re.compile(r'"(?:[^"\\]|\\.)*"', re.DOTALL)
_PATH = re.compile(r"<[^\t\r\n>]*>")
_OP = re.compile(r"<=|>=|==|!=|&&|\|\||<<|>>|[-+*/%^<>!?:;,.=()\[\]{}#&|~]")
_FILE_KEYWORDS = frozenset({"include", "use"})


def _longest_word(source: str, pos: int) -> tuple[Kind, str] | None:
    number = _NUMBER.match(source, pos)
    ident = _IDENT.match(source, pos)
    if number and (not ident or len(number[0]) >= len(ident[0])):
        return Kind.NUMBER, number[0]
    if ident:
        return Kind.IDENT, ident[0]
    return None


def _match_at(source: str, pos: int, after_file_keyword: bool) -> tuple[Kind, str]:
    for kind, pattern in (
        (Kind.WS, _WS),
        (Kind.COMMENT, _LINE_COMMENT),
        (Kind.COMMENT, _BLOCK_COMMENT),
        (Kind.STRING, _STRING),
    ):
        if m := pattern.match(source, pos):
            return kind, m[0]
    if source.startswith("/*", pos):
        raise ScadSyntaxError("unterminated comment", pos)
    if after_file_keyword and (m := _PATH.match(source, pos)):
        return Kind.PATH, m[0]
    if word := _longest_word(source, pos):
        return word
    if m := _OP.match(source, pos):
        return Kind.OP, m[0]
    if source.startswith('"', pos):
        raise ScadSyntaxError("unterminated string", pos)
    raise ScadSyntaxError(f"unexpected character {source[pos]!r}", pos)


def lex(source: str) -> list[Token]:
    tokens: list[Token] = []
    pos = 0
    after_file_keyword = False
    while pos < len(source):
        kind, text = _match_at(source, pos, after_file_keyword)
        tokens.append(Token(kind, text, pos))
        pos += len(text)
        if kind is Kind.WS:
            continue
        after_file_keyword = kind is Kind.IDENT and text in _FILE_KEYWORDS
    tokens.append(Token(Kind.EOF, "", pos))
    return tokens
