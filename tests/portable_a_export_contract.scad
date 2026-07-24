//////////////////////////////////////////////////////////////////////
// LibFile: portable_a_export_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Portable U_A cells translated to local coordinates.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../geometry/section_grid.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/portable_section_scene.scad>

glyph = portable_glyph_by_id(
    PORTABLE_GLYPHS,
    "U_A"
);

assert(section_id(0, 0) == "C1_R1");
assert(section_id(1, 1) == "C2_R2");
assert(section_id(2, 2) == "C3_R3");

translate([0, 0, 0])
    portable_a_section_export(
        glyph,
        600,
        6,
        -300,
        0,
        200,
        200,
        0,
        0,
        0.05
    );

translate([240, 0, 0])
    portable_a_section_export(
        glyph,
        600,
        6,
        -300,
        0,
        200,
        200,
        1,
        1,
        0.05
    );

translate([480, 0, 0])
    portable_a_section_export(
        glyph,
        600,
        6,
        -300,
        0,
        200,
        200,
        2,
        2,
        0.05
    );

echo("PASS", "portable_a_export_contract");
