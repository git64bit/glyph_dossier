//////////////////////////////////////////////////////////////////////
// LibFile: portable_a_section_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Portable U_A normalized plan and exploded layout.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>
include <../lib/portable_section_validation.scad>
include <../geometry/section_grid.scad>
include <../geometry/a_hazard_map.scad>
include <../geometry/portable_glyph_region.scad>
include <../geometry/portable_section_scene.scad>

glyph = portable_glyph_by_id(
    PORTABLE_GLYPHS,
    "U_A"
);

validate_portable_glyph(glyph);

validate_portable_a_section(
    glyph,
    600,
    6,
    -300,
    0,
    200,
    200,
    3,
    3,
    1,
    1,
    0.05,
    20,
    220,
    220,
    0.96,
    0.28,
    0.62,
    0.40,
    0.17
);

assert(
    portable_grid_covers_glyph(
        glyph,
        600,
        -300,
        0,
        200,
        200,
        3,
        3
    )
);

translate([-700, 0, 0])
    portable_a_section_plan(
        glyph,
        600,
        6,
        -300,
        0,
        200,
        200,
        3,
        3,
        true,
        true,
        true,
        1.2,
        5,
        1.5,
        0.96,
        0.28,
        0.62,
        0.40,
        0.17
    );

translate([100, 0, 0])
    portable_a_section_layout(
        glyph,
        600,
        6,
        -300,
        0,
        200,
        200,
        3,
        3,
        0.05,
        20
    );

echo("PASS", "portable_a_section_render_contract");
