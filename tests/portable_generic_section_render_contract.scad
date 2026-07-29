    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_section_render_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Representative generic plans and layouts across sets.
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
    include <../geometry/portable_normalized_profile_scene.scad>
    include <../geometry/portable_generic_section_scene.scad>

    RENDER_MATRIX = [
        ["LIBERATION_SANS_REGULAR_R1", "U_A"],
        ["MONTSERRAT_REGULAR_R1", "U_Z"],
        ["ALPHA_SLAB_ONE_REGULAR_R1", "L_m"],
        ["FIRA_SANS_REGULAR_R1", "L_g"],
        ["MIAMA_NUEVA_MEDIUM_R1", "L_j"],
        ["PLAYFAIR_DISPLAY_REGULAR_R1", "P_semicolon"]
    ];

    target_height = 120;
    depth = 3;
    cell_width = 60;
    cell_height = 60;
    spacing = 280;

    for (index = [0 : len(RENDER_MATRIX) - 1]) {
        entry = RENDER_MATRIX[index];
        glyph = portable_glyph_by_set_and_id(
            PORTABLE_FONT_SETS,
            entry[0],
            entry[1]
        );
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

        translate([
            (
                index
                - (len(RENDER_MATRIX) - 1) / 2
            ) * spacing,
            0,
            0
        ])
            portable_generic_section_plan(
                glyph,
                target_height,
                depth,
                origin_x,
                0,
                cell_width,
                cell_height,
                columns,
                rows,
                true,
                true,
                0.8,
                0.8
            );
    }

    echo("PASS", "portable_generic_section_render_contract");
