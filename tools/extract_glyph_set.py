#!/usr/bin/env python3
"""Extract a portable font-independent glyph set for BOSL2/OpenSCAD.

The extractor preserves the original font, exact SVG path commands, and
flattened point-list regions. It does not require the font to be installed.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import shutil
import tempfile
from pathlib import Path
from typing import Iterable

from fontTools.ttLib import TTFont
from fontTools.pens.basePen import BasePen
from fontTools.pens.boundsPen import BoundsPen
from fontTools.pens.svgPathPen import SVGPathPen


class FlattenPen(BasePen):
    def __init__(self, glyph_set, tolerance: float):
        super().__init__(glyph_set)
        self.tolerance = tolerance
        self.paths: list[list[tuple[float, float]]] = []
        self.path: list[tuple[float, float]] = []

    def _moveTo(self, p0):
        if self.path:
            self._closePath()
        self.path = [tuple(map(float, p0))]

    def _lineTo(self, p1):
        self.path.append(tuple(map(float, p1)))

    def _curveToOne(self, p1, p2, p3):
        self._flatten_cubic(self._getCurrentPoint(), p1, p2, p3, 0)

    def _qCurveToOne(self, p1, p2):
        self._flatten_quadratic(self._getCurrentPoint(), p1, p2, 0)

    def _closePath(self):
        if self.path:
            clean = remove_collinear(remove_duplicate_points(self.path))
            if len(clean) >= 3:
                self.paths.append(clean)
            self.path = []

    def _endPath(self):
        self._closePath()

    @staticmethod
    def _distance_to_line(point, start, end):
        dx = end[0] - start[0]
        dy = end[1] - start[1]
        if dx == 0 and dy == 0:
            return math.hypot(point[0] - start[0], point[1] - start[1])
        return abs(
            dy * point[0] - dx * point[1]
            + end[0] * start[1] - end[1] * start[0]
        ) / math.hypot(dx, dy)

    def _flatten_quadratic(self, p0, p1, p2, depth):
        if depth >= 20 or self._distance_to_line(p1, p0, p2) <= self.tolerance:
            self.path.append(tuple(map(float, p2)))
            return
        p01 = midpoint(p0, p1)
        p12 = midpoint(p1, p2)
        p012 = midpoint(p01, p12)
        self._flatten_quadratic(p0, p01, p012, depth + 1)
        self._flatten_quadratic(p012, p12, p2, depth + 1)

    def _flatten_cubic(self, p0, p1, p2, p3, depth):
        flatness = max(
            self._distance_to_line(p1, p0, p3),
            self._distance_to_line(p2, p0, p3),
        )
        if depth >= 20 or flatness <= self.tolerance:
            self.path.append(tuple(map(float, p3)))
            return
        p01 = midpoint(p0, p1)
        p12 = midpoint(p1, p2)
        p23 = midpoint(p2, p3)
        p012 = midpoint(p01, p12)
        p123 = midpoint(p12, p23)
        p0123 = midpoint(p012, p123)
        self._flatten_cubic(p0, p01, p012, p0123, depth + 1)
        self._flatten_cubic(p0123, p123, p23, p3, depth + 1)


def midpoint(a, b):
    return ((a[0] + b[0]) / 2, (a[1] + b[1]) / 2)


def remove_duplicate_points(points):
    result = []
    for point in points:
        point = tuple(map(float, point))
        if not result or point != result[-1]:
            result.append(point)
    if len(result) > 1 and result[0] == result[-1]:
        result.pop()
    return result


def remove_collinear(points, epsilon=1e-9):
    if len(points) < 4:
        return points
    result = []
    count = len(points)
    for index, point in enumerate(points):
        previous = points[(index - 1) % count]
        following = points[(index + 1) % count]
        cross = (
            (point[0] - previous[0]) * (following[1] - point[1])
            - (point[1] - previous[1]) * (following[0] - point[0])
        )
        if abs(cross) > epsilon:
            result.append(point)
    return result if len(result) >= 3 else points


def signed_area(path):
    return sum(
        path[index][0] * path[(index + 1) % len(path)][1]
        - path[(index + 1) % len(path)][0] * path[index][1]
        for index in range(len(path))
    ) / 2


def normalize_winding(paths):
    areas = [signed_area(path) for path in paths]
    largest_index = max(range(len(paths)), key=lambda i: abs(areas[i]))
    # BOSL2 font regions are emitted with clockwise outer contours.
    if areas[largest_index] > 0:
        paths = [list(reversed(path)) for path in paths]
        areas = [-area for area in areas]
    components = sum(1 for area in areas if area < 0)
    counters = sum(1 for area in areas if area > 0)
    return paths, components, counters


def number(value):
    rounded = round(float(value), 6)
    if abs(rounded - round(rounded)) < 1e-9:
        return str(int(round(rounded)))
    return f'{rounded:.6f}'.rstrip('0').rstrip('.')


def scad_string(value):
    return json.dumps(value, ensure_ascii=False)


def format_path(path, indent='            ', points_per_line=4):
    chunks = []
    for start in range(0, len(path), points_per_line):
        values = ', '.join(
            f'[{number(x)}, {number(y)}]' for x, y in path[start:start+points_per_line]
        )
        chunks.append(indent + values)
    return ',\n'.join(chunks)


def format_region(paths):
    blocks = []
    for path in paths:
        blocks.append('        [\n' + format_path(path) + '\n        ]')
    return '[\n' + ',\n'.join(blocks) + '\n    ]'


def glyph_constant(glyph_id):
    return 'PG_' + glyph_id


def bounds_from_paths(paths):
    xs = [point[0] for path in paths for point in path]
    ys = [point[1] for path in paths for point in path]
    return [min(xs), min(ys), max(xs), max(ys)]



def extract_glyph(
    font,
    glyph_set,
    cmap,
    item,
    tolerance,
    source_sha,
):
    glyph_id = item['id']
    character = item['character']
    codepoint = ord(character)
    if codepoint not in cmap:
        raise ValueError(
            f'Font has no glyph for U+{codepoint:04X} {character!r}'
        )
    glyph_name = cmap[codepoint]
    glyph = glyph_set[glyph_name]

    flatten_pen = FlattenPen(glyph_set, tolerance)
    glyph.draw(flatten_pen)
    flatten_pen._endPath()
    paths, components, counters = normalize_winding(
        flatten_pen.paths
    )

    bounds_pen = BoundsPen(glyph_set)
    glyph.draw(bounds_pen)
    exact_bounds = list(bounds_pen.bounds or (0, 0, 0, 0))

    svg_pen = SVGPathPen(glyph_set)
    glyph.draw(svg_pen)
    svg_path = svg_pen.getCommands()

    advance_width = font['hmtx'].metrics[glyph_name][0]
    region_bounds = bounds_from_paths(paths)
    point_count = sum(len(path) for path in paths)

    return {
        'id': glyph_id,
        'character': character,
        'group': item['group'],
        'representative': bool(item.get('representative', False)),
        'codepoint': codepoint,
        'glyph_name': glyph_name,
        'units_per_em': font['head'].unitsPerEm,
        'advance_width': advance_width,
        'exact_bounds': exact_bounds,
        'region_bounds': region_bounds,
        'contour_count': len(paths),
        'component_count': components,
        'counter_count': counters,
        'point_count': point_count,
        'flatten_tolerance_font_units': tolerance,
        'source_sha256': source_sha,
        'svg_path': svg_path,
        'region': paths,
    }


def write_glyph_scad(output, glyph):
    record = [
        scad_string(glyph['id']),
        scad_string(glyph['character']),
        str(glyph['codepoint']),
        scad_string(glyph['glyph_name']),
        str(glyph['units_per_em']),
        str(glyph['advance_width']),
        '[' + ', '.join(
            number(value) for value in glyph['exact_bounds']
        ) + ']',
        '[' + ', '.join(
            number(value) for value in glyph['region_bounds']
        ) + ']',
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
        '// FileGroup: Generated Portable Glyph',
        f'// FileSummary: {glyph["id"]} from captured font outline.',
        '//////////////////////////////////////////////////////////////////////',
        '',
        f'{glyph_constant(glyph["id"])} = [',
    ]
    for index, value in enumerate(record):
        suffix = ',' if index < len(record) - 1 else ''
        if '\n' in value:
            lines.append(
                '    ' + value.replace('\n', '\n    ') + suffix
            )
        else:
            lines.append('    ' + value + suffix)
    lines.extend(['];', ''])
    output.write_text(
        '\n'.join(lines),
        encoding='utf-8',
        newline='\n',
    )


def write_svg(output, glyph):
    x0, y0, x1, y1 = glyph['exact_bounds']
    width = max(1, x1 - x0)
    height = max(1, y1 - y0)
    margin = max(width, height) * 0.04
    view_x = x0 - margin
    view_y = -y1 - margin
    view_w = width + 2 * margin
    view_h = height + 2 * margin
    svg = f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="{number(view_x)} {number(view_y)} {number(view_w)} {number(view_h)}">
  <title>{glyph['id']} U+{glyph['codepoint']:04X}</title>
  <path d="{glyph['svg_path']}" transform="scale(1,-1)" fill="black" fill-rule="nonzero"/>
</svg>
"""
    output.write_text(
        svg,
        encoding='utf-8',
        newline='\n',
    )


