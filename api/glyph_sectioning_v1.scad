//////////////////////////////////////////////////////////////////////
// LibFile: glyph_sectioning_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Batch 003 uppercase-A rectangular section export.
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
include <../geometry/glyph_profile.scad>
include <../geometry/section_grid.scad>
include <../geometry/section_scene.scad>

module uppercase_a_section_by_index(
    source_id = "SRC_1",
    nominal_size = 600,
    depth = 6,
    origin_x = -300,
    origin_y = -20,
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
        nominal_size,
        depth,
        origin_x,
        origin_y,
        cell_width,
        cell_height,
        column,
        row,
        epsilon
    );
}
