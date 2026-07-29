    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_multi_family_normalization_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Representative matrix across all six font sets.
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


    target_height = 200;
    tolerance = 0.000001;

    REPRESENTATIVE_MATRIX = [
        ["LIBERATION_SANS_REGULAR_R1", "U_A"],
        ["MONTSERRAT_REGULAR_R1", "U_Z"],
        ["ALPHA_SLAB_ONE_REGULAR_R1", "U_B"],
        ["FIRA_SANS_REGULAR_R1", "L_g"],
        ["MIAMA_NUEVA_MEDIUM_R1", "L_j"],
        ["PLAYFAIR_DISPLAY_REGULAR_R1", "P_semicolon"]
    ];

    for (entry = REPRESENTATIVE_MATRIX) {
        glyph = portable_glyph_by_set_and_id(
            PORTABLE_FONT_SETS,
            entry[0],
            entry[1]
        );
        expected_scale =
            target_height
            / portable_glyph_height(glyph);
        expected_width =
            portable_glyph_width(glyph)
            * expected_scale;

        assert(
            abs(
                portable_target_scale(
                    glyph,
                    target_height
                ) - expected_scale
            ) < tolerance
        );
        assert(
            abs(
                portable_normalized_width(
                    glyph,
                    target_height
                ) - expected_width
            ) < tolerance
        );
        echo("PORTABLE_NORMALIZATION_MATRIX_ENTRY", [
            entry[0],
            entry[1],
            expected_scale,
            expected_width,
            portable_normalized_baseline_y(
                glyph,
                target_height
            )
        ]);
    }

    for (set_record = PORTABLE_FONT_SETS) {
        zero = portable_glyph_by_id(
            set_record[PFS_GLYPHS],
            "D_0"
        );

        assert(
            abs(
                portable_normalized_height(
                    zero,
                    target_height
                ) - target_height
            ) < tolerance
        );
        assert(
            portable_normalized_width(
                zero,
                target_height
            ) > 0
        );
        echo("PORTABLE_D_0_NORMALIZATION_ENTRY", [
            set_record[PFS_ID],
            portable_normalized_width(
                zero,
                target_height
            ),
            portable_normalized_baseline_y(
                zero,
                target_height
            )
        ]);
    }

    echo("PASS", "portable_multi_family_normalization_contract");
