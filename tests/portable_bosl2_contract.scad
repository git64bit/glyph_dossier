//////////////////////////////////////////////////////////////////////
// LibFile: portable_bosl2_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: BOSL2 validity, components, counters, and area.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>

for (glyph = PORTABLE_GLYPHS) {
    validate_portable_glyph(glyph);
    assert(is_valid_region(glyph[PG_REGION]));
    assert(abs(region_area(glyph[PG_REGION])) > 0);
    assert(
        len(region_parts(glyph[PG_REGION]))
            == glyph[PG_COMPONENT_COUNT]
    );
}

assert(portable_glyph_by_id(PORTABLE_GLYPHS, "U_A")[PG_COUNTER_COUNT] == 1);
assert(portable_glyph_by_id(PORTABLE_GLYPHS, "U_B")[PG_COUNTER_COUNT] == 2);
assert(portable_glyph_by_id(PORTABLE_GLYPHS, "L_i")[PG_COMPONENT_COUNT] == 2);
assert(portable_glyph_by_id(PORTABLE_GLYPHS, "D_8")[PG_COUNTER_COUNT] == 2);
assert(portable_glyph_by_id(PORTABLE_GLYPHS, "P_colon")[PG_COMPONENT_COUNT] == 2);

echo("PASS", "portable_bosl2_contract");
