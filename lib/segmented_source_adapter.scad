//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_adapter.scad
// Project: Glyph Dossier
// FileGroup: Procedural Segment Adapter
// FileSummary: Converts visible masks to portable-glyph records.
//////////////////////////////////////////////////////////////////////

function segmented_region_points(region_data) = [
    for (path = region_data)
        for (point = path)
            point
];

function segmented_region_bounds(region_data) =
    let(points = segmented_region_points(region_data))
    assert(
        len(points) > 0,
        "Cannot calculate bounds for an empty segment region."
    )
    [
        min([for (point = points) point[0]]),
        min([for (point = points) point[1]]),
        max([for (point = points) point[0]]),
        max([for (point = points) point[1]])
    ];

function segmented_mapping_is_visible(mapping) =
    mapping[SM_STATUS] == SEGMENT_STATUS_VISIBLE;

function segmented_mapping_is_blank(mapping) =
    mapping[SM_STATUS]
        == SEGMENT_STATUS_INTENTIONAL_BLANK;

function segmented_mapping_is_unsupported(mapping) =
    mapping[SM_STATUS]
        == SEGMENT_STATUS_UNSUPPORTED;

function segmented_active_elements(
    source_set,
    mapping
) =
    let(
        elements =
            source_set[SSS_TEMPLATE][ST_ELEMENTS]
    )
    [
        for (
            element_id =
                mapping[SM_ACTIVE_SEGMENTS]
        )
            segment_element_by_id(
                elements,
                element_id
            )
    ];

function segmented_mapping_region(
    source_set,
    mapping
) =
    segmented_mapping_is_visible(mapping)
    ? [
        for (
            element =
                segmented_active_elements(
                    source_set,
                    mapping
                )
        )
            element[SE_PATH]
    ]
    : [];

function segmented_mapping_point_count(
    source_set,
    mapping
) =
    portable_region_point_count(
        segmented_mapping_region(
            source_set,
            mapping
        )
    );

function segmented_portable_glyph(
    source_set,
    mapping
) =
    assert(
        segmented_mapping_is_visible(mapping),
        str(
            "Segment mapping is not visible: ",
            source_set[SSS_ID],
            " ",
            mapping[SM_GLYPH_ID],
            " ",
            mapping[SM_STATUS]
        )
    )
    let(
        region_data =
            segmented_mapping_region(
                source_set,
                mapping
            ),
        bounds =
            segmented_region_bounds(
                region_data
            ),
        component_count =
            len(mapping[SM_ACTIVE_SEGMENTS])
    )
    [
        mapping[SM_GLYPH_ID],
        mapping[SM_CHARACTER],
        mapping[SM_CODEPOINT],
        str(
            source_set[SSS_ID],
            "__",
            mapping[SM_GLYPH_ID]
        ),
        source_set[SSS_TEMPLATE][ST_HEIGHT],
        source_set[SSS_TEMPLATE][ST_ADVANCE_WIDTH],
        bounds,
        bounds,
        len(region_data),
        component_count,
        0,
        portable_region_point_count(region_data),
        0,
        source_set[SSS_FINGERPRINT],
        region_data
    ];
