//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_isolation_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Duplicate glyph IDs remain isolated by set identity.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>

assert(len(PORTABLE_FONT_SETS) == 6);

for (set_record = PORTABLE_FONT_SETS) {
    glyph = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        set_record[PFS_ID],
        "U_A"
    );
    assert(glyph[PG_ID] == "U_A");
    assert(glyph[PG_SOURCE_SHA256] == set_record[PFS_SOURCE_SHA256]);
    assert(
        len([
            for (candidate = PORTABLE_FONT_SETS)
                if (
                    candidate[PFS_SOURCE_SHA256]
                        == set_record[PFS_SOURCE_SHA256]
                )
                    candidate
        ]) == 1,
        str("Source hash is not isolated: ", set_record[PFS_ID])
    );
}

liberation_a = portable_glyph_by_set_and_id(
    PORTABLE_FONT_SETS,
    "LIBERATION_SANS_REGULAR_R1",
    "U_A"
);
montserrat_a = portable_glyph_by_set_and_id(
    PORTABLE_FONT_SETS,
    "MONTSERRAT_REGULAR_R1",
    "U_A"
);
assert(liberation_a[PG_SOURCE_SHA256] != montserrat_a[PG_SOURCE_SHA256]);
assert(liberation_a[PG_REGION] != montserrat_a[PG_REGION]);

echo("PASS", "portable_font_set_isolation_contract");
