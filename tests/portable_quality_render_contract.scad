    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_quality_render_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Quality plan and review-only layout render.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../lib/portable_section_quality_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy.scad>
include <../lib/portable_section_quality_math.scad>
include <../lib/portable_section_quality_vertices.scad>
include <../lib/portable_section_quality.scad>
include <../geometry/portable_glyph_region.scad>

    include <../geometry/section_grid.scad>
    include <../geometry/portable_section_quality_scene.scad>

    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        "MONTSERRAT_REGULAR_R1"
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        "U_O"
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

    occupancy_records =
        portable_section_occupancy_records(
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

    quality_records =
        portable_section_quality_records(
            occupancy_records,
            glyph,
            target_height,
            columns,
            rows,
            100000,
            1000,
            1000,
            1000,
            2,
            0.000001,
            80,
            80
        );

    assert(
        portable_quality_review_count(quality_records)
            == portable_occupied_section_count(
                occupancy_records
            )
    );

    translate([-180, 0, 0])
        portable_section_quality_plan(
            glyph,
            target_height,
            depth,
            occupancy_records,
            quality_records,
            origin_x,
            0,
            cell_width,
            cell_height,
            columns,
            rows,
            0.8,
            0.5,
            true
        );

    translate([120, 0, 0])
        portable_quality_review_layout(
            occupancy_records,
            quality_records,
            cell_width,
            cell_height,
            10,
            depth
        );

    echo("PASS", "portable_quality_render_contract");
