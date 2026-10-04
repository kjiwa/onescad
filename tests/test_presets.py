import json
from pathlib import Path

import pytest

from onescad.errors import BundleError
from onescad.presets import copy_presets, find_presets, inert_keys, preset_sets

PRESETS = {
    "fileFormatVersion": "1",
    "parameterSets": {"big": {"w": "30", "$fn": "8"}, "small": {"w": "5"}},
}


def preset_file(tmp_path: Path, data: object = PRESETS) -> Path:
    path = tmp_path / "m.json"
    path.write_text(json.dumps(data))
    return path


def test_presets_are_found_next_to_the_model_by_stem(tmp_path: Path) -> None:
    assert find_presets(tmp_path / "m.scad") is None
    path = preset_file(tmp_path)
    assert find_presets(tmp_path / "m.scad") == path


def test_preset_sets_are_read_in_file_order(tmp_path: Path) -> None:
    assert list(preset_sets(preset_file(tmp_path))) == ["big", "small"]


@pytest.mark.parametrize(
    "text",
    ["not json", "{}", '{"parameterSets": []}', '{"parameterSets": {"a": 1}}', "[]"],
)
def test_a_file_without_parameter_sets_is_rejected(tmp_path: Path, text: str) -> None:
    path = tmp_path / "m.json"
    path.write_text(text)
    with pytest.raises(BundleError, match="not a Customizer preset file"):
        preset_sets(path)


def test_keys_that_are_not_parameters_are_reported(tmp_path: Path) -> None:
    (warning,) = inert_keys(preset_file(tmp_path), {"w"})
    assert warning == "m.json: preset 'big' sets '$fn', which is not a Customizer parameter"
    assert inert_keys(preset_file(tmp_path), {"w", "$fn"}) == []


def test_presets_are_copied_verbatim(tmp_path: Path) -> None:
    source = preset_file(tmp_path)
    source.write_text('{"parameterSets":   {}}\n')
    copy_presets(source, tmp_path / "out.json")
    assert (tmp_path / "out.json").read_bytes() == source.read_bytes()
