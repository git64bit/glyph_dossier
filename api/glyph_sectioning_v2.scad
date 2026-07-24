//////////////////////////////////////////////////////////////////////
// LibFile: glyph_sectioning_v2.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Exact-height uppercase-A rectangular section export.
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

include <../lib/lookup.scad>
include <../lib/sectioning.scad>
include <../lib/normalization.scad>

include <../geometry/glyph_profile.scad>
include <../geometry/section_grid.scad>
include <../geometry/normalized_glyph.scad>
include <../geometry/section_scene.scad>

module normalized_uppercase_a_section(
    source_id = "SRC_1",
    method = "resize",
    target_height = 600,
    probe_size = 100,
    depth = 6,
    manual_left = OBS_UNKNOWN,
    manual_right = OBS_UNKNOWN,
    manual_bottom = OBS_UNKNOWN,
    manual_top = OBS_UNKNOWN,
    origin_x = -300,
    origin_y = 0,
    cell_width = 200,
    cell_height = 200,
    column = 0,
    row = 0,
    epsilon = 0.05
) {
    dossier = named_record(
        ALL_GLYPHS,
        "U_A",
        "uppercase-A dossier"
    );

    source = named_record(
        FONT_SOURCES,
        source_id,
        "font source"
    );

    render_a_section_export(
        dossier,
        source,
        method,
        target_height,
        probe_size,
        depth,
        manual_left,
        manual_right,
        manual_bottom,
        manual_top,
        origin_x,
        origin_y,
        cell_width,
        cell_height,
        column,
        row,
        epsilon
    );
}
