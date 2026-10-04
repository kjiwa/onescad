import tomllib
from pathlib import Path

import onescad


def test_version_matches_pyproject() -> None:
    pyproject = Path(__file__).parent.parent / "pyproject.toml"
    assert onescad.__version__ == tomllib.loads(pyproject.read_text())["project"]["version"]
