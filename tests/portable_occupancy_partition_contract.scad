    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_occupancy_partition_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Cell areas reconstruct representative glyph areas.
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


    REPRESENTATIVE_MATRIX = [
        ["LIBERATION_SANS_REGULAR_R1", "U_A"],
        ["MONTSERRAT_REGULAR_R1", "U_Z"],
        ["ALPHA_SLAB_ONE_REGULAR_R1", "U_B"],
        ["FIRA_SANS_REGULAR_R1", "L_g"],
        ["MIAMA_NUEVA_MEDIUM_R1", "L_j"],
        ["PLAYFAIR_DISPLAY_REGULAR_R1", "P_semicolon"]
    ];

    target_height = 120;
    cell_width = 60;
    cell_height = 60;
    area_tolerance = 0.01;

    for (entry = REPRESENTATIVE_MATRIX) {
        set_record = portable_font_set_by_id(
            PORTABLE_FONT_SETS,
            entry[0]
        );
        glyph = portable_glyph_by_id(
            set_record[PFS_GLYPHS],
            entry[1]
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
        glyph_area = portable_normalized_glyph_area(
            glyph,
            target_height
        );
        clipped_area =
            portable_total_clipped_area(records);

        assert(
            portable_occupied_section_count(records)
                > 0,
            str("No occupied cells: ", entry)
        );
        assert(
            abs(clipped_area - glyph_area)
                < area_tolerance,
            str(
                "Partition area mismatch: ",
                entry,
                " delta=",
                clipped_area - glyph_area
            )
        );

        echo(
            "PORTABLE_OCCUPANCY_PARTITION_ENTRY",
            [
                entry[0],
                entry[1],
                len(records),
                portable_occupied_section_count(records),
                glyph_area,
                clipped_area,
                clipped_area - glyph_area
            ]
        );
    }

    echo("PASS", "portable_occupancy_partition_contract");
