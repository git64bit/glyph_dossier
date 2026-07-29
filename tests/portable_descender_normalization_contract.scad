    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_descender_normalization_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Descenders retain baseline relation after bottom anchoring.
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


    fira_g = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "FIRA_SANS_REGULAR_R1",
        "L_g"
    );
    miama_j = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "MIAMA_NUEVA_MEDIUM_R1",
        "L_j"
    );
    liberation_a = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "LIBERATION_SANS_REGULAR_R1",
        "U_A"
    );

    target_height = 240;

    assert(portable_source_bottom(fira_g) < 0);
    assert(portable_source_bottom(miama_j) < 0);
    assert(portable_source_bottom(liberation_a) == 0);

    assert(
        portable_normalized_baseline_y(
            fira_g,
            target_height
        ) > 0
    );
    assert(
        portable_normalized_baseline_y(
            miama_j,
            target_height
        ) > 0
    );
    assert(
        portable_normalized_baseline_y(
            liberation_a,
            target_height
        ) == 0
    );

    assert(
        abs(
            portable_normalized_baseline_y(
                fira_g,
                target_height
            )
            - (
                213
                * target_height
                / 799
            )
        ) < 0.000001
    );
    assert(
        abs(
            portable_normalized_baseline_y(
                miama_j,
                target_height
            )
            - (
                741
                * target_height
                / 1475
            )
        ) < 0.000001
    );

    echo(
        "FIRA_L_G_NORMALIZED_BASELINE_Y_MM",
        portable_normalized_baseline_y(
            fira_g,
            target_height
        )
    );
    echo(
        "MIAMA_L_J_NORMALIZED_BASELINE_Y_MM",
        portable_normalized_baseline_y(
            miama_j,
            target_height
        )
    );
    echo("PASS", "portable_descender_normalization_contract");
