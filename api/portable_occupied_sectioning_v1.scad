//////////////////////////////////////////////////////////////////////
// LibFile: portable_occupied_sectioning_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Exports one occupied cell by row-major ordinal.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/section_grid.scad>
include <../geometry/portable_section_occupancy_scene.scad>

module portable_occupied_section_by_ordinal(
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
    occupied_ordinal = 0,
    area_epsilon = 0.000001,
    boolean_epsilon = 0.000000001
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
    records = portable_section_occupancy_records(
        set_id,
        glyph,
        target_height,
        origin_x,
        origin_y,
        cell_width,
        cell_height,
        columns,
        rows,
        area_epsilon,
        boolean_epsilon
    );
    record = portable_occupied_record_by_ordinal(
        records,
        occupied_ordinal
    );

    portable_occupancy_record_export(
        record,
        depth
    );
}
