//////////////////////////////////////////////////////////////////////
// LibFile: portable_registry_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Complete generated set identity and source checks.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>

validate_portable_glyph_set(PORTABLE_GLYPHS);

assert(len(PORTABLE_GLYPHS) == 66);
assert(len(PORTABLE_UPPERCASE_IDS) == 26);
assert(len(PORTABLE_LOWERCASE_IDS) == 26);
assert(len(PORTABLE_DIGIT_IDS) == 10);
assert(len(PORTABLE_PUNCTUATION_IDS) == 4);
assert(len(PORTABLE_REPRESENTATIVE_IDS) == 20);
assert(len(PORTABLE_ALL_IDS) == 66);

assert(portable_glyph_id_count(PORTABLE_GLYPHS, "U_A") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "U_Q") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "L_x") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "D_9") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "P_semicolon") == 1);

assert(PORTABLE_GLYPH_FAMILY == "Liberation Sans");
assert(PORTABLE_GLYPH_STYLE == "Regular");
assert(PORTABLE_GLYPH_FONT_VERSION == "2.1.5");

echo("PASS", "portable_registry_contract");
