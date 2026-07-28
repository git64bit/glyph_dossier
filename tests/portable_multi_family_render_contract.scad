//////////////////////////////////////////////////////////////////////
// LibFile: portable_multi_family_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: One captured glyph rendered from every family package.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/portable_glyph_scenes.scad>
include <../geometry/portable_font_family_scenes.scad>

portable_font_family_comparison(
    PORTABLE_FONT_SETS,
    "U_A",
    80,
    3,
    115
);

echo("PASS", "portable_multi_family_render_contract");
