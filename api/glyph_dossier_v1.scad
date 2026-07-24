//////////////////////////////////////////////////////////////////////
// LibFile: glyph_dossier_v1.scad
// Project: Glyph Dossier
// FileGroup: Public API
// FileSummary: Stable profile and dossier access by exact glyph ID.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../registries/uppercase.scad>
include <../registries/lowercase.scad>
include <../registries/digits.scad>
include <../registries/punctuation.scad>
include <../config/glyphs.scad>
include <../lib/lookup.scad>
include <../geometry/glyph_profile.scad>

function glyph_dossier_by_id(glyph_id) =
    named_record(
        ALL_GLYPHS,
        glyph_id,
        "glyph dossier"
    );

module glyph_profile_by_id(
    glyph_id,
    font_name = "",
    nominal_size = 120,
    depth = 6
) {
    dossier = glyph_dossier_by_id(glyph_id);

    glyph_profile_3d(
        dossier,
        "font",
        font_name,
        nominal_size,
        depth
    );
}
