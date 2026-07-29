//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_lookup.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Lookup
// FileSummary: Exact set, mapping, and element identity lookup.
//////////////////////////////////////////////////////////////////////

function segmented_source_set_id_count(
    records,
    set_id
) =
    len([
        for (record = records)
            if (record[SSS_ID] == set_id)
                1
    ]);

function segmented_source_set_by_id(
    records,
    set_id
) =
    let(
        matches = [
            for (record = records)
                if (record[SSS_ID] == set_id)
                    record
        ]
    )
    assert(
        len(matches) == 1,
        str(
            "Expected one segmented source set ",
            set_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function segment_mapping_id_count(
    mappings,
    glyph_id
) =
    len([
        for (mapping = mappings)
            if (mapping[SM_GLYPH_ID] == glyph_id)
                1
    ]);

function segment_mapping_by_id(
    mappings,
    glyph_id
) =
    let(
        matches = [
            for (mapping = mappings)
                if (mapping[SM_GLYPH_ID] == glyph_id)
                    mapping
        ]
    )
    assert(
        len(matches) == 1,
        str(
            "Expected one segmented mapping ",
            glyph_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function segment_element_id_count(
    elements,
    element_id
) =
    len([
        for (element = elements)
            if (element[SE_ID] == element_id)
                1
    ]);

function segment_element_by_id(
    elements,
    element_id
) =
    let(
        matches = [
            for (element = elements)
                if (element[SE_ID] == element_id)
                    element
        ]
    )
    assert(
        len(matches) == 1,
        str(
            "Expected one segment element ",
            element_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function segmented_visible_mappings(mappings) = [
    for (mapping = mappings)
        if (
            mapping[SM_STATUS]
                == SEGMENT_STATUS_VISIBLE
        )
            mapping
];

function segmented_blank_mappings(mappings) = [
    for (mapping = mappings)
        if (
            mapping[SM_STATUS]
                == SEGMENT_STATUS_INTENTIONAL_BLANK
        )
            mapping
];

function segmented_unsupported_mappings(
    mappings
) = [
    for (mapping = mappings)
        if (
            mapping[SM_STATUS]
                == SEGMENT_STATUS_UNSUPPORTED
        )
            mapping
];
