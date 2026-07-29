//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_occupancy_reporting.scad
// Project: Glyph Dossier
// FileGroup: Portable Occupancy Reporting
// FileSummary: Reports occupied cells and clipped-region metrics.
//////////////////////////////////////////////////////////////////////

module report_portable_section_occupancy_summary(
    set_record,
    glyph,
    target_height,
    records,
    area_epsilon,
    boolean_epsilon
) {
    glyph_area = portable_normalized_glyph_area(
        glyph,
        target_height
    );
    clipped_area = portable_total_clipped_area(
        records
    );

    echo(
        "PORTABLE_OCCUPANCY_SET_ID",
        set_record[PFS_ID]
    );
    echo(
        "PORTABLE_OCCUPANCY_GLYPH_ID",
        glyph[PG_ID]
    );
    echo(
        "PORTABLE_OCCUPANCY_TOTAL_CELL_COUNT",
        len(records)
    );
    echo(
        "PORTABLE_OCCUPANCY_OCCUPIED_COUNT",
        portable_occupied_section_count(records)
    );
    echo(
        "PORTABLE_OCCUPANCY_EMPTY_COUNT",
        portable_empty_section_count(records)
    );
    echo(
        "PORTABLE_OCCUPANCY_OCCUPIED_IDS",
        portable_occupied_section_ids(records)
    );
    echo(
        "PORTABLE_OCCUPANCY_OCCUPIED_OBJECT_IDS",
        portable_occupied_section_object_ids(
            records
        )
    );
    echo(
        "PORTABLE_OCCUPANCY_GLYPH_AREA_MM2",
        glyph_area
    );
    echo(
        "PORTABLE_OCCUPANCY_CLIPPED_AREA_SUM_MM2",
        clipped_area
    );
    echo(
        "PORTABLE_OCCUPANCY_AREA_DELTA_MM2",
        clipped_area - glyph_area
    );
    echo(
        "PORTABLE_OCCUPANCY_AREA_EPSILON_MM2",
        area_epsilon
    );
    echo(
        "PORTABLE_OCCUPANCY_BOOLEAN_EPSILON_MM",
        boolean_epsilon
    );
    echo(
        "PORTABLE_OCCUPANCY_BOUNDARY_POLICY",
        "Zero-area or boundary-only contact is empty."
    );
}

module report_portable_section_occupancy_manifest(
    records
) {
    echo(
        "PORTABLE_OCCUPANCY_MANIFEST_COUNT",
        len(records)
    );

    for (record = records)
        echo(
            "PORTABLE_OCCUPANCY_MANIFEST_ENTRY",
            [
                record[PSO_OBJECT_ID],
                "section_id",
                record[PSO_SECTION_ID],
                "index",
                [
                    record[PSO_COLUMN],
                    record[PSO_ROW]
                ],
                "status",
                record[PSO_STATUS],
                "area_mm2",
                record[PSO_AREA],
                "cell_area_ratio",
                record[PSO_CELL_AREA_RATIO],
                "components",
                record[PSO_COMPONENT_COUNT],
                "global_bounds",
                record[PSO_GLOBAL_BOUNDS],
                "local_bounds",
                record[PSO_LOCAL_BOUNDS]
            ]
        );
}

module report_portable_selected_occupancy_record(
    record,
    occupied_ordinal = undef
) {
    if (!is_undef(occupied_ordinal))
        echo(
            "PORTABLE_SELECTED_OCCUPIED_ORDINAL",
            occupied_ordinal
        );

    echo(
        "PORTABLE_SELECTED_OCCUPANCY_OBJECT_ID",
        record[PSO_OBJECT_ID]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_SECTION_ID",
        record[PSO_SECTION_ID]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_INDEX",
        [record[PSO_COLUMN], record[PSO_ROW]]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_STATUS",
        record[PSO_STATUS]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_AREA_MM2",
        record[PSO_AREA]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_CELL_AREA_RATIO",
        record[PSO_CELL_AREA_RATIO]
    );
    echo(
        "PORTABLE_SELECTED_OCCUPANCY_COMPONENTS",
        record[PSO_COMPONENT_COUNT]
    );
}
