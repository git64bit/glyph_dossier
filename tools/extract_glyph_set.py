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


def extract_glyph(font, glyph_set, cmap, glyph_id, character, tolerance, source_sha):
    codepoint = ord(character)
    if codepoint not in cmap:
        raise ValueError(f'Font has no glyph for U+{codepoint:04X} {character!r}')
    glyph_name = cmap[codepoint]
    glyph = glyph_set[glyph_name]

    flatten_pen = FlattenPen(glyph_set, tolerance)
    glyph.draw(flatten_pen)
    flatten_pen._endPath()
    paths, components, counters = normalize_winding(flatten_pen.paths)

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
        '[' + ', '.join(number(value) for value in glyph['exact_bounds']) + ']',
        '[' + ', '.join(number(value) for value in glyph['region_bounds']) + ']',
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
            lines.append('    ' + value.replace('\n', '\n    ') + suffix)
        else:
            lines.append('    ' + value + suffix)
    lines.extend(['];', ''])
    output.write_text('\n'.join(lines), encoding='utf-8', newline='\n')


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
    output.write_text(svg, encoding='utf-8', newline='\n')


def write_contact_sheet(output, glyphs, columns=5, cell=420, glyph_height=260):
    rows = math.ceil(len(glyphs) / columns)
    fragments = [
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {columns*cell} {rows*cell}">',
        '  <rect width="100%" height="100%" fill="white"/>',
    ]
    for index, glyph in enumerate(glyphs):
        col = index % columns
        row = index // columns
        x0, y0, x1, y1 = glyph['exact_bounds']
        width = max(1, x1-x0)
        height = max(1, y1-y0)
        scale = glyph_height / height
        center_x = (x0+x1)/2
        bottom = y0
        tx = col*cell + cell/2 - center_x*scale
        ty = row*cell + (cell+glyph_height)/2 + bottom*scale
        fragments.append(f'  <rect x="{col*cell}" y="{row*cell}" width="{cell}" height="{cell}" fill="none" stroke="#bbb"/>')
        fragments.append(f'  <path d="{glyph["svg_path"]}" transform="translate({number(tx)} {number(ty)}) scale({number(scale)} {number(-scale)})" fill="black"/>')
    fragments.append('</svg>')
    output.write_text('\n'.join(fragments)+'\n', encoding='utf-8', newline='\n')


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_checksums(set_dir):
    checksum_path = set_dir / 'checksums.sha256'
    files = sorted(
        path for path in set_dir.rglob('*')
        if path.is_file() and path != checksum_path
    )
    lines = [f'{sha256(path)}  {path.relative_to(set_dir).as_posix()}' for path in files]
    checksum_path.write_text('\n'.join(lines)+'\n', encoding='utf-8', newline='\n')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--font', required=True, type=Path)
    parser.add_argument('--spec', required=True, type=Path)
    parser.add_argument('--out', required=True, type=Path)
    args = parser.parse_args()

    spec = json.loads(args.spec.read_text(encoding='utf-8'))
    font = TTFont(args.font)
    glyph_set = font.getGlyphSet()
    cmap = font.getBestCmap()
    source_sha = sha256(args.font)
    tolerance = float(spec['flatten_tolerance_font_units'])

    svg_dir = args.out / 'generated/svg'
    scad_dir = args.out / 'generated/scad'
    svg_dir.mkdir(parents=True, exist_ok=True)
    scad_dir.mkdir(parents=True, exist_ok=True)

    glyphs = []
    for item in spec['glyphs']:
        glyph = extract_glyph(
            font, glyph_set, cmap,
            item['id'], item['character'], tolerance, source_sha,
        )
        glyphs.append(glyph)
        write_glyph_scad(scad_dir / f'{item["id"]}.scad', glyph)
        write_svg(svg_dir / f'{item["id"]}.svg', glyph)

    manifest_lines = [
        '//////////////////////////////////////////////////////////////////////',
        '// LibFile: manifest.scad',
        '// Project: Glyph Dossier',
        '// FileGroup: Generated Portable Glyph Set',
        '// FileSummary: Liberation Sans Regular representative set.',
        '//////////////////////////////////////////////////////////////////////',
        '',
    ]
    for glyph in glyphs:
        manifest_lines.append(f'include <generated/scad/{glyph["id"]}.scad>')
    manifest_lines.extend([
        '',
        f'PORTABLE_GLYPH_SET_ID = {scad_string(spec["set_id"])};',
        f'PORTABLE_GLYPH_FAMILY = {scad_string(spec["family"])};',
        f'PORTABLE_GLYPH_STYLE = {scad_string(spec["style"])};',
        f'PORTABLE_GLYPH_FONT_VERSION = {scad_string(spec["font_version"])};',
        f'PORTABLE_GLYPH_LICENSE = {scad_string(spec["license"])};',
        f'PORTABLE_GLYPH_SOURCE_URL = {scad_string(spec["source_url"])};',
        f'PORTABLE_GLYPH_SOURCE_SHA256 = {scad_string(source_sha)};',
        f'PORTABLE_GLYPH_FLATTEN_TOLERANCE = {number(tolerance)};',
        '',
        'PORTABLE_GLYPHS = [',
    ])
    for index, glyph in enumerate(glyphs):
        suffix = ',' if index < len(glyphs)-1 else ''
        manifest_lines.append(f'    {glyph_constant(glyph["id"])}{suffix}')
    manifest_lines.extend(['];', ''])
    (args.out / 'manifest.scad').write_text('\n'.join(manifest_lines), encoding='utf-8', newline='\n')

    public_glyphs = [{key:value for key,value in glyph.items() if key not in {'region','svg_path'}} for glyph in glyphs]
    set_record = {**spec, 'source_sha256': source_sha, 'glyph_count': len(glyphs), 'glyphs': public_glyphs}
    (args.out / 'set.json').write_text(json.dumps(set_record, indent=2, ensure_ascii=False)+'\n', encoding='utf-8', newline='\n')
    write_contact_sheet(args.out / 'contact_sheet.svg', glyphs)
    write_checksums(args.out)

    print(json.dumps({
        'set_id': spec['set_id'],
        'source_sha256': source_sha,
        'glyph_count': len(glyphs),
        'contours': sum(g['contour_count'] for g in glyphs),
        'points': sum(g['point_count'] for g in glyphs),
    }, indent=2))


if __name__ == '__main__':
    main()
