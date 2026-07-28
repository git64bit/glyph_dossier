//////////////////////////////////////////////////////////////////////
// LibFile: portable_catalog_selection_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Exact set-plus-glyph selection across category IDs.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_catalog_groups.scad>

for (set_record = PORTABLE_FONT_SETS) {
    assert(len(set_record[PFS_GLYPHS]) == 66);
    for (glyph_id = PORTABLE_ALL_IDS)
        assert(
            portable_glyph_by_set_and_id(
                PORTABLE_FONT_SETS,
                set_record[PFS_ID],
                glyph_id
            )[PG_ID] == glyph_id
        );
}

assert(len(portable_sheet_ids("uppercase")) == 26);
assert(len(portable_sheet_ids("lowercase")) == 26);
assert(len(portable_sheet_ids("digits")) == 10);
assert(len(portable_sheet_ids("punctuation")) == 4);

echo("PASS", "portable_catalog_selection_contract");