def write_contact_sheet(
    output,
    glyphs,
    columns=5,
    cell=420,
    glyph_height=260,
):
    rows = math.ceil(len(glyphs) / columns)
    fragments = [
        (
            '<svg xmlns="http://www.w3.org/2000/svg" '
            f'viewBox="0 0 {columns * cell} {rows * cell}">'
        ),
        '  <rect width="100%" height="100%" fill="white"/>',
    ]
    for index, glyph in enumerate(glyphs):
        col = index % columns
        row = index // columns
        x0, y0, x1, y1 = glyph['exact_bounds']
        width = max(1, x1 - x0)
        height = max(1, y1 - y0)
        scale = glyph_height / height
        center_x = (x0 + x1) / 2
        bottom = y0
        tx = col * cell + cell / 2 - center_x * scale
        ty = (
            row * cell
            + (cell + glyph_height) / 2
            + bottom * scale
        )
        fragments.append(
            f'  <rect x="{col * cell}" y="{row * cell}" '
            f'width="{cell}" height="{cell}" '
            'fill="none" stroke="#bbb"/>'
        )
        fragments.append(
            f'  <path d="{glyph["svg_path"]}" '
            f'transform="translate({number(tx)} {number(ty)}) '
            f'scale({number(scale)} {number(-scale)})" '
            'fill="black"/>'
        )
    fragments.append('</svg>')
    output.write_text(
        '\n'.join(fragments) + '\n',
        encoding='utf-8',
        newline='\n',
    )


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_checksums(set_dir):
    checksum_path = set_dir / 'checksums.sha256'
    files = sorted(
        path for path in set_dir.rglob('*')
        if path.is_file() and path != checksum_path
    )
    lines = [
        f'{sha256(path)}  {path.relative_to(set_dir).as_posix()}'
        for path in files
    ]
    checksum_path.write_text(
        '\n'.join(lines) + '\n',
        encoding='utf-8',
        newline='\n',
    )


