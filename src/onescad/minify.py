"""Strips comments and indentation while keeping one line per run of statements, so the bundle
stays diffable and errors point at a short line."""

from onescad.lexer import TRIVIA, Kind, lex


def minify(text: str) -> str:
    """Each run of whitespace and comments between two tokens becomes a newline if it holds one,
    else a space; a space keeps neighbors like `a/*x*/b` and `- -1` from merging."""
    out: list[str] = []
    gap = ""
    for token in lex(text):
        if token.kind is Kind.EOF:
            break
        if token.kind in TRIVIA:
            gap += token.text
            continue
        if out and gap:
            out.append("\n" if "\n" in gap else " ")
        gap = ""
        out.append(token.text)
    return "".join(out) + "\n"
