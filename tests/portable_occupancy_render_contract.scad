    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_occupancy_render_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Occupancy plan, occupied layout, and local export.
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

    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        "PLAYFAIR_DISPLAY_REGULAR_R1"
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        "P_semicolon"
    );

    target_height = 120;
    depth = 3;
    cell_width = 60;
    cell_height = 60;
    columns = portable_auto_section_columns(
        glyph,
        target_height,
        cell_width
    );
    rows = portable_auto_section_rows(
        target_height,
        cell_height
    );
    origin_x =
        -section_plan_width(
            cell_width,
            columns
        ) / 2;
    records = portable_section_occupancy_records(
        set_record[PFS_ID],
        glyph,
        target_height,
        origin_x,
        0,
        cell_width,
        cell_height,
        columns,
        rows,
        0.000001,
        0.000000001
    );
    first_occupied =
        portable_occupied_record_by_ordinal(
            records,
            0
        );

    translate([-180, 0, 0])
        portable_section_occupancy_plan(
            glyph,
            target_height,
            depth,
            records,
            origin_x,
            0,
            cell_width,
            cell_height,
            columns,
            rows,
            0.8,
            0.4,
            true
        );

    translate([0, 0, 0])
        portable_occupied_section_layout(
            records,
            cell_width,
            cell_height,
            10,
            depth
        );

    translate([240, 0, 0])
        portable_occupancy_record_export(
            first_occupied,
            depth
        );

    echo("PASS", "portable_occupancy_render_contract");
