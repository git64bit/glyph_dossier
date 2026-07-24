//////////////////////////////////////////////////////////////////////
// LibFile: source_render_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Default-source sample and three-source comparison.
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
include <../geometry/glyph_profile.scad>
include <../geometry/source_sample.scad>
include <../geometry/source_comparison.scad>

dossier = named_record(
    ALL_GLYPHS,
    "U_A",
    "source-render dossier"
);
source = named_record(
    FONT_SOURCES,
    "SRC_1",
    "source-render source"
);

translate([-170, 100, 0])
    render_source_sample(
        source,
        24,
        1.5,
        1.35
    );

translate([0, -80, 0])
    render_source_comparison(
        dossier,
        FONT_SOURCES,
        ["SRC_1", "SRC_2", "SRC_3"],
        50,
        2,
        75
    );

echo("PASS", "source_render_contract");
