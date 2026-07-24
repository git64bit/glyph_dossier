#!/usr/bin/env python3
from __future__ import annotations
import argparse, hashlib, json
from pathlib import Path


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('set_dir', type=Path)
    args = parser.parse_args()
    set_dir = args.set_dir
    record = json.loads((set_dir / 'set.json').read_text(encoding='utf-8'))
    font = set_dir / 'source/LiberationSans-Regular.ttf'
    assert sha256(font) == record['source_sha256']
    assert record['glyph_count'] == 20
    for glyph in record['glyphs']:
        assert (set_dir / f'generated/scad/{glyph["id"]}.scad').is_file()
        assert (set_dir / f'generated/svg/{glyph["id"]}.svg').is_file()
        assert glyph['contour_count'] >= 1
        assert glyph['point_count'] >= 3
        assert glyph['component_count'] + glyph['counter_count'] == glyph['contour_count']
    checks = {}
    for line in (set_dir / 'checksums.sha256').read_text(encoding='utf-8').splitlines():
        digest, relative = line.split('  ', 1)
        checks[relative] = digest
    for relative, digest in checks.items():
        assert sha256(set_dir / relative) == digest, relative
    print(json.dumps({
        'set_id': record['set_id'],
        'glyph_count': record['glyph_count'],
        'source_sha256': record['source_sha256'],
        'checksums_verified': len(checks),
    }, indent=2))

if __name__ == '__main__':
    main()
