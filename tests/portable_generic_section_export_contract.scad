    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_section_export_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Generic cells are clipped and moved to local coordinates.
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

    EXPORT_MATRIX = [
        ["LIBERATION_SANS_REGULAR_R1", "U_A", 0, 0],
        ["MONTSERRAT_REGULAR_R1", "U_Z", 1, 1],
        ["ALPHA_SLAB_ONE_REGULAR_R1", "L_m", 3, 1],
        ["FIRA_SANS_REGULAR_R1", "L_g", 0, 1],
        ["MIAMA_NUEVA_MEDIUM_R1", "L_j", 1, 0],
        ["PLAYFAIR_DISPLAY_REGULAR_R1", "P_semicolon", 0, 1]
    ];

    target_height = 120;
    depth = 3;
    cell_width = 60;
    cell_height = 60;
    spacing = 90;

    for (index = [0 : len(EXPORT_MATRIX) - 1]) {
        entry = EXPORT_MATRIX[index];
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

        assert(entry[2] < columns);
        assert(entry[3] < rows);

        translate([index * spacing, 0, 0])
            portable_generic_section_export(
                glyph,
                target_height,
                depth,
                origin_x,
                0,
                cell_width,
                cell_height,
                entry[2],
                entry[3],
                0.05
            );
    }

    echo("PASS", "portable_generic_section_export_contract");
