    //////////////////////////////////////////////////////////////////////
    // LibFile: segmented_pipeline_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Adapter feeds generic grid and BOSL2 occupancy.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>
include <../lib/sectioning.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../lib/portable_section_occupancy.scad>
include <../lib/segmented_source_schema.scad>
include <../lib/segmented_source_lookup.scad>
include <../lib/segmented_source_adapter.scad>
include <../lib/segmented_source_validation.scad>
include <../registries/segmented_source_sets.scad>
include <../geometry/portable_glyph_region.scad>


    CASES = [
        [
            "PROCEDURAL_14_SEGMENT_EXTENDED_R1",
            "U_A"
        ],
        [
            "PROCEDURAL_7_SEGMENT_EXTENDED_R1",
            "D_8"
        ]
    ];

    target_height = 240;
    cell_width = 100;
    cell_height = 100;
    tolerance = 0.0001;

    for (entry = CASES) {
        source_set = segmented_source_set_by_id(
            SEGMENTED_SOURCE_SETS,
            entry[0]
        );
        mapping = segment_mapping_by_id(
            source_set[SSS_MAPPINGS],
            entry[1]
        );
        glyph = segmented_portable_glyph(
            source_set,
            mapping
        );
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
        records =
            portable_section_occupancy_records(
                source_set[SSS_ID],
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

        assert(
            portable_generic_grid_covers_glyph(
                glyph,
                target_height,
                origin_x,
                0,
                cell_width,
                cell_height,
                columns,
                rows
            )
        );
        assert(
            portable_occupied_section_count(records)
                > 0
        );
        assert(
            abs(
                portable_total_clipped_area(records)
                - portable_normalized_glyph_area(
                    glyph,
                    target_height
                )
            ) < tolerance
        );
    }

    echo("PASS", "segmented_pipeline_contract");
