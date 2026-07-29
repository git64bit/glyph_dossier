    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_occupancy_boolean_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Synthetic BOSL2 cell intersections and area status.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy.scad>
include <../geometry/portable_glyph_region.scad>


    subject = [[
        [0, 0],
        [0, 100],
        [100, 100],
        [100, 0]
    ]];

    full_cell = [[
        [0, 0],
        [0, 100],
        [100, 100],
        [100, 0]
    ]];
    half_cell = [[
        [50, 0],
        [50, 100],
        [100, 100],
        [100, 0]
    ]];
    quarter_cell = [[
        [50, 50],
        [50, 100],
        [100, 100],
        [100, 50]
    ]];
    empty_cell = [[
        [101, 0],
        [101, 50],
        [151, 50],
        [151, 0]
    ]];
    boundary_cell = [[
        [100, 0],
        [100, 100],
        [150, 100],
        [150, 0]
    ]];

    full_region = intersection(
        subject,
        full_cell
    );
    half_region = intersection(
        subject,
        half_cell
    );
    quarter_region = intersection(
        subject,
        quarter_cell
    );
    empty_region = intersection(
        subject,
        empty_cell
    );
    boundary_region = intersection(
        subject,
        boundary_cell
    );

    assert(
        abs(
            portable_region_area_or_zero(full_region)
            - 10000
        ) < 0.000001
    );
    assert(
        abs(
            portable_region_area_or_zero(half_region)
            - 5000
        ) < 0.000001
    );
    assert(
        abs(
            portable_region_area_or_zero(quarter_region)
            - 2500
        ) < 0.000001
    );
    assert(
        portable_region_area_or_zero(empty_region)
        == 0
    );
    assert(
        portable_region_component_count_or_zero(
            empty_region
        ) == 0
    );

    assert(
        portable_region_area_or_zero(boundary_region)
        == 0
    );

    echo("PASS", "portable_occupancy_boolean_contract");
