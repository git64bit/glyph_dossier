//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_registry_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Six exact family identities with 66 glyphs each.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_font_set_validation.scad>

assert(len(PORTABLE_FONT_SETS) == 6);
assert(len(PORTABLE_FONT_SET_IDS) == 6);
validate_portable_font_registry(PORTABLE_FONT_SETS);

for (set_record = PORTABLE_FONT_SETS) {
    assert(
        portable_font_set_id_count(
            PORTABLE_FONT_SETS,
            set_record[PFS_ID]
        ) == 1
    );
    assert(len(set_record[PFS_GLYPHS]) == 66);
}

echo("PASS", "portable_font_set_registry_contract");
