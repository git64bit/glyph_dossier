#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

EXPECTED_GROUPS = {
    'uppercase': 26,
    'lowercase': 26,
    'digit': 10,
    'punctuation': 4,
}


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('set_dir', type=Path)
    args = parser.parse_args()
    root = args.set_dir
    record = json.loads((root / 'set.json').read_text(encoding='utf-8'))
    lock = json.loads((root / 'package_lock.json').read_text(encoding='utf-8'))

    assert record['glyph_count'] == 66
    assert record['group_counts'] == EXPECTED_GROUPS
    assert lock['glyph_count'] == 66
    assert lock['set_id'] == record['set_id']
    assert lock['source_sha256'] == record['source_sha256']
    assert record['source_sha256'] == record['source_sha256_expected']

    by_id = {glyph['id']: glyph for glyph in record['glyphs']}
    assert len(by_id) == 66
    fields = [
        'character', 'exact_bounds', 'region_bounds', 'contour_count',
        'component_count', 'counter_count', 'point_count',
    ]
    for expected in lock['glyphs']:
        actual = by_id[expected['id']]
        for field in fields:
            assert actual[field] == expected[field], (expected['id'], field)
        assert sha256(root / f'generated/scad/{expected["id"]}.scad') == expected['scad_sha256']
        assert sha256(root / f'generated/svg/{expected["id"]}.svg') == expected['svg_sha256']

    checks = {}
    for line in (root / 'checksums.sha256').read_text(encoding='utf-8').splitlines():
        digest, relative = line.split('  ', 1)
        checks[relative] = digest
    for relative, digest in checks.items():
        assert sha256(root / relative) == digest, relative

    forbidden = list(root.rglob('*.ttf')) + list(root.rglob('*.otf')) + list(root.rglob('*.woff')) + list(root.rglob('*.woff2'))
    assert not forbidden, [str(path) for path in forbidden]

    print(json.dumps({
        'set_id': record['set_id'],
        'glyph_count': record['glyph_count'],
        'locked_glyphs': lock['glyph_count'],
        'checksums_verified': len(checks),
        'source_sha256': record['source_sha256'],
        'font_binary_packaged': False,
    }, indent=2))


if __name__ == '__main__':
    main()
