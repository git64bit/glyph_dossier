//////////////////////////////////////////////////////////////////////
// LibFile: catalog_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Registry counts, exact IDs, and dossier validation.
//////////////////////////////////////////////////////////////////////

workbench_name = "laboratory";
project_name_selected = "GLYPH_DOSSIER_LAB";

include <../config/defaults.scad>
include <../lib/schema.scad>
include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../config/glyphs.scad>
include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/validation.scad>

validate_glyph_registry(ALL_GLYPHS);

assert(len(ALL_GLYPHS) == 66);
assert(count_group(ALL_GLYPHS, "uppercase") == 26);
assert(count_group(ALL_GLYPHS, "lowercase") == 26);
assert(count_group(ALL_GLYPHS, "digit") == 10);
assert(count_group(ALL_GLYPHS, "punctuation") == 4);

assert(named_record(ALL_GLYPHS, "U_A")[GD_GLYPH] == "A");
assert(named_record(ALL_GLYPHS, "L_g")[GD_COUNTERS_MAX] == 2);
assert(named_record(ALL_GLYPHS, "D_4")[GD_COUNTERS_MAX] == 1);
assert(named_record(ALL_GLYPHS, "P_colon")[GD_COMPONENTS_MIN] == 2);

echo("PASS", "catalog_contract");
