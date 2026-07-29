//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_occupancy.scad
// Project: Glyph Dossier
// FileGroup: BOSL2 Section Occupancy
// FileSummary: Intersects normalized regions with section cells.
//////////////////////////////////////////////////////////////////////

function portable_section_cell_region(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row
) = [[
    [
        section_x0(origin_x, cell_width, column),
        section_y0(origin_y, cell_height, row)
    ],
    [
        section_x0(origin_x, cell_width, column),
        section_y1(origin_y, cell_height, row)
    ],
    [
        section_x1(origin_x, cell_width, column),
        section_y1(origin_y, cell_height, row)
    ],
    [
        section_x1(origin_x, cell_width, column),
        section_y0(origin_y, cell_height, row)
    ]
]];

function portable_region_area_or_zero(region_data) =
    len(region_data) == 0
    ? 0
    : region_area(region_data);

function portable_region_component_count_or_zero(
    region_data
) =
    len(region_data) == 0
    ? 0
    : len(region_parts(region_data));

function portable_section_intersection_region(
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    boolean_epsilon
) =
    intersection(
        portable_normalized_region(
            glyph,
            target_height
        ),
        portable_section_cell_region(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row
        ),
        eps = boolean_epsilon
    );

function portable_section_occupancy_record(
    set_id,
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    area_epsilon,
    boolean_epsilon
) =
    let(
        clipped_region =
            portable_section_intersection_region(
                glyph,
                target_height,
                origin_x,
                origin_y,
                cell_width,
                cell_height,
                column,
                row,
                boolean_epsilon
            ),
        clipped_area =
            portable_region_area_or_zero(
                clipped_region
            ),
        cell_area = cell_width * cell_height,
        occupied = clipped_area > area_epsilon
    )
    [
        column,
        row,
        section_id(column, row),
        portable_section_object_id(
            set_id,
            glyph[PG_ID],
            column,
            row
        ),
        portable_section_global_bounds(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row
        ),
        portable_section_local_bounds(
            cell_width,
            cell_height
        ),
        clipped_area,
        clipped_area / cell_area,
        occupied
            ? portable_region_component_count_or_zero(
                clipped_region
            )
            : 0,
        occupied,
        occupied
            ? PORTABLE_SECTION_OCCUPIED
            : PORTABLE_SECTION_EMPTY,
        clipped_region
    ];

function portable_section_occupancy_records(
    set_id,
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    area_epsilon,
    boolean_epsilon
) = [
    for (row = [0 : rows - 1])
        for (column = [0 : columns - 1])
            portable_section_occupancy_record(
                set_id,
                glyph,
                target_height,
                origin_x,
                origin_y,
                cell_width,
                cell_height,
                column,
                row,
                area_epsilon,
                boolean_epsilon
            )
];

function portable_occupied_section_records(records) = [
    for (record = records)
        if (record[PSO_OCCUPIED])
            record
];

function portable_empty_section_records(records) = [
    for (record = records)
        if (!record[PSO_OCCUPIED])
            record
];

function portable_occupied_section_ids(records) = [
    for (record = records)
        if (record[PSO_OCCUPIED])
            record[PSO_SECTION_ID]
];

function portable_occupied_section_object_ids(
    records
) = [
    for (record = records)
        if (record[PSO_OCCUPIED])
            record[PSO_OBJECT_ID]
];

function portable_occupied_section_count(records) =
    len(portable_occupied_section_records(records));

function portable_empty_section_count(records) =
    len(portable_empty_section_records(records));

function portable_total_clipped_area(records) =
    sum([for (record = records) record[PSO_AREA]]);

function portable_normalized_glyph_area(
    glyph,
    target_height
) =
    region_area(
        portable_normalized_region(
            glyph,
            target_height
        )
    );

function portable_occupancy_record_by_index(
    records,
    column,
    row
) =
    let(
        matches = [
            for (record = records)
                if (
                    record[PSO_COLUMN] == column
                    && record[PSO_ROW] == row
                )
                    record
        ]
    )
    assert(
        len(matches) == 1,
        str(
            "Expected one occupancy record at [",
            column,
            ", ",
            row,
            "]; found ",
            len(matches),
            "."
        )
    )
    matches[0];

function portable_occupied_record_by_ordinal(
    records,
    occupied_ordinal
) =
    let(
        occupied_records =
            portable_occupied_section_records(records)
    )
    assert(
        occupied_ordinal >= 0
        && occupied_ordinal < len(occupied_records)
        && floor(occupied_ordinal)
            == occupied_ordinal,
        str(
            "Occupied ordinal ",
            occupied_ordinal,
            " is outside [0, ",
            len(occupied_records) - 1,
            "]."
        )
    )
    occupied_records[occupied_ordinal];
