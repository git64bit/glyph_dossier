    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_quality_math_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Bounds, thickness estimate, and boundary intervals.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../lib/portable_section_quality_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy.scad>
include <../lib/portable_section_quality_math.scad>
include <../lib/portable_section_quality_vertices.scad>
include <../lib/portable_section_quality.scad>
include <../geometry/portable_glyph_region.scad>


    square = [[
        [0, 0],
        [0, 10],
        [10, 10],
        [10, 0]
    ]];
    two_bars = [
        [
            [0, 0],
            [0, 10],
            [20, 10],
            [20, 0]
        ],
        [
            [0, 20],
            [0, 30],
            [20, 30],
            [20, 20]
        ]
    ];

    assert(
        portable_region_bounds_or_undef(square)
            == [0, 0, 10, 10]
    );
    assert(
        portable_bounds_size_or_zero(
            portable_region_bounds_or_undef(square)
        ) == [10, 10]
    );
    assert(
        portable_region_vertical_boundary_length(
            square,
            0,
            0.000001
        ) == 10
    );
    assert(
        portable_region_vertical_boundary_segments(
            square,
            0,
            0.000001
        ) == 1
    );
    assert(
        portable_region_vertical_boundary_length(
            two_bars,
            0,
            0.000001
        ) == 20
    );
    assert(
        portable_region_vertical_boundary_segments(
            two_bars,
            0,
            0.000001
        ) == 2
    );
    assert(
        portable_positive_min_or_undef(
            [0, 15, 8, 0],
            0.000001
        ) == 8
    );
    assert(
        is_undef(
            portable_positive_min_or_undef(
                [0, 0, 0, 0],
                0.000001
            )
        )
    );

    echo("PASS", "portable_quality_math_contract");
