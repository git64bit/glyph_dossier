//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_validation.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Contracts
// FileSummary: Validates templates, mappings, and adapter records.
//////////////////////////////////////////////////////////////////////

module validate_segmented_template(template) {
    assert(
        len(template) == 5,
        "Segment template record length is invalid."
    );
    assert(
        len(template[ST_ID]) > 0,
        "Segment template ID is empty."
    );
    assert(
        template[ST_WIDTH] > 0
        && template[ST_HEIGHT] > 0
        && template[ST_ADVANCE_WIDTH] > 0,
        "Segment template dimensions are invalid."
    );
    assert(
        len(template[ST_ELEMENTS]) > 0,
        "Segment template has no elements."
    );

    for (element = template[ST_ELEMENTS]) {
        assert(
            len(element) == 2,
            "Segment element record length is invalid."
        );
        assert(
            segment_element_id_count(
                template[ST_ELEMENTS],
                element[SE_ID]
            ) == 1,
            str(
                "Duplicate segment element ID: ",
                element[SE_ID]
            )
        );
        assert(
            len(element[SE_PATH]) >= 3,
            str(
                "Segment element path is too short: ",
                element[SE_ID]
            )
        );
        assert(
            is_region([element[SE_PATH]]),
            str(
                "Segment element is not a BOSL2 region: ",
                element[SE_ID]
            )
        );
        assert(
            is_valid_region([element[SE_PATH]]),
            str(
                "Segment element region is invalid: ",
                element[SE_ID]
            )
        );
    }
}

module validate_segmented_mapping(
    source_set,
    mapping
) {
    template = source_set[SSS_TEMPLATE];
    elements = template[ST_ELEMENTS];

    assert(
        len(mapping) == 7,
        "Segment mapping record length is invalid."
    );
    assert(
        len(mapping[SM_GLYPH_ID]) > 0,
        "Segment mapping glyph ID is empty."
    );
    assert(
        len(mapping[SM_CHARACTER]) == 1,
        str(
            "Segment mapping character is invalid: ",
            mapping[SM_GLYPH_ID]
        )
    );
    assert(
        mapping[SM_CODEPOINT] >= 0,
        str(
            "Segment mapping codepoint is invalid: ",
            mapping[SM_GLYPH_ID]
        )
    );
    assert(
        in_list(
            mapping[SM_STATUS],
            VALID_SEGMENT_MAPPING_STATUSES
        ),
        str(
            "Unknown segment mapping status: ",
            mapping[SM_GLYPH_ID]
        )
    );

    for (
        element_id =
            mapping[SM_ACTIVE_SEGMENTS]
    )
        assert(
            segment_element_id_count(
                elements,
                element_id
            ) == 1,
            str(
                "Unknown active segment ",
                element_id,
                " in ",
                mapping[SM_GLYPH_ID]
            )
        );

    assert(
        len(mapping[SM_ACTIVE_SEGMENTS])
            == len(
                deduplicate(
                    mapping[SM_ACTIVE_SEGMENTS]
                )
            ),
        str(
            "Duplicate active segment in ",
            mapping[SM_GLYPH_ID]
        )
    );

    if (segmented_mapping_is_visible(mapping)) {
        region_data =
            segmented_mapping_region(
                source_set,
                mapping
            );
        glyph =
            segmented_portable_glyph(
                source_set,
                mapping
            );

        assert(
            len(mapping[SM_ACTIVE_SEGMENTS]) > 0,
            str(
                "Visible mapping has no active segments: ",
                mapping[SM_GLYPH_ID]
            )
        );
        assert(
            is_region(region_data),
            str(
                "Visible segmented region is not recognized: ",
                mapping[SM_GLYPH_ID]
            )
        );
        assert(
            is_valid_region(region_data),
            str(
                "Visible segmented region is invalid: ",
                mapping[SM_GLYPH_ID]
            )
        );
        assert(
            len(region_parts(region_data))
                == len(
                    mapping[SM_ACTIVE_SEGMENTS]
                ),
            str(
                "Segment components touch or overlap: ",
                mapping[SM_GLYPH_ID]
            )
        );
        validate_portable_glyph(glyph);
    } else
        assert(
            len(mapping[SM_ACTIVE_SEGMENTS]) == 0,
            str(
                "Non-visible mapping contains active segments: ",
                mapping[SM_GLYPH_ID]
            )
        );
}

module validate_segmented_source_set(
    source_set
) {
    assert(
        len(source_set) == 9,
        "Segmented source-set record length is invalid."
    );
    assert(
        len(source_set[SSS_ID]) > 0,
        "Segmented source-set ID is empty."
    );
    assert(
        len(source_set[SSS_FINGERPRINT]) == 64,
        str(
            "Segmented source fingerprint is invalid: ",
            source_set[SSS_ID]
        )
    );
    assert(
        len(source_set[SSS_MAPPINGS]) == 66,
        str(
            "Expected 66 segmented mappings; found ",
            len(source_set[SSS_MAPPINGS])
        )
    );

    validate_segmented_template(
        source_set[SSS_TEMPLATE]
    );

    for (mapping = source_set[SSS_MAPPINGS]) {
        assert(
            segment_mapping_id_count(
                source_set[SSS_MAPPINGS],
                mapping[SM_GLYPH_ID]
            ) == 1,
            str(
                "Duplicate segmented mapping ID: ",
                mapping[SM_GLYPH_ID]
            )
        );
        validate_segmented_mapping(
            source_set,
            mapping
        );
    }
}
