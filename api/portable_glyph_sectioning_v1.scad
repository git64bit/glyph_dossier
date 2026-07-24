//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_sectioning_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Captured U_A exact-height rectangular section export.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../geometry/section_grid.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/portable_section_scene.scad>

module portable_uppercase_a_section(
    target_height = 600,
    depth = 6,
    origin_x = -300,
    origin_y = 0,
    cell_width = 200,
    cell_height = 200,
    column = 0,
    row = 0,
    epsilon = 0.05
) {
    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        "U_A"
    );

    portable_a_section_export(
        glyph,
        target_height,
        depth,
        origin_x,
        origin_y,
        cell_width,
        cell_height,
        column,
        row,
        epsilon
    );
}
