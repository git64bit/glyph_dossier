//////////////////////////////////////////////////////////////////////
// LibFile: portable_normalization_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Exact scale, bounds, and width from captured U_A data.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../geometry/portable_glyph_region.scad>

glyph = portable_glyph_by_id(
    PORTABLE_GLYPHS,
    "U_A"
);

target_height = 600;
expected_scale = 600 / 1409;
expected_width = 1358 * expected_scale;

assert(
    abs(
        portable_target_scale(
            glyph,
            target_height
        ) - expected_scale
    ) < 0.000001
);
assert(
    abs(
        portable_normalized_width(
            glyph,
            target_height
        ) - expected_width
    ) < 0.000001
);
assert(
    portable_normalized_height(
        glyph,
        target_height
    ) == 600
);
assert(
    portable_normalized_bottom(
        glyph,
        target_height
    ) == 0
);
assert(
    portable_normalized_top(
        glyph,
        target_height
    ) == 600
);
assert(
    abs(
        portable_normalized_left(
            glyph,
            target_height
        ) + expected_width / 2
    ) < 0.000001
);
assert(
    abs(
        portable_normalized_right(
            glyph,
            target_height
        ) - expected_width / 2
    ) < 0.000001
);

echo(
    "PORTABLE_U_A_EXPECTED_WIDTH_MM",
    expected_width
);
echo("PASS", "portable_normalization_contract");
