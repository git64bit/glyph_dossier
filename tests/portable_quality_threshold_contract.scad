    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_quality_threshold_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Synthetic bars trigger deterministic review flags.
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


    SYNTHETIC_BAR = [
        "SYN_BAR",
        "x",
        120,
        "synthetic_bar",
        100,
        100,
        [0, 0, 100, 10],
        [0, 0, 100, 10],
        1,
        1,
        0,
        4,
        0,
        "synthetic",
        [[
            [0, 0],
            [0, 10],
            [100, 10],
            [100, 0]
        ]]
    ];

    target_height = 10;
    origin_x = -50;
    origin_y = 0;
    cell_width = 50;
    cell_height = 20;
    columns = 2;
    rows = 1;

    occupancy_records =
        portable_section_occupancy_records(
            "SYNTHETIC_SET",
            SYNTHETIC_BAR,
            target_height,
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            columns,
            rows,
            0.000001,
            0.000000001
        );

    quality_records =
        portable_section_quality_records(
            occupancy_records,
            SYNTHETIC_BAR,
            target_height,
            columns,
            rows,
            600,
            12,
            1,
            15,
            2,
            0.000001,
            60,
            25
        );

    left = quality_records[0];
    right = quality_records[1];

    assert(left[PSQ_REVIEW]);
    assert(right[PSQ_REVIEW]);
    assert(left[PSQ_SMALL_COMPONENT]);
    assert(left[PSQ_THIN_COMPONENT]);
    assert(left[PSQ_SHORT_SEAM]);
    assert(!left[PSQ_MULTIPLE_COMPONENTS]);
    assert(!left[PSQ_COUNTER_CUT_CANDIDATE]);
    assert(!left[PSQ_VERTEX_NEAR_CUT]);
    assert(left[PSQ_BED_FIT]);
    assert(
        abs(left[PSQ_SHORTEST_SEAM_LENGTH] - 10)
            < 0.000001
    );
    assert(
        abs(
            left[PSQ_SEAM_LENGTHS][PSQ_SIDE_RIGHT]
            - right[PSQ_SEAM_LENGTHS][PSQ_SIDE_LEFT]
        ) < 0.000001
    );
    assert(
        in_list(
            PORTABLE_QUALITY_FLAG_SMALL,
            left[PSQ_FLAGS]
        )
    );
    assert(
        in_list(
            PORTABLE_QUALITY_FLAG_THIN,
            left[PSQ_FLAGS]
        )
    );
    assert(
        in_list(
            PORTABLE_QUALITY_FLAG_SHORT_SEAM,
            left[PSQ_FLAGS]
        )
    );

    echo("PASS", "portable_quality_threshold_contract");
