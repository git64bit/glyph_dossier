//////////////////////////////////////////////////////////////////////
// LibFile: portable_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Direct BOSL2 rendering of four captured glyph classes.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/portable_glyph_lookup.scad>
include <../geometry/portable_glyph_region.scad>

render_ids = ["U_A", "L_g", "D_8", "P_question"];

for (index = [0 : len(render_ids) - 1]) {
    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        render_ids[index]
    );

    translate([index * 110, 0, 0])
        portable_glyph_3d(glyph, 80, 3);
}

echo("PASS", "portable_render_contract");
