//////////////////////////////////////////////////////////////////////
// LibFile: portable_category_sets_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Category arrays are exact, unique, and complete.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_catalog_groups.scad>

assert(len(PORTABLE_UPPERCASE_IDS) == 26);
assert(len(PORTABLE_LOWERCASE_IDS) == 26);
assert(len(PORTABLE_DIGIT_IDS) == 10);
assert(len(PORTABLE_PUNCTUATION_IDS) == 4);
assert(len(PORTABLE_REPRESENTATIVE_IDS) == 20);
assert(len(PORTABLE_ALL_IDS) == 66);

assert(
    portable_sheet_ids("uppercase")
        == PORTABLE_UPPERCASE_IDS
);
assert(
    portable_sheet_ids("lowercase")
        == PORTABLE_LOWERCASE_IDS
);
assert(
    portable_sheet_ids("digits")
        == PORTABLE_DIGIT_IDS
);
assert(
    portable_sheet_ids("punctuation")
        == PORTABLE_PUNCTUATION_IDS
);
assert(
    portable_sheet_ids("representative")
        == PORTABLE_REPRESENTATIVE_IDS
);
assert(
    portable_sheet_ids("all")
        == PORTABLE_ALL_IDS
);

for (glyph_id = PORTABLE_ALL_IDS) {
    assert(
        len([
            for (candidate = PORTABLE_ALL_IDS)
                if (candidate == glyph_id)
                    candidate
        ]) == 1,
        str("Duplicate complete-set ID: ", glyph_id)
    );
    assert(
        portable_glyph_id_count(
            PORTABLE_GLYPHS,
            glyph_id
        ) == 1,
        str("Missing complete-set record: ", glyph_id)
    );
}

echo("PASS", "portable_category_sets_contract");
