//////////////////////////////////////////////////////////////////////
// LibFile: portable_registry_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Generated record count, identity, and source checks.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>

validate_portable_glyph_set(PORTABLE_GLYPHS);

assert(len(PORTABLE_GLYPHS) == 20);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "U_A") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "L_g") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "D_8") == 1);
assert(portable_glyph_id_count(PORTABLE_GLYPHS, "P_semicolon") == 1);
assert(PORTABLE_GLYPH_FAMILY == "Liberation Sans");
assert(PORTABLE_GLYPH_STYLE == "Regular");
assert(PORTABLE_GLYPH_FONT_VERSION == "2.1.5");

echo("PASS", "portable_registry_contract");
