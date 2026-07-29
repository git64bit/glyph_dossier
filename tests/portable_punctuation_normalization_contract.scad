    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_punctuation_normalization_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Punctuation uses visible bounds and preserves baseline data.
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


    playfair_semicolon = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "PLAYFAIR_DISPLAY_REGULAR_R1",
        "P_semicolon"
    );
    alpha_question = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "ALPHA_SLAB_ONE_REGULAR_R1",
        "P_question"
    );

    target_height = 180;

    assert(playfair_semicolon[PG_COMPONENT_COUNT] == 2);
    assert(playfair_semicolon[PG_COUNTER_COUNT] == 0);
    assert(portable_source_bottom(playfair_semicolon) == -283);
    assert(
        portable_normalized_bottom(
            playfair_semicolon,
            target_height
        ) == 0
    );
    assert(
        abs(
            portable_normalized_top(
                playfair_semicolon,
                target_height
            ) - target_height
        ) < 0.000001
    );
    assert(
        portable_normalized_baseline_y(
            playfair_semicolon,
            target_height
        ) > 0
    );

    assert(portable_source_bottom(alpha_question) > 0);
    assert(
        portable_normalized_baseline_y(
            alpha_question,
            target_height
        ) < 0
    );
    assert(
        portable_normalized_bottom(
            alpha_question,
            target_height
        ) == 0
    );

    echo(
        "PLAYFAIR_SEMICOLON_NORMALIZED_BASELINE_Y_MM",
        portable_normalized_baseline_y(
            playfair_semicolon,
            target_height
        )
    );
    echo(
        "ALPHA_QUESTION_NORMALIZED_BASELINE_Y_MM",
        portable_normalized_baseline_y(
            alpha_question,
            target_height
        )
    );
    echo("PASS", "portable_punctuation_normalization_contract");
