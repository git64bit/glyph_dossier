//////////////////////////////////////////////////////////////////////
// LibFile: render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Direct font-adapter rendering of difficult glyphs.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../config/glyphs.scad>
include <../lib/lookup.scad>
include <../geometry/glyph_profile.scad>

test_ids = [
    "U_A",
    "L_g",
    "D_8",
    "P_question"
];

for (index = [0 : len(test_ids) - 1]) {
    dossier = named_record(
        ALL_GLYPHS,
        test_ids[index],
        "render-test dossier"
    );

    translate([index * 70, 0, 0])
        glyph_profile_3d(
            dossier,
            "font",
            "",
            50,
            3
        );
}

echo("PASS", "render_contract");
