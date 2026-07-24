//////////////////////////////////////////////////////////////////////
// LibFile: normalized_a_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Portable resize and manual normalization geometry.
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
include <../lib/normalization.scad>
include <../lib/validation.scad>

include <../geometry/glyph_profile.scad>
include <../geometry/normalized_glyph.scad>
include <../geometry/normalized_profile_scene.scad>

dossier = named_record(
    ALL_GLYPHS,
    "U_A",
    "normalized A dossier"
);

source = named_record(
    FONT_SOURCES,
    "SRC_1",
    "normalized A source"
);

validate_normalization(
    dossier,
    "resize",
    300,
    100,
    OBS_UNKNOWN,
    OBS_UNKNOWN,
    OBS_UNKNOWN,
    OBS_UNKNOWN
);

validate_normalization(
    dossier,
    "manual",
    300,
    100,
    -35,
    35,
    0,
    70
);

translate([-220, 0, 0])
    render_normalized_profile(
        dossier,
        source,
        "resize",
        300,
        100,
        4,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        OBS_UNKNOWN,
        true,
        1.2,
        170
    );

translate([220, 0, 0])
    render_normalized_profile(
        dossier,
        source,
        "manual",
        300,
        100,
        4,
        -35,
        35,
        0,
        70,
        true,
        1.2,
        170
    );

echo("PASS", "normalized_a_render_contract");
