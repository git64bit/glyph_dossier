//////////////////////////////////////////////////////////////////////
// LibFile: portable_representative_metadata_lock.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Original 20 records retain accepted metadata.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../glyph_sets/liberation_sans_regular/representative_lock.scad>
include <../lib/portable_glyph_lookup.scad>

assert(len(PORTABLE_REPRESENTATIVE_LOCK) == 20);
assert(len(PORTABLE_REPRESENTATIVE_IDS) == 20);

for (lock = PORTABLE_REPRESENTATIVE_LOCK) {
    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        lock[PRL_ID]
    );

    assert(glyph[PG_CHARACTER] == lock[PRL_CHARACTER]);
    assert(glyph[PG_EXACT_BOUNDS] == lock[PRL_EXACT_BOUNDS]);
    assert(glyph[PG_REGION_BOUNDS] == lock[PRL_REGION_BOUNDS]);
    assert(glyph[PG_CONTOUR_COUNT] == lock[PRL_CONTOURS]);
    assert(glyph[PG_COMPONENT_COUNT] == lock[PRL_COMPONENTS]);
    assert(glyph[PG_COUNTER_COUNT] == lock[PRL_COUNTERS]);
    assert(glyph[PG_POINT_COUNT] == lock[PRL_POINTS]);
}

echo("PASS", "portable_representative_metadata_lock");
