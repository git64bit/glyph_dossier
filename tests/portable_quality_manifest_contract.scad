    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_quality_manifest_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Real-glyph quality records preserve occupancy identity.
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

    include <../lib/portable_section_quality_validation.scad>

    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        "FIRA_SANS_REGULAR_R1"
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        "L_g"
    );

    target_height = 240;
    cell_width = 100;
    cell_height = 100;
    columns = portable_auto_section_columns(
        glyph,
        target_height,
        cell_width
    );
    rows = portable_auto_section_rows(
        target_height,
        cell_height
    );
    origin_x =
        -section_plan_width(
            cell_width,
            columns
        ) / 2;

    occupancy_records =
        portable_section_occupancy_records(
            set_record[PFS_ID],
            glyph,
            target_height,
            origin_x,
            0,
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
            glyph,
            target_height,
            columns,
            rows,
            100,
            5,
            5,
            15,
            2,
            0.000001,
            120,
            120
        );

    validate_portable_section_quality_records(
        quality_records,
        occupancy_records,
        columns,
        rows,
        120,
        120
    );

    for (row = [0 : rows - 1])
        for (column = [0 : columns - 2]) {
            left =
                quality_records[
                    row * columns + column
                ];
            right =
                quality_records[
                    row * columns + column + 1
                ];

            assert(
                abs(
                    left[PSQ_SEAM_LENGTHS][PSQ_SIDE_RIGHT]
                    - right[PSQ_SEAM_LENGTHS][PSQ_SIDE_LEFT]
                ) < 0.000001,
                str("Vertical seam asymmetry at ", [column, row])
            );
        }

    for (row = [0 : rows - 2])
        for (column = [0 : columns - 1]) {
            bottom =
                quality_records[
                    row * columns + column
                ];
            top =
                quality_records[
                    (row + 1) * columns + column
                ];

            assert(
                abs(
                    bottom[PSQ_SEAM_LENGTHS][PSQ_SIDE_TOP]
                    - top[PSQ_SEAM_LENGTHS][PSQ_SIDE_BOTTOM]
                ) < 0.000001,
                str("Horizontal seam asymmetry at ", [column, row])
            );
        }

    echo(
        "PORTABLE_QUALITY_REVIEW_IDS",
        portable_quality_review_object_ids(
            quality_records
        )
    );
    echo("PASS", "portable_quality_manifest_contract");
