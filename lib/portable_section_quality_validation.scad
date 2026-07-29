//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_quality_validation.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Quality Contracts
// FileSummary: Validates immutable quality records and partitions.
//////////////////////////////////////////////////////////////////////

module validate_portable_section_quality_records(
    records,
    occupancy_records,
    columns,
    rows,
    bed_x,
    bed_y
) {
    tolerance = 0.000001;

    assert(
        len(records) == len(occupancy_records),
        "Quality and occupancy record counts differ."
    );
    assert(
        len(records) == section_count(columns, rows),
        "Quality record count does not match grid."
    );
    assert(
        bed_x > 0 && bed_y > 0,
        "Quality bed dimensions must be positive."
    );

    for (index = [0 : len(records) - 1]) {
        record = records[index];
        occupancy = occupancy_records[index];

        assert(
            record[PSQ_COLUMN]
                == occupancy[PSO_COLUMN]
            && record[PSQ_ROW]
                == occupancy[PSO_ROW],
            str(
                "Quality index mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            record[PSQ_SECTION_ID]
                == occupancy[PSO_SECTION_ID],
            str(
                "Quality section ID mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            record[PSQ_OBJECT_ID]
                == occupancy[PSO_OBJECT_ID],
            "Quality object ID mismatch."
        );
        assert(
            record[PSQ_OCCUPIED]
                == occupancy[PSO_OCCUPIED],
            str(
                "Quality occupancy mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            abs(
                record[PSQ_AREA]
                - occupancy[PSO_AREA]
            ) < tolerance,
            str(
                "Quality area mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            len(record[PSQ_SEAM_LENGTHS]) == 4,
            "Quality seam-length vector must have four sides."
        );
        assert(
            len(record[PSQ_SEAM_SEGMENT_COUNTS])
                == 4,
            "Quality seam-segment vector must have four sides."
        );
        assert(
            record[PSQ_COMPONENT_COUNT]
                == len(record[PSQ_COMPONENT_AREAS]),
            str(
                "Quality component-area count mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            record[PSQ_COMPONENT_COUNT]
                == len(record[PSQ_COMPONENT_BOUNDS]),
            str(
                "Quality component-bounds count mismatch: ",
                record[PSQ_OBJECT_ID]
            )
        );
        assert(
            record[PSQ_MULTIPLE_COMPONENTS]
                == (
                    record[PSQ_COMPONENT_COUNT] > 1
                ),
            "Quality multiple-component Boolean mismatch."
        );
        assert(
            record[PSQ_REVIEW]
                == (
                    record[PSQ_OCCUPIED]
                    && len(record[PSQ_FLAGS]) > 0
                ),
            "Quality review Boolean mismatch."
        );
        assert(
            record[PSQ_STATUS]
                == (
                    !record[PSQ_OCCUPIED]
                    ? PORTABLE_QUALITY_EMPTY
                    : record[PSQ_REVIEW]
                    ? PORTABLE_QUALITY_REVIEW
                    : PORTABLE_QUALITY_CLEAR
                ),
            "Quality status mismatch."
        );
        assert(
            record[PSQ_OCCUPIED]
            || (
                record[PSQ_STATUS]
                    == PORTABLE_QUALITY_EMPTY
                && len(record[PSQ_FLAGS]) == 0
            ),
            "Empty quality record contains review flags."
        );
        assert(
            !record[PSQ_OCCUPIED]
            || !is_undef(
                record[PSQ_FRAGMENT_BOUNDS]
            ),
            "Occupied quality record has no fragment bounds."
        );
        assert(
            record[PSQ_FRAGMENT_SIZE][0] >= 0
            && record[PSQ_FRAGMENT_SIZE][1] >= 0,
            "Quality fragment size is negative."
        );
        assert(
            record[PSQ_BED_FIT]
                == (
                    !record[PSQ_OCCUPIED]
                    || (
                        record[PSQ_FRAGMENT_SIZE][0]
                            <= bed_x
                        && record[PSQ_FRAGMENT_SIZE][1]
                            <= bed_y
                    )
                ),
            "Quality bed-fit Boolean mismatch."
        );
    }

    assert(
        portable_quality_review_count(records)
        + portable_quality_clear_count(records)
        + portable_quality_empty_count(records)
        == len(records),
        "Quality statuses do not partition records."
    );
}
