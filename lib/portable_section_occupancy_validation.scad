//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_occupancy_validation.scad
// Project: Glyph Dossier
// FileGroup: Portable Occupancy Contracts
// FileSummary: Validates clipped-cell occupancy records.
//////////////////////////////////////////////////////////////////////

module validate_portable_section_occupancy_records(
    records,
    columns,
    rows,
    cell_width,
    cell_height,
    area_epsilon
) {
    ratio_tolerance = 0.000001;

    assert(
        len(records) == section_count(columns, rows),
        str(
            "Occupancy record count mismatch: expected ",
            section_count(columns, rows),
            "; found ",
            len(records),
            "."
        )
    );
    assert(
        area_epsilon >= 0,
        "Occupancy area epsilon must be nonnegative."
    );

    for (index = [0 : len(records) - 1]) {
        record = records[index];
        expected_column = index % columns;
        expected_row = floor(index / columns);

        assert(
            record[PSO_COLUMN] == expected_column
            && record[PSO_ROW] == expected_row,
            str(
                "Occupancy records are not row-major at ",
                index,
                "."
            )
        );
        assert(
            record[PSO_SECTION_ID]
                == section_id(
                    expected_column,
                    expected_row
                ),
            str(
                "Occupancy section ID mismatch at ",
                index,
                "."
            )
        );
        assert(
            record[PSO_AREA] >= 0,
            str(
                "Negative occupancy area: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_CELL_AREA_RATIO]
                >= -ratio_tolerance
            && record[PSO_CELL_AREA_RATIO]
                <= 1 + ratio_tolerance,
            str(
                "Occupancy area ratio outside [0,1]: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_COMPONENT_COUNT] >= 0,
            str(
                "Negative occupancy component count: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_OCCUPIED]
                == (
                    record[PSO_AREA]
                    > area_epsilon
                ),
            str(
                "Occupancy Boolean mismatch: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_STATUS]
                == (
                    record[PSO_OCCUPIED]
                    ? PORTABLE_SECTION_OCCUPIED
                    : PORTABLE_SECTION_EMPTY
                ),
            str(
                "Occupancy status mismatch: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_OCCUPIED]
            || len(record[PSO_REGION]) == 0
            || record[PSO_AREA] <= area_epsilon,
            str(
                "Empty record exceeds area epsilon: ",
                record[PSO_OBJECT_ID]
            )
        );
        assert(
            record[PSO_OCCUPIED]
            ? len(record[PSO_REGION]) > 0
            : true,
            str(
                "Occupied record has no clipped region: ",
                record[PSO_OBJECT_ID]
            )
        );
    }

    assert(
        portable_occupied_section_count(records)
        + portable_empty_section_count(records)
        == len(records),
        "Occupied and empty counts do not partition records."
    );
}
