//////////////////////////////////////////////////////////////////////
// LibFile: representative_set.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Representative-set coverage and uniqueness.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../registries/study_sets.scad>
include <../config/glyphs.scad>
include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/validation.scad>

validate_id_set(
    REPRESENTATIVE_SET_IDS,
    ALL_GLYPHS,
    "representative study set"
);

assert(len(REPRESENTATIVE_SET_IDS) == 20);
assert(exact_name_count(ALL_GLYPHS, "U_A") == 1);
assert(exact_name_count(ALL_GLYPHS, "L_g") == 1);
assert(exact_name_count(ALL_GLYPHS, "D_8") == 1);
assert(exact_name_count(ALL_GLYPHS, "P_semicolon") == 1);

for (id = REPRESENTATIVE_SET_IDS)
    assert(
        named_record(ALL_GLYPHS, id)[GD_PRIORITY] == "primary",
        str("Representative dossier is not primary: ", id)
    );

echo("PASS", "representative_set");
echo("REPRESENTATIVE_SET_IDS", REPRESENTATIVE_SET_IDS);
