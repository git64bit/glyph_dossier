//////////////////////////////////////////////////////////////////////
// LibFile: glyph_observation_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Stable source and observation lookup helpers.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../config/defaults.scad>
include <../registries/laboratory_sources.scad>
include <../config/sources.scad>
include <../registries/representative_observations.scad>
include <../config/observations.scad>
include <../lib/lookup.scad>

function font_source_by_id(source_id) =
    named_record(
        FONT_SOURCES,
        source_id,
        "font source"
    );

function observation_by_source_and_glyph(
    source_id,
    glyph_id
) =
    source_glyph_observation(
        GLYPH_OBSERVATIONS,
        source_id,
        glyph_id
    );
