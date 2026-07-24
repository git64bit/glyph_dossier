//////////////////////////////////////////////////////////////////////
// LibFile: portable_full_coverage_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: One portable record for every generic dossier.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/schema.scad>
include <../lib/portable_glyph_schema.scad>

include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../config/glyphs.scad>

include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>

assert(len(ALL_GLYPHS) == 66);
assert(len(PORTABLE_GLYPHS) == 66);

for (dossier = ALL_GLYPHS) {
    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        dossier[GD_ID]
    );

    assert(
        glyph[PG_CHARACTER] == dossier[GD_GLYPH],
        str(
            "Character mismatch for ",
            dossier[GD_ID]
        )
    );
    assert(
        glyph[PG_CODEPOINT]
            == ord(dossier[GD_GLYPH]),
        str(
            "Codepoint mismatch for ",
            dossier[GD_ID]
        )
    );
}

for (glyph = PORTABLE_GLYPHS)
    assert(
        len([
            for (dossier = ALL_GLYPHS)
                if (dossier[GD_ID] == glyph[PG_ID])
                    dossier
        ]) == 1,
        str(
            "Portable glyph lacks one dossier: ",
            glyph[PG_ID]
        )
    );

echo("PASS", "portable_full_coverage_contract");
