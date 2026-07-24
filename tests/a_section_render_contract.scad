//////////////////////////////////////////////////////////////////////
// LibFile: a_section_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Normalized plan, layout, and section rendering.
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
include <../lib/normalization.scad>
include <../lib/validation.scad>

include <../geometry/glyph_profile.scad>
include <../geometry/section_grid.scad>
include <../geometry/a_hazard_map.scad>
include <../geometry/normalized_glyph.scad>
include <../geometry/normalized_profile_scene.scad>
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

validate_normalization(
    dossier,
    "resize",
    600,
    100,
    OBS_UNKNOWN,
    OBS_UNKNOWN,
    OBS_UNKNOWN,
    OBS_UNKNOWN
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
    0.96,
    0.28,
    0.62,
    0.40,
    0.17
);

translate([-700, 0, 0])
    render_a_section_plan(
        dossier,
        source,
        "resize",
        600,
        100,
        6,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
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
    render_a_section_layout(
        dossier,
        source,
        "resize",
        600,
        100,
        6,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        -300,
        0,
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
        "resize",
        600,
        100,
        6,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        -300,
        0,
        200,
        200,
        1,
        1,
        0.05
    );

echo("PASS", "a_section_render_contract");
