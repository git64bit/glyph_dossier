//////////////////////////////////////////////////////////////////////
// LibFile: a_section_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Direct plan, layout, and selected-section rendering.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../config/defaults.scad>

include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../config/glyphs.scad>

include <../registries/laboratory_sources.scad>
include <../config/sources.scad>

include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/sectioning.scad>
include <../lib/validation.scad>

include <../geometry/glyph_profile.scad>
include <../geometry/section_grid.scad>
include <../geometry/a_hazard_map.scad>
include <../geometry/section_scene.scad>

dossier = named_record(
    ALL_GLYPHS,
    "U_A",
    "A section render dossier"
);

source = named_record(
    FONT_SOURCES,
    "SRC_1",
    "A section render source"
);

validate_a_section_plan(
    dossier,
    200,
    200,
    3,
    3,
    1,
    1,
    0.05,
    220,
    220,
    0.72,
    0.22,
    0.55,
    0.34,
    0.17
);

translate([-700, 0, 0])
    render_a_section_plan(
        dossier,
        source,
        600,
        6,
        -300,
        -20,
        200,
        200,
        3,
        3,
        true,
        true,
        1.2,
        5,
        0.72,
        0.22,
        0.55,
        0.34,
        0.17
    );

translate([100, 0, 0])
    render_a_section_layout(
        dossier,
        source,
        600,
        6,
        -300,
        -20,
        200,
        200,
        3,
        3,
        0.05,
        20
    );

translate([850, 0, 0])
    render_a_section_export(
        dossier,
        source,
        600,
        6,
        -300,
        -20,
        200,
        200,
        1,
        1,
        0.05
    );

echo("PASS", "a_section_render_contract");