def public_glyph_record(glyph):
    excluded = {'region', 'svg_path'}
    return {
        key: value
        for key, value in glyph.items()
        if key not in excluded
    }


def grouped_ids(glyphs, group):
    return [
        glyph['id']
        for glyph in glyphs
        if glyph['group'] == group
    ]


def write_id_array(lines, name, ids):
    lines.append(f'{name} = [')
    for index, glyph_id in enumerate(ids):
        suffix = ',' if index < len(ids) - 1 else ''
        lines.append(f'    {scad_string(glyph_id)}{suffix}')
    lines.extend(['];', ''])


def write_manifest(output, spec, glyphs, source_sha, tolerance):
    lines = [
        '//////////////////////////////////////////////////////////////////////',
        '// LibFile: manifest.scad',
        '// Project: Glyph Dossier',
        '// FileGroup: Generated Portable Glyph Set',
        '// FileSummary: Liberation Sans Regular complete dossier set.',
        '//////////////////////////////////////////////////////////////////////',
        '',
    ]
    for glyph in glyphs:
        lines.append(
            f'include <generated/scad/{glyph["id"]}.scad>'
        )
    lines.extend([
        '',
        f'PORTABLE_GLYPH_SET_ID = {scad_string(spec["set_id"])};',
        f'PORTABLE_GLYPH_FAMILY = {scad_string(spec["family"])};',
        f'PORTABLE_GLYPH_STYLE = {scad_string(spec["style"])};',
        (
            'PORTABLE_GLYPH_FONT_VERSION = '
            f'{scad_string(spec["font_version"])};'
        ),
        f'PORTABLE_GLYPH_LICENSE = {scad_string(spec["license"])};',
        (
            'PORTABLE_GLYPH_SOURCE_URL = '
            f'{scad_string(spec["source_url"])};'
        ),
        (
            'PORTABLE_GLYPH_SOURCE_SHA256 = '
            f'{scad_string(source_sha)};'
        ),
        (
            'PORTABLE_GLYPH_FLATTEN_TOLERANCE = '
            f'{number(tolerance)};'
        ),
        '',
    ])

    write_id_array(
        lines,
        'PORTABLE_UPPERCASE_IDS',
        grouped_ids(glyphs, 'uppercase'),
    )
    write_id_array(
        lines,
        'PORTABLE_LOWERCASE_IDS',
        grouped_ids(glyphs, 'lowercase'),
    )
    write_id_array(
        lines,
        'PORTABLE_DIGIT_IDS',
        grouped_ids(glyphs, 'digit'),
    )
    write_id_array(
        lines,
        'PORTABLE_PUNCTUATION_IDS',
        grouped_ids(glyphs, 'punctuation'),
    )
    write_id_array(
        lines,
        'PORTABLE_REPRESENTATIVE_IDS',
        [
            glyph['id']
            for glyph in glyphs
            if glyph['representative']
        ],
    )
    write_id_array(
        lines,
        'PORTABLE_ALL_IDS',
        [glyph['id'] for glyph in glyphs],
    )

    lines.append('PORTABLE_GLYPHS = [')
    for index, glyph in enumerate(glyphs):
        suffix = ',' if index < len(glyphs) - 1 else ''
        lines.append(
            f'    {glyph_constant(glyph["id"])}{suffix}'
        )
    lines.extend(['];', ''])

    output.write_text(
        '\n'.join(lines),
        encoding='utf-8',
        newline='\n',
    )


