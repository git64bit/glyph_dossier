#!/usr/bin/env python3
"""Extract one namespaced portable font package for Glyph Dossier.

The source font is supplied explicitly and is not copied into the output
package. The package stores its expected filename, SHA-256, license,
provenance, SVG diagnostics, and BOSL2/OpenSCAD contour records.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import shutil
import tempfile
from pathlib import Path

from fontTools.ttLib import TTFont

from extract_glyph_set import (
    extract_glyph,
    format_region,
    number,
    scad_string,
    sha256,
    write_contact_sheet,
    write_svg,
)


def constant_name(prefix, glyph_id):
    return f'{prefix}_PG_{glyph_id}'


def write_glyph_scad(output, prefix, glyph):
    values = [
        scad_string(glyph['id']),
        scad_string(glyph['character']),
        str(glyph['codepoint']),
        scad_string(glyph['glyph_name']),
        str(glyph['units_per_em']),
        str(glyph['advance_width']),
        '[' + ', '.join(number(v) for v in glyph['exact_bounds']) + ']',
        '[' + ', '.join(number(v) for v in glyph['region_bounds']) + ']',
        str(glyph['contour_count']),
        str(glyph['component_count']),
        str(glyph['counter_count']),
        str(glyph['point_count']),
        number(glyph['flatten_tolerance_font_units']),
        scad_string(glyph['source_sha256']),
        format_region(glyph['region']),
    ]
    lines = [
        '//////////////////////////////////////////////////////////////////////',
        f'// LibFile: {glyph["id"]}.scad',
        '// Project: Glyph Dossier',
        '// FileGroup: Generated Namespaced Portable Glyph',
        f'// FileSummary: {glyph["id"]} from {prefix}.',
        '//////////////////////////////////////////////////////////////////////',
        '',
        f'{constant_name(prefix, glyph["id"])} = [',
    ]
    for index, value in enumerate(values):
        suffix = ',' if index < len(values) - 1 else ''
        if '\n' in value:
            lines.append('    ' + value.replace('\n', '\n    ') + suffix)
        else:
            lines.append('    ' + value + suffix)
    lines.extend(['];', ''])
    output.write_text('\n'.join(lines), encoding='utf-8', newline='\n')


def write_manifest(output, spec, glyphs, source_sha, tolerance):
    prefix = spec['constant_prefix']
    lines = [
        '//////////////////////////////////////////////////////////////////////',
        '// LibFile: manifest.scad',
        '// Project: Glyph Dossier',
        '// FileGroup: Generated Namespaced Portable Glyph Set',
        f'// FileSummary: {spec["family"]} {spec["style"]} portable set.',
        '//////////////////////////////////////////////////////////////////////',
        '',
    ]
    for glyph in glyphs:
        lines.append(f'include <generated/scad/{glyph["id"]}.scad>')
    lines.extend([
        '',
        f'{prefix}_SET_ID = {scad_string(spec["set_id"])};',
        f'{prefix}_FAMILY = {scad_string(spec["family"])};',
        f'{prefix}_STYLE = {scad_string(spec["style"])};',
        f'{prefix}_FONT_VERSION = {scad_string(spec["font_version"])};',
        f'{prefix}_LICENSE = {scad_string(spec["license"])};',
        f'{prefix}_SOURCE_URL = {scad_string(spec["source_url"])};',
        f'{prefix}_SOURCE_FILENAME = {scad_string(spec["source_filename"])};',
        f'{prefix}_SOURCE_SHA256 = {scad_string(source_sha)};',
        f'{prefix}_FLATTEN_TOLERANCE = {number(tolerance)};',
        '',
        f'{prefix}_GLYPHS = [',
    ])
    for index, glyph in enumerate(glyphs):
        suffix = ',' if index < len(glyphs) - 1 else ''
        lines.append(f'    {constant_name(prefix, glyph["id"])}{suffix}')
    lines.extend(['];', ''])
    output.write_text('\n'.join(lines), encoding='utf-8', newline='\n')


def public_glyph(glyph):
    return {
        key: value for key, value in glyph.items()
        if key not in {'region', 'svg_path'}
    }


def grouped(glyphs, group):
    return [glyph for glyph in glyphs if glyph['group'] == group]


def package_lock(package, glyphs):
    return {
        'lock_id': package['set_id'] + '_PACKAGE_LOCK',
        'set_id': package['set_id'],
        'source_sha256': package['source_sha256'],
        'flatten_tolerance_font_units': package['flatten_tolerance_font_units'],
        'glyph_count': len(glyphs),
        'glyphs': [
            {
                'id': glyph['id'],
                'character': glyph['character'],
                'exact_bounds': glyph['exact_bounds'],
                'region_bounds': glyph['region_bounds'],
                'contour_count': glyph['contour_count'],
                'component_count': glyph['component_count'],
                'counter_count': glyph['counter_count'],
                'point_count': glyph['point_count'],
                'scad_sha256': sha256(
                    package['_stage'] / f'generated/scad/{glyph["id"]}.scad'
                ),
                'svg_sha256': sha256(
                    package['_stage'] / f'generated/svg/{glyph["id"]}.svg'
                ),
            }
            for glyph in glyphs
        ],
    }


def verify_lock(lock_path, package, glyphs):
    lock = json.loads(lock_path.read_text(encoding='utf-8'))
    assert lock['set_id'] == package['set_id']
    assert lock['source_sha256'] == package['source_sha256']
    assert float(lock['flatten_tolerance_font_units']) == float(
        package['flatten_tolerance_font_units']
    )
    by_id = {glyph['id']: glyph for glyph in glyphs}
    fields = [
        'character', 'exact_bounds', 'region_bounds', 'contour_count',
        'component_count', 'counter_count', 'point_count',
    ]
    for expected in lock['glyphs']:
        actual = by_id[expected['id']]
        for field in fields:
            if actual[field] != expected[field]:
                raise RuntimeError(
                    f'Locked field changed: {expected["id"]} {field}'
                )
        if sha256(
            package['_stage'] / f'generated/scad/{expected["id"]}.scad'
        ) != expected['scad_sha256']:
            raise RuntimeError(f'Locked SCAD changed: {expected["id"]}')
        if sha256(
            package['_stage'] / f'generated/svg/{expected["id"]}.svg'
        ) != expected['svg_sha256']:
            raise RuntimeError(f'Locked SVG changed: {expected["id"]}')
    return len(lock['glyphs'])


def write_checksums(set_dir):
    checksum_path = set_dir / 'checksums.sha256'
    files = sorted(
        path for path in set_dir.rglob('*')
        if path.is_file() and path != checksum_path
    )
    checksum_path.write_text(
        '\n'.join(
            f'{sha256(path)}  {path.relative_to(set_dir).as_posix()}'
            for path in files
        ) + '\n',
        encoding='utf-8',
        newline='\n',
    )


def install(stage, output):
    output.mkdir(parents=True, exist_ok=True)
    for name in ['generated', 'contact_sheets']:
        target = output / name
        if target.exists():
            shutil.rmtree(target)
        shutil.copytree(stage / name, target)
    for name in ['manifest.scad', 'set.json', 'contact_sheet.svg']:
        shutil.copy2(stage / name, output / name)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--font', required=True, type=Path)
    parser.add_argument('--font-spec', required=True, type=Path)
    parser.add_argument('--glyph-spec', required=True, type=Path)
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--lock', type=Path)
    parser.add_argument('--create-lock', action='store_true')
    args = parser.parse_args()

    spec = json.loads(args.font_spec.read_text(encoding='utf-8'))
    glyph_spec = json.loads(args.glyph_spec.read_text(encoding='utf-8'))
    source_sha = sha256(args.font)
    if source_sha != spec['source_sha256_expected']:
        raise RuntimeError(
            'Source font checksum mismatch: '
            f'{source_sha} != {spec["source_sha256_expected"]}'
        )

    font = TTFont(args.font)
    glyph_set = font.getGlyphSet()
    cmap = font.getBestCmap()
    tolerance = float(spec['flatten_tolerance_font_units'])

    args.out.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(
        prefix='.glyph_dossier_namespaced_',
        dir=args.out.parent,
    ) as temporary:
        stage = Path(temporary)
        (stage / 'generated/scad').mkdir(parents=True)
        (stage / 'generated/svg').mkdir(parents=True)
        (stage / 'contact_sheets').mkdir(parents=True)

        glyphs = []
        for item in glyph_spec['glyphs']:
            glyph = extract_glyph(
                font, glyph_set, cmap, item, tolerance, source_sha
            )
            glyphs.append(glyph)
            write_glyph_scad(
                stage / f'generated/scad/{glyph["id"]}.scad',
                spec['constant_prefix'],
                glyph,
            )
            write_svg(
                stage / f'generated/svg/{glyph["id"]}.svg',
                glyph,
            )

        write_manifest(stage / 'manifest.scad', spec, glyphs, source_sha, tolerance)
        groups = {
            group: len(grouped(glyphs, group))
            for group in ['uppercase', 'lowercase', 'digit', 'punctuation']
        }
        set_record = {
            **spec,
            'source_sha256': source_sha,
            'glyph_count': len(glyphs),
            'group_counts': groups,
            'glyphs': [public_glyph(glyph) for glyph in glyphs],
        }
        (stage / 'set.json').write_text(
            json.dumps(set_record, indent=2, ensure_ascii=False) + '\n',
            encoding='utf-8',
            newline='\n',
        )
        write_contact_sheet(stage / 'contact_sheet.svg', glyphs, columns=8)
        by_group = {
            'uppercase': grouped(glyphs, 'uppercase'),
            'lowercase': grouped(glyphs, 'lowercase'),
            'digits': grouped(glyphs, 'digit'),
            'punctuation': grouped(glyphs, 'punctuation'),
        }
        for group, records in by_group.items():
            columns = 7 if group in {'uppercase', 'lowercase'} else 5
            write_contact_sheet(
                stage / f'contact_sheets/{group}.svg',
                records,
                columns=columns,
            )

        package = {
            **set_record,
            '_stage': stage,
        }
        locked = 0
        if args.lock:
            locked = verify_lock(args.lock, package, glyphs)

        install(stage, args.out)
        if args.create_lock:
            lock = package_lock(package, glyphs)
            (args.out / 'package_lock.json').write_text(
                json.dumps(lock, indent=2, ensure_ascii=False) + '\n',
                encoding='utf-8',
                newline='\n',
            )
            locked = len(glyphs)
        write_checksums(args.out)

    print(json.dumps({
        'set_id': spec['set_id'],
        'glyph_count': len(glyphs),
        'group_counts': groups,
        'contours': sum(g['contour_count'] for g in glyphs),
        'points': sum(g['point_count'] for g in glyphs),
        'locked_glyphs': locked,
        'source_sha256': source_sha,
    }, indent=2))


if __name__ == '__main__':
    main()
