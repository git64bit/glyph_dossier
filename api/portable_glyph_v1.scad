//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Font-independent BOSL2 glyph lookup and rendering.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../geometry/portable_glyph_region.scad>

function portable_glyph_record(glyph_id) =
    portable_glyph_by_id(PORTABLE_GLYPHS, glyph_id);

module portable_glyph_by_name(
    glyph_id,
    target_height = 120,
    depth = 6
) {
    glyph = portable_glyph_record(glyph_id);
    portable_glyph_3d(glyph, target_height, depth);
}
