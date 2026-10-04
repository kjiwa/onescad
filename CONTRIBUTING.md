# Contributing

## Setup and checks

```sh
git submodule update --init
uv sync --locked
uv run ruff check
uv run ruff format --check
uv run mypy
uv run pytest
```

`tests/corpus/BOSL2` is a submodule pinned to the BOSL2 revision the parser tests run against.
`pytest` fails under 90% coverage.

The oracle tests render the source and the bundle with a real `openscad` and skip without one.
CI runs them against a pinned OpenSCAD 2026.09.23 AppImage. Locally:

```sh
uv run pytest -m oracle --no-cov
```

Each fixture under `tests/fixtures/<case>/` holds a `main.scad` and a golden `expected.scad`,
or an `error.txt` for a case that must fail. Regenerate goldens with
`ONESCAD_UPDATE_GOLDEN=1`. A defect found in review is fixed with a fixture or test for its
class, not only its instance.

CI also runs `uv build`, `twine check`, and `zizmor` over the workflows.

## Releasing

```sh
sh scripts/release.sh [--dry-run] <version>
```

`<version>` is bare (`0.1.0`, not `v0.1.0`). Run it on a clean, synced `main` with `gh` and `uv`
installed. The script runs the same checks CI runs, opens a `release-<version>` PR that sets the
version in `pyproject.toml`, `src/onescad/__init__.py`, and `uv.lock`, waits for its checks, and
squash-merges it. GitHub signs the squash commit, so the release shows as Verified. It then
tags the merged commit and creates the GitHub release from the matching `CHANGELOG.md` section;
add a `## <version>` heading there first. If the bump is already on `main`, it skips the PR and
only tags and releases, so a run that stopped after the merge can be repeated. `--dry-run` runs
every check and prints each mutating command instead of running it.

The release event triggers `publish.yml`, which re-runs `scripts/check-release.sh` (the tag, its
title, and the `CHANGELOG.md` heading must all agree) before building and publishing to PyPI
through a trusted publisher.

## Scope

onescad is a single-maintainer project with no runtime dependencies. It bundles one model into
one file and checks the result. PRs that add a runtime dependency or reach past that are
declined. Bug reports and fixes are welcome.
