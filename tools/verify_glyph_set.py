#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


EXPECTED_GROUP_COUNTS = {
    "uppercase": 26,
    "lowercase": 26,
    "digit": 10,
    "punctuation": 4,
}


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read_checksums(set_dir):
    checks = {}
    for line in (
        set_dir / "checksums.sha256"
    ).read_text(encoding="utf-8").splitlines():
        digest, relative = line.split("  ", 1)
        checks[relative] = digest
    return checks


def verify_lock(set_dir, record):
    lock = json.loads(
        (set_dir / "representative_lock.json").read_text(
            encoding="utf-8"
        )
    )
    assert lock["source_sha256"] == record["source_sha256"]
    assert (
        lock["flatten_tolerance_font_units"]
        == record["flatten_tolerance_font_units"]
    )

    by_id = {
        glyph["id"]: glyph
        for glyph in record["glyphs"]
    }
    fields = [
        "character",
        "exact_bounds",
        "region_bounds",
        "contour_count",
        "component_count",
        "counter_count",
        "point_count",
    ]

    for expected in lock["glyphs"]:
        actual = by_id[expected["id"]]
        for field in fields:
            assert actual[field] == expected[field], (
                expected["id"],
                field,
            )
        assert sha256(
            set_dir
            / f'generated/scad/{expected["id"]}.scad'
        ) == expected["scad_sha256"]
        assert sha256(
            set_dir
            / f'generated/svg/{expected["id"]}.svg'
        ) == expected["svg_sha256"]

    assert len(lock["glyphs"]) == 20
    return len(lock["glyphs"])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("set_dir", type=Path)
    args = parser.parse_args()
    set_dir = args.set_dir

    record = json.loads(
        (set_dir / "set.json").read_text(
            encoding="utf-8"
        )
    )
    font = (
        set_dir
        / "source/LiberationSans-Regular.ttf"
    )

    assert sha256(font) == record["source_sha256"]
    assert record["glyph_count"] == 66
    assert len(record["glyphs"]) == 66
    assert record["group_counts"] == EXPECTED_GROUP_COUNTS
    assert record["representative_glyph_count"] == 20

    ids = [glyph["id"] for glyph in record["glyphs"]]
    assert len(ids) == len(set(ids))

    for glyph in record["glyphs"]:
        assert (
            set_dir
            / f'generated/scad/{glyph["id"]}.scad'
        ).is_file()
        assert (
            set_dir
            / f'generated/svg/{glyph["id"]}.svg'
        ).is_file()
        assert glyph["contour_count"] >= 1
        assert glyph["point_count"] >= 3
        assert (
            glyph["component_count"]
            + glyph["counter_count"]
            == glyph["contour_count"]
        )

    locked = verify_lock(set_dir, record)

    checks = read_checksums(set_dir)
    for relative, digest in checks.items():
        assert sha256(set_dir / relative) == digest, relative

    required_sheets = [
        "contact_sheets/uppercase.svg",
        "contact_sheets/lowercase.svg",
        "contact_sheets/digits.svg",
        "contact_sheets/punctuation.svg",
        "contact_sheets/representative.svg",
    ]
    for relative in required_sheets:
        assert (set_dir / relative).is_file()

    manifest = (
        set_dir / "manifest.scad"
    ).read_text(encoding="utf-8")
    for name in [
        "PORTABLE_UPPERCASE_IDS",
        "PORTABLE_LOWERCASE_IDS",
        "PORTABLE_DIGIT_IDS",
        "PORTABLE_PUNCTUATION_IDS",
        "PORTABLE_REPRESENTATIVE_IDS",
        "PORTABLE_ALL_IDS",
    ]:
        assert name in manifest

    print(json.dumps({
        "set_id": record["set_id"],
        "glyph_count": record["glyph_count"],
        "group_counts": record["group_counts"],
        "locked_glyphs": locked,
        "source_sha256": record["source_sha256"],
        "checksums_verified": len(checks),
    }, indent=2))


if __name__ == "__main__":
    main()
