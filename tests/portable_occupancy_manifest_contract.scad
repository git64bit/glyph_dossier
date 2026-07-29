    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_occupancy_manifest_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Row-major records, IDs, counts, and ordinal lookup.
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

    include <../lib/portable_section_occupancy_validation.scad>

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

    records = portable_section_occupancy_records(
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

    validate_portable_section_occupancy_records(
        records,
        columns,
        rows,
        cell_width,
        cell_height,
        0.000001
    );

    assert(
        records[0][PSO_SECTION_ID] == "C1_R1"
    );
    assert(
        records[len(records) - 1][PSO_SECTION_ID]
            == section_id(columns - 1, rows - 1)
    );
    assert(
        portable_occupancy_record_by_index(
            records,
            0,
            0
        )[PSO_OBJECT_ID]
            == str(
                "FIRA_SANS_REGULAR_R1__L_g__",
                "C1_R1"
            )
    );

    first_occupied =
        portable_occupied_record_by_ordinal(
            records,
            0
        );

    assert(first_occupied[PSO_OCCUPIED]);
    assert(
        first_occupied[PSO_STATUS]
            == PORTABLE_SECTION_OCCUPIED
    );
    assert(
        len(portable_occupied_section_ids(records))
            == portable_occupied_section_count(records)
    );

    echo(
        "PORTABLE_OCCUPANCY_MANIFEST_OCCUPIED_IDS",
        portable_occupied_section_ids(records)
    );
    echo("PASS", "portable_occupancy_manifest_contract");
