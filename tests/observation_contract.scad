//////////////////////////////////////////////////////////////////////
// LibFile: observation_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Pending ledger and complete observed-candidate checks.
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
include <../registries/representative_observations.scad>
include <../config/observations.scad>

include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/validation.scad>

validate_font_source_registry(FONT_SOURCES);
validate_observation_registry(
    GLYPH_OBSERVATIONS,
    FONT_SOURCES,
    ALL_GLYPHS
);

assert(len(GLYPH_OBSERVATIONS) == 20);
assert(
    exact_observation_count(
        GLYPH_OBSERVATIONS,
        "SRC_1",
        "U_A"
    ) == 1
);
assert(
    source_glyph_observation(
        GLYPH_OBSERVATIONS,
        "SRC_1",
        "L_g"
    )[OB_STATUS] == "pending"
);

candidate = glyph_observation(
    "OBS_TEST_SRC_1_U_A",
    "SRC_1",
    "U_A",
    "observed",
    "font_specific_form",
    1,
    1,
    -44.0,
    45.0,
    0.0,
    87.0,
    8.4,
    11.2,
    "Manual contract-test values."
);

validate_glyph_observation(candidate);
assert(observation_width(candidate) == 89.0);
assert(observation_height(candidate) == 87.0);

echo("PASS", "observation_contract");
