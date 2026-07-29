    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_normalization_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Exact normalization for all 396 stored profiles.
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


    target_height = 137;
    tolerance = 0.000001;

    assert(len(PORTABLE_FONT_SETS) == 6);

    for (set_record = PORTABLE_FONT_SETS)
        for (glyph = set_record[PFS_GLYPHS]) {
            normalized_bounds = portable_normalized_bounds(
                glyph,
                target_height
            );

            assert(
                abs(
                    portable_normalized_height(
                        glyph,
                        target_height
                    ) - target_height
                ) < tolerance,
                str(set_record[PFS_ID], " ", glyph[PG_ID])
            );
            assert(
                abs(normalized_bounds[1]) < tolerance,
                str("Bottom mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
            );
            assert(
                abs(
                    normalized_bounds[3]
                    - target_height
                ) < tolerance,
                str("Top mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
            );
            assert(
                abs(
                    normalized_bounds[0]
                    + normalized_bounds[2]
                ) < tolerance,
                str("Center mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
            );
            assert(
                portable_normalized_width(
                    glyph,
                    target_height
                ) > 0,
                str("Width mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
            );
            assert(
                glyph[PG_SOURCE_SHA256]
                    == set_record[PFS_SOURCE_SHA256],
                str("Source mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
            );
        }

    echo("PORTABLE_GENERIC_NORMALIZATION_PROFILE_COUNT", 396);
    echo("PASS", "portable_generic_normalization_contract");
