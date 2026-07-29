//////////////////////////////////////////////////////////////////////
// LibFile: portable_multi_family_sectioning_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Generic exact-height section export by set and glyph ID.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/section_grid.scad>
include <../geometry/portable_generic_section_scene.scad>

module portable_section_by_id(
    set_id = "LIBERATION_SANS_REGULAR_R1",
    glyph_id = "U_A",
    target_height = 600,
    depth = 6,
    grid_mode = "auto",
    cell_width = 200,
    cell_height = 200,
    manual_origin_x = -300,
    manual_origin_y = 0,
    manual_columns = 3,
    manual_rows = 3,
    column = 0,
    row = 0,
    epsilon = 0.05
) {
    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        set_id
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        glyph_id
    );

    columns = portable_resolved_section_columns(
        glyph,
        target_height,
        cell_width,
        manual_columns,
        grid_mode
    );
    rows = portable_resolved_section_rows(
        target_height,
        cell_height,
        manual_rows,
        grid_mode
    );
    origin_x = portable_resolved_section_origin_x(
        glyph,
        target_height,
        cell_width,
        manual_origin_x,
        manual_columns,
        grid_mode
    );
    origin_y = portable_resolved_section_origin_y(
        manual_origin_y,
        grid_mode
    );

    assert(
        column >= 0 && column < columns,
        "Requested API section column is outside the grid."
    );
    assert(
        row >= 0 && row < rows,
        "Requested API section row is outside the grid."
    );

    portable_generic_section_export(
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
