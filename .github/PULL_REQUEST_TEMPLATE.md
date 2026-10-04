## Checklist

- [ ] `uv run ruff check` and `uv run ruff format --check` pass
- [ ] `uv run mypy` and `uv run pytest` pass
- [ ] A fixture or test covers the behavior this PR changes
- [ ] `uv run pytest -m oracle --no-cov` passes if the bundle's output could change