def verify_lock(lock_path, stage_dir, glyphs, source_sha, tolerance):
    if lock_path is None:
        return {'locked_glyphs': 0}

    lock = json.loads(lock_path.read_text(encoding='utf-8'))
    if lock['source_sha256'] != source_sha:
        raise RuntimeError('Representative lock source checksum changed.')
    if (
        float(lock['flatten_tolerance_font_units'])
        != float(tolerance)
    ):
        raise RuntimeError('Representative lock tolerance changed.')

    by_id = {glyph['id']: glyph for glyph in glyphs}
    checked = 0
    for expected in lock['glyphs']:
        glyph_id = expected['id']
        if glyph_id not in by_id:
            raise RuntimeError(
                f'Locked glyph is absent from extraction: {glyph_id}'
            )
        actual = by_id[glyph_id]
        fields = [
            'character',
            'exact_bounds',
            'region_bounds',
            'contour_count',
            'component_count',
            'counter_count',
            'point_count',
        ]
        for field in fields:
            if actual[field] != expected[field]:
                raise RuntimeError(
                    f'Locked field changed for {glyph_id}: '
                    f'{field}: {actual[field]!r} != '
                    f'{expected[field]!r}'
                )

        scad_path = stage_dir / f'generated/scad/{glyph_id}.scad'
        svg_path = stage_dir / f'generated/svg/{glyph_id}.svg'
        if sha256(scad_path) != expected['scad_sha256']:
            raise RuntimeError(
                f'Locked SCAD record changed: {glyph_id}'
            )
        if sha256(svg_path) != expected['svg_sha256']:
            raise RuntimeError(
                f'Locked SVG record changed: {glyph_id}'
            )
        checked += 1

    if checked != lock['glyph_count']:
        raise RuntimeError(
            f'Expected {lock["glyph_count"]} locked glyphs; '
            f'checked {checked}.'
        )
    return {
        'lock_id': lock['lock_id'],
        'locked_glyphs': checked,
    }


