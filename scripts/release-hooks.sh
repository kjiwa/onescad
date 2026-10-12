# shellcheck shell=sh
# Sourced by `gh cut`; see https://github.com/kjiwa/gh-cut.

_pyproject_version() {
  sed -n 's/^version = "\(.*\)"$/\1/p' pyproject.toml | head -n1
}

_init_version() {
  sed -n 's/^__version__ = "\(.*\)"$/\1/p' src/onescad/__init__.py | head -n1
}

release_version() {
  _release_version_pyproject=$(_pyproject_version)
  [ "$_release_version_pyproject" = "$(_init_version)" ] || return 1
  printf '%s\n' "$_release_version_pyproject"
}

release_bump() {
  sed "s/^version = \".*\"\$/version = \"$1\"/" pyproject.toml >pyproject.toml.new
  mv pyproject.toml.new pyproject.toml
  sed "s/^__version__ = \".*\"\$/__version__ = \"$1\"/" src/onescad/__init__.py >init.py.new
  mv init.py.new src/onescad/__init__.py
  uv lock
}

release_checks() {
  uv sync --locked
  uv run ruff check
  uv run ruff format --check
  uv run mypy
  uv run pytest
}
