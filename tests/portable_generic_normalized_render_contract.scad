    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_normalized_render_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Renders representative normalized profiles from all sets.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_glyph_validation.scad>
include <../lib/portable_font_set_validation.scad>
include <../lib/portable_normalization_validation.scad>
include <../geometry/portable_glyph_region.scad>

    include <../geometry/portable_normalized_profile_scene.scad>

    RENDER_MATRIX = [
        ["LIBERATION_SANS_REGULAR_R1", "U_A"],
        ["MONTSERRAT_REGULAR_R1", "U_Z"],
        ["ALPHA_SLAB_ONE_REGULAR_R1", "U_B"],
        ["FIRA_SANS_REGULAR_R1", "L_g"],
        ["MIAMA_NUEVA_MEDIUM_R1", "L_j"],
        ["PLAYFAIR_DISPLAY_REGULAR_R1", "P_semicolon"]
    ];

    target_height = 100;
    depth = 3;
    spacing = 170;

    for (index = [0 : len(RENDER_MATRIX) - 1]) {
        entry = RENDER_MATRIX[index];
        set_record = portable_font_set_by_id(
            PORTABLE_FONT_SETS,
            entry[0]
        );
        glyph = portable_glyph_by_id(
            set_record[PFS_GLYPHS],
            entry[1]
        );

        validate_portable_normalization_profile(
            set_record,
            glyph,
            target_height,
            depth,
            1
        );

        translate([
            (
                index
                - (len(RENDER_MATRIX) - 1) / 2
            ) * spacing,
            0,
            0
        ])
            portable_generic_normalized_profile(
                glyph,
                target_height,
                depth,
                true,
                1
            );
    }

    echo("PASS", "portable_generic_normalized_render_contract");