def install_stage(stage_dir, output_dir):
    output_dir.mkdir(parents=True, exist_ok=True)

    generated_target = output_dir / 'generated'
    if generated_target.exists():
        shutil.rmtree(generated_target)
    shutil.copytree(stage_dir / 'generated', generated_target)

    contact_target = output_dir / 'contact_sheets'
    if contact_target.exists():
        shutil.rmtree(contact_target)
    shutil.copytree(stage_dir / 'contact_sheets', contact_target)

    for name in ['manifest.scad', 'set.json', 'contact_sheet.svg']:
        shutil.copy2(stage_dir / name, output_dir / name)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--font', required=True, type=Path)
    parser.add_argument('--spec', required=True, type=Path)
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--lock', type=Path)
    args = parser.parse_args()

    spec = json.loads(
        args.spec.read_text(encoding='utf-8')
    )
    font = TTFont(args.font)
    glyph_set = font.getGlyphSet()
    cmap = font.getBestCmap()
    source_sha = sha256(args.font)
    tolerance = float(
        spec['flatten_tolerance_font_units']
    )

    args.out.parent.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory(
        prefix='.glyph_dossier_extract_',
        dir=args.out.parent,
    ) as temporary:
        stage = Path(temporary)
        svg_dir = stage / 'generated/svg'
        scad_dir = stage / 'generated/scad'
        contact_dir = stage / 'contact_sheets'
        svg_dir.mkdir(parents=True, exist_ok=True)
        scad_dir.mkdir(parents=True, exist_ok=True)
        contact_dir.mkdir(parents=True, exist_ok=True)

        glyphs = []
        for item in spec['glyphs']:
            glyph = extract_glyph(
                font,
                glyph_set,
                cmap,
                item,
                tolerance,
                source_sha,
            )
            glyphs.append(glyph)
            write_glyph_scad(
                scad_dir / f'{item["id"]}.scad',
                glyph,
            )
            write_svg(
                svg_dir / f'{item["id"]}.svg',
                glyph,
            )

        write_manifest(
            stage / 'manifest.scad',
            spec,
            glyphs,
            source_sha,
            tolerance,
        )

        public_glyphs = [
            public_glyph_record(glyph)
            for glyph in glyphs
        ]
        group_counts = {
            group: len(grouped_ids(glyphs, group))
            for group in [
                'uppercase',
                'lowercase',
                'digit',
                'punctuation',
            ]
        }
        set_record = {
            **spec,
            'source_sha256': source_sha,
            'glyph_count': len(glyphs),
            'group_counts': group_counts,
            'representative_glyph_count': len([
                glyph
                for glyph in glyphs
                if glyph['representative']
            ]),
            'glyphs': public_glyphs,
        }
        (stage / 'set.json').write_text(
            json.dumps(
                set_record,
                indent=2,
                ensure_ascii=False,
            ) + '\n',
            encoding='utf-8',
            newline='\n',
        )

        write_contact_sheet(
            stage / 'contact_sheet.svg',
            glyphs,
            columns=int(
                spec.get('contact_sheet_columns', 8)
            ),
        )

        sheet_specs = [
            (
                'uppercase',
                grouped_ids(glyphs, 'uppercase'),
                7,
            ),
            (
                'lowercase',
                grouped_ids(glyphs, 'lowercase'),
                7,
            ),
            (
                'digits',
                grouped_ids(glyphs, 'digit'),
                5,
            ),
            (
                'punctuation',
                grouped_ids(glyphs, 'punctuation'),
                4,
            ),
            (
                'representative',
                [
                    glyph['id']
                    for glyph in glyphs
                    if glyph['representative']
                ],
                5,
            ),
        ]
        by_id = {glyph['id']: glyph for glyph in glyphs}
        for name, ids, columns in sheet_specs:
            write_contact_sheet(
                contact_dir / f'{name}.svg',
                [by_id[glyph_id] for glyph_id in ids],
                columns=columns,
            )

        lock_result = verify_lock(
            args.lock,
            stage,
            glyphs,
            source_sha,
            tolerance,
        )

        install_stage(stage, args.out)
        write_checksums(args.out)

    print(json.dumps({
        'set_id': spec['set_id'],
        'source_sha256': source_sha,
        'glyph_count': len(glyphs),
        'group_counts': group_counts,
        'representative_glyph_count': set_record[
            'representative_glyph_count'
        ],
        'contours': sum(
            glyph['contour_count']
            for glyph in glyphs
        ),
        'points': sum(
            glyph['point_count']
            for glyph in glyphs
        ),
        **lock_result,
    }, indent=2))


if __name__ == '__main__':
    main()
