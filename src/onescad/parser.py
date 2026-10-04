"""Recursive-descent parser for the full OpenSCAD grammar."""

from collections.abc import Callable
from typing import TypeVar

from onescad import syntax as ast
from onescad.lexer import TRIVIA, Kind, ScadSyntaxError, Token, lex

_T = TypeVar("_T")
_BINARY_LEVELS: tuple[frozenset[str], ...] = (
    frozenset({"||"}),
    frozenset({"&&"}),
    frozenset({"==", "!="}),
    frozenset({"<", "<=", ">", ">="}),
    frozenset({"|"}),
    frozenset({"&"}),
    frozenset({"<<", ">>"}),
    frozenset({"+", "-"}),
    frozenset({"*", "/", "%"}),
)
_MODIFIERS = frozenset("!#%*")
_LITERALS = frozenset({"true", "false", "undef"})
_GENERATORS = frozenset({"for", "if", "each"})
_BODY_ENDS = frozenset({",", ";", ")", "]", "}", ":"})


def parse(source: str) -> ast.File:
    return _Parser(source).parse_file()


class _Parser:
    def __init__(self, source: str) -> None:
        self._toks = [t for t in lex(source) if t.kind not in TRIVIA]
        self._i = 0

    def _peek(self, offset: int = 0) -> Token:
        return self._toks[min(self._i + offset, len(self._toks) - 1)]

    def _next(self) -> Token:
        tok = self._peek()
        if tok.kind is not Kind.EOF:
            self._i += 1
        return tok

    @property
    def _prev_end(self) -> int:
        return self._toks[self._i - 1].end

    def _fail(self, message: str) -> ScadSyntaxError:
        tok = self._peek()
        found = repr(tok.text) if tok.kind is not Kind.EOF else "end of file"
        return ScadSyntaxError(f"{message}, found {found}", tok.start)

    def _is(self, text: str, offset: int = 0) -> bool:
        tok = self._peek(offset)
        return tok.text == text and tok.kind in (Kind.OP, Kind.IDENT)

    def _accept(self, text: str) -> bool:
        if self._is(text):
            self._next()
            return True
        return False

    def _expect(self, text: str) -> Token:
        if not self._is(text):
            raise self._fail(f"expected {text!r}")
        return self._next()

    def _ident(self) -> str:
        if self._peek().kind is not Kind.IDENT:
            raise self._fail("expected identifier")
        return self._next().text

    def _comma_list(self, close: str, item: Callable[[], _T]) -> tuple[_T, ...]:
        items: list[_T] = []
        while not self._is(close):
            items.append(item())
            if not self._accept(","):
                break
        self._expect(close)
        return tuple(items)

    # Statements

    def parse_file(self) -> ast.File:
        stmts: list[ast.Stmt] = []
        while self._peek().kind is not Kind.EOF:
            stmts.append(self._stmt())
        return ast.File(start=0, end=self._peek().end, stmts=tuple(stmts))

    def _stmt(self) -> ast.Stmt:
        start = self._peek().start
        tok = self._peek()
        if tok.kind is Kind.OP and tok.text == ";":
            self._next()
            return ast.Empty(start=start, end=self._prev_end)
        if tok.kind is Kind.IDENT:
            if (tok.text in ("include", "use")) and self._peek(1).kind is Kind.PATH:
                return self._file_ref()
            if tok.text == "module":
                return self._module_def()
            if tok.text == "function" and self._peek(1).kind is Kind.IDENT:
                return self._function_def()
            if self._is("=", 1):
                return self._assign()
        return self._instantiation()

    def _file_ref(self) -> ast.Stmt:
        start = self._peek().start
        keyword = self._next().text
        path = self._next().text[1:-1]
        end = self._prev_end
        if keyword == "include":
            return ast.Include(start=start, end=end, path=path)
        return ast.Use(start=start, end=end, path=path)

    def _assign(self) -> ast.Assign:
        start = self._peek().start
        name = self._ident()
        self._expect("=")
        value = self._expr()
        self._expect(";")
        return ast.Assign(start=start, end=self._prev_end, name=name, value=value)

    def _module_def(self) -> ast.ModuleDef:
        start = self._next().start
        name = self._ident()
        params = self._params()
        body = self._stmt()
        return ast.ModuleDef(start=start, end=self._prev_end, name=name, params=params, body=body)

    def _function_def(self) -> ast.FunctionDef:
        start = self._next().start
        name = self._ident()
        params = self._params()
        self._expect("=")
        body = self._expr()
        self._expect(";")
        return ast.FunctionDef(start=start, end=self._prev_end, name=name, params=params, body=body)

    def _instantiation(self) -> ast.Stmt:
        start = self._peek().start
        modifiers = ""
        while self._peek().kind is Kind.OP and self._peek().text in _MODIFIERS:
            modifiers += self._next().text
        if self._is("{"):
            return self._block(start, modifiers)
        if self._is("if"):
            return self._if(start, modifiers)
        name = self._ident()
        if not self._is("("):
            raise self._fail("expected statement")
        args = self._args()
        child = self._stmt()
        return ast.ModuleCall(
            start=start, end=self._prev_end, name=name, args=args, child=child, modifiers=modifiers
        )

    def _block(self, start: int, modifiers: str) -> ast.Block:
        self._expect("{")
        stmts: list[ast.Stmt] = []
        while not self._is("}"):
            if self._peek().kind is Kind.EOF:
                raise self._fail("expected '}'")
            stmts.append(self._stmt())
        self._expect("}")
        return ast.Block(start=start, end=self._prev_end, stmts=tuple(stmts), modifiers=modifiers)

    def _if(self, start: int, modifiers: str) -> ast.If:
        self._expect("if")
        self._expect("(")
        cond = self._expr()
        self._expect(")")
        then = self._stmt()
        otherwise = self._stmt() if self._accept("else") else None
        return ast.If(
            start=start,
            end=self._prev_end,
            cond=cond,
            then=then,
            otherwise=otherwise,
            modifiers=modifiers,
        )

    # Parameters and arguments

    def _params(self) -> tuple[ast.Param, ...]:
        self._expect("(")
        return self._comma_list(")", self._param)

    def _param(self) -> ast.Param:
        start = self._peek().start
        name = self._ident()
        default = self._expr() if self._accept("=") else None
        return ast.Param(start=start, end=self._prev_end, name=name, default=default)

    def _args(self) -> tuple[ast.Arg, ...]:
        self._expect("(")
        return self._comma_list(")", self._arg)

    def _arg(self) -> ast.Arg:
        start = self._peek().start
        name = None
        if self._peek().kind is Kind.IDENT and self._is("=", 1):
            name = self._next().text
            self._next()
        value = self._expr()
        return ast.Arg(start=start, end=self._prev_end, name=name, value=value)

    # Expressions

    def _expr(self) -> ast.Expr:
        start = self._peek().start
        if self._is("function") and self._is("(", 1):
            return self._function_literal(start)
        if self._is("let") and self._is("(", 1):
            self._next()
            assigns = self._args()
            body = self._element_or_expr()
            return ast.Let(start=start, end=self._prev_end, assigns=assigns, body=body)
        if self._is("assert") and self._is("(", 1):
            self._next()
            args = self._args()
            return ast.Assert(start=start, end=self._prev_end, args=args, body=self._opt_body())
        if self._is("echo") and self._is("(", 1):
            self._next()
            args = self._args()
            return ast.Echo(start=start, end=self._prev_end, args=args, body=self._opt_body())
        return self._ternary()

    def _opt_body(self) -> ast.Expr | None:
        tok = self._peek()
        if tok.kind is Kind.EOF or (tok.kind is Kind.OP and tok.text in _BODY_ENDS):
            return None
        return self._expr()

    def _function_literal(self, start: int) -> ast.FunctionLiteral:
        self._next()
        params = self._params()
        body = self._expr()
        return ast.FunctionLiteral(start=start, end=self._prev_end, params=params, body=body)

    def _ternary(self) -> ast.Expr:
        start = self._peek().start
        cond = self._binary(0)
        if not self._accept("?"):
            return cond
        then = self._expr()
        self._expect(":")
        otherwise = self._expr()
        return ast.Ternary(
            start=start, end=self._prev_end, cond=cond, then=then, otherwise=otherwise
        )

    def _binary(self, level: int) -> ast.Expr:
        if level == len(_BINARY_LEVELS):
            return self._unary()
        start = self._peek().start
        left = self._binary(level + 1)
        while self._peek().kind is Kind.OP and self._peek().text in _BINARY_LEVELS[level]:
            op = self._next().text
            right = self._binary(level + 1)
            left = ast.Binary(start=start, end=self._prev_end, op=op, left=left, right=right)
        return left

    def _unary(self) -> ast.Expr:
        tok = self._peek()
        if tok.kind is Kind.OP and tok.text in ("+", "-", "!", "~"):
            self._next()
            operand = self._unary()
            return ast.Unary(start=tok.start, end=self._prev_end, op=tok.text, operand=operand)
        return self._exponent()

    def _exponent(self) -> ast.Expr:
        start = self._peek().start
        base = self._postfix()
        if not self._accept("^"):
            return base
        exponent = self._unary()
        return ast.Binary(start=start, end=self._prev_end, op="^", left=base, right=exponent)

    def _postfix(self) -> ast.Expr:
        start = self._peek().start
        expr = self._primary()
        while True:
            if self._is("("):
                args = self._args()
                expr = ast.Call(start=start, end=self._prev_end, callee=expr, args=args)
            elif self._accept("["):
                index = self._expr()
                self._expect("]")
                expr = ast.Index(start=start, end=self._prev_end, base=expr, index=index)
            elif self._accept("."):
                name = self._ident()
                expr = ast.Member(start=start, end=self._prev_end, base=expr, name=name)
            else:
                return expr

    def _primary(self) -> ast.Expr:
        tok = self._peek()
        if tok.kind is Kind.NUMBER:
            self._next()
            return ast.Number(start=tok.start, end=tok.end, text=tok.text)
        if tok.kind is Kind.STRING:
            self._next()
            return ast.String(start=tok.start, end=tok.end, text=tok.text)
        if tok.kind is Kind.IDENT:
            self._next()
            if tok.text in _LITERALS:
                return ast.Keyword(start=tok.start, end=tok.end, text=tok.text)
            return ast.Ident(start=tok.start, end=tok.end, name=tok.text)
        if self._is("("):
            return self._paren()
        if self._is("["):
            return self._vector()
        raise self._fail("expected expression")

    def _paren(self) -> ast.Expr:
        start = self._next().start
        inner = self._element_or_expr()
        self._expect(")")
        return ast.Paren(start=start, end=self._prev_end, inner=inner)

    def _vector(self) -> ast.Expr:
        start = self._next().start
        if self._accept("]"):
            return ast.Vector(start=start, end=self._prev_end, elements=())
        first = self._element_or_expr()
        if self._accept(":"):
            return self._range(start, first)
        elements = [first]
        if self._accept(","):
            elements.extend(self._comma_list("]", self._element_or_expr))
        else:
            self._expect("]")
        return ast.Vector(start=start, end=self._prev_end, elements=tuple(elements))

    def _range(self, start: int, first: ast.Expr) -> ast.Range:
        second = self._expr()
        step = None
        last = second
        if self._accept(":"):
            step, last = second, self._expr()
        self._expect("]")
        return ast.Range(start=start, end=self._prev_end, first=first, step=step, last=last)

    # List comprehensions

    def _starts_generator(self, offset: int = 0) -> bool:
        tok = self._peek(offset)
        if tok.kind is not Kind.IDENT or tok.text not in _GENERATORS:
            return False
        return tok.text == "each" or self._is("(", offset + 1)

    def _element_or_expr(self) -> ast.Expr:
        if self._starts_generator():
            return self._generator()
        return self._expr()

    def _generator(self) -> ast.Expr:
        start = self._peek().start
        keyword = self._next().text
        if keyword == "each":
            body = self._element_or_expr()
            return ast.ListEach(start=start, end=self._prev_end, body=body)
        if keyword == "if":
            return self._list_if(start)
        return self._list_for(start)

    def _list_if(self, start: int) -> ast.ListIf:
        self._expect("(")
        cond = self._expr()
        self._expect(")")
        then = self._element_or_expr()
        otherwise = self._element_or_expr() if self._accept("else") else None
        return ast.ListIf(
            start=start, end=self._prev_end, cond=cond, then=then, otherwise=otherwise
        )

    def _list_for(self, start: int) -> ast.Expr:
        self._expect("(")
        init = self._for_clause(";", ")")
        if not self._accept(";"):
            self._expect(")")
            body = self._element_or_expr()
            return ast.ListFor(start=start, end=self._prev_end, assigns=init, body=body)
        cond = self._expr()
        self._expect(";")
        update = self._for_clause(")")
        self._expect(")")
        body = self._element_or_expr()
        return ast.ListForC(
            start=start, end=self._prev_end, init=init, cond=cond, update=update, body=body
        )

    def _for_clause(self, *stops: str) -> tuple[ast.Arg, ...]:
        args: list[ast.Arg] = []
        while not any(self._is(s) for s in stops):
            args.append(self._arg())
            if not self._accept(","):
                break
        return tuple(args)
