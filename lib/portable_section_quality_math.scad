//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_quality_math.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Quality Mathematics
// FileSummary: Region bounds, component metrics, seams, and vertices.
//////////////////////////////////////////////////////////////////////

function portable_min_or_undef(values) =
    len(values) == 0 ? undef : min(values);

function portable_max_or_zero(values) =
    len(values) == 0 ? 0 : max(values);

function portable_positive_min_or_undef(
    values,
    epsilon
) =
    let(
        positive = [
            for (value = values)
                if (value > epsilon)
                    value
        ]
    )
    portable_min_or_undef(positive);

function portable_segment_length_2d(a, b) =
    sqrt(
        pow(b[0] - a[0], 2)
        + pow(b[1] - a[1], 2)
    );

function portable_region_points(region_data) =
    len(region_data) == 0
    ? []
    : [
        for (path = region_data)
            for (point = path)
                point
    ];

function portable_points_bounds_or_undef(points) =
    len(points) == 0
    ? undef
    : [
        min([for (point = points) point[0]]),
        min([for (point = points) point[1]]),
        max([for (point = points) point[0]]),
        max([for (point = points) point[1]])
    ];

function portable_region_bounds_or_undef(
    region_data
) =
    portable_points_bounds_or_undef(
        portable_region_points(region_data)
    );

function portable_bounds_size_or_zero(bounds) =
    is_undef(bounds)
    ? [0, 0]
    : [
        bounds[2] - bounds[0],
        bounds[3] - bounds[1]
    ];

function portable_bounds_min_extent_or_undef(
    bounds
) =
    is_undef(bounds)
    ? undef
    : min(portable_bounds_size_or_zero(bounds));

function portable_component_regions(record) =
    record[PSO_OCCUPIED]
    ? region_parts(record[PSO_REGION])
    : [];

function portable_component_areas(record) = [
    for (component = portable_component_regions(record))
        region_area(component)
];

function portable_component_bounds(record) = [
    for (component = portable_component_regions(record))
        portable_region_bounds_or_undef(component)
];

function portable_component_min_extents(record) = [
    for (bounds = portable_component_bounds(record))
        portable_bounds_min_extent_or_undef(bounds)
];

function portable_component_thickness_estimates(
    record
) =
    let(
        areas = portable_component_areas(record),
        bounds_list = portable_component_bounds(record)
    )
    len(areas) == 0
    ? []
    : [
        for (index = [0 : len(areas) - 1])
            let(
                size =
                    portable_bounds_size_or_zero(
                        bounds_list[index]
                    ),
                maximum_span = max(size)
            )
            maximum_span > 0
            ? areas[index] / maximum_span
            : 0
    ];

function portable_path_vertical_boundary_length(
    path,
    boundary_x,
    tolerance
) =
    len(path) < 2
    ? 0
    : sum([
        for (index = [0 : len(path) - 1])
            let(
                a = path[index],
                b = path[(index + 1) % len(path)],
                length = portable_segment_length_2d(
                    a,
                    b
                )
            )
            (
                abs(a[0] - boundary_x) <= tolerance
                && abs(b[0] - boundary_x)
                    <= tolerance
                && length > tolerance
            )
            ? length
            : 0
    ]);

function portable_path_horizontal_boundary_length(
    path,
    boundary_y,
    tolerance
) =
    len(path) < 2
    ? 0
    : sum([
        for (index = [0 : len(path) - 1])
            let(
                a = path[index],
                b = path[(index + 1) % len(path)],
                length = portable_segment_length_2d(
                    a,
                    b
                )
            )
            (
                abs(a[1] - boundary_y) <= tolerance
                && abs(b[1] - boundary_y)
                    <= tolerance
                && length > tolerance
            )
            ? length
            : 0
    ]);

function portable_path_vertical_boundary_segments(
    path,
    boundary_x,
    tolerance
) =
    len(path) < 2
    ? 0
    : len([
        for (index = [0 : len(path) - 1])
            let(
                a = path[index],
                b = path[(index + 1) % len(path)],
                length = portable_segment_length_2d(
                    a,
                    b
                )
            )
            if (
                abs(a[0] - boundary_x) <= tolerance
                && abs(b[0] - boundary_x)
                    <= tolerance
                && length > tolerance
            )
                1
    ]);

function portable_path_horizontal_boundary_segments(
    path,
    boundary_y,
    tolerance
) =
    len(path) < 2
    ? 0
    : len([
        for (index = [0 : len(path) - 1])
            let(
                a = path[index],
                b = path[(index + 1) % len(path)],
                length = portable_segment_length_2d(
                    a,
                    b
                )
            )
            if (
                abs(a[1] - boundary_y) <= tolerance
                && abs(b[1] - boundary_y)
                    <= tolerance
                && length > tolerance
            )
                1
    ]);

function portable_region_vertical_boundary_length(
    region_data,
    boundary_x,
    tolerance
) =
    len(region_data) == 0
    ? 0
    : sum([
        for (path = region_data)
            portable_path_vertical_boundary_length(
                path,
                boundary_x,
                tolerance
            )
    ]);

function portable_region_horizontal_boundary_length(
    region_data,
    boundary_y,
    tolerance
) =
    len(region_data) == 0
    ? 0
    : sum([
        for (path = region_data)
            portable_path_horizontal_boundary_length(
                path,
                boundary_y,
                tolerance
            )
    ]);

function portable_region_vertical_boundary_segments(
    region_data,
    boundary_x,
    tolerance
) =
    len(region_data) == 0
    ? 0
    : sum([
        for (path = region_data)
            portable_path_vertical_boundary_segments(
                path,
                boundary_x,
                tolerance
            )
    ]);

function portable_region_horizontal_boundary_segments(
    region_data,
    boundary_y,
    tolerance
) =
    len(region_data) == 0
    ? 0
    : sum([
        for (path = region_data)
            portable_path_horizontal_boundary_segments(
                path,
                boundary_y,
                tolerance
            )
    ]);

function portable_quality_side_delta(side) =
    side == PSQ_SIDE_LEFT
    ? [-1, 0]
    : side == PSQ_SIDE_RIGHT
    ? [1, 0]
    : side == PSQ_SIDE_BOTTOM
    ? [0, -1]
    : [0, 1];

function portable_quality_opposite_side(side) =
    side == PSQ_SIDE_LEFT
    ? PSQ_SIDE_RIGHT
    : side == PSQ_SIDE_RIGHT
    ? PSQ_SIDE_LEFT
    : side == PSQ_SIDE_BOTTOM
    ? PSQ_SIDE_TOP
    : PSQ_SIDE_BOTTOM;

function portable_quality_neighbor_record(
    records,
    record,
    columns,
    rows,
    side
) =
    let(
        delta = portable_quality_side_delta(side),
        column = record[PSO_COLUMN] + delta[0],
        row = record[PSO_ROW] + delta[1]
    )
    (
        column < 0
        || column >= columns
        || row < 0
        || row >= rows
    )
    ? undef
    : records[row * columns + column];

function portable_record_raw_side_length(
    record,
    side,
    tolerance
) =
    let(bounds = record[PSO_GLOBAL_BOUNDS])
    side == PSQ_SIDE_LEFT
    ? portable_region_vertical_boundary_length(
        record[PSO_REGION],
        bounds[0],
        tolerance
    )
    : side == PSQ_SIDE_RIGHT
    ? portable_region_vertical_boundary_length(
        record[PSO_REGION],
        bounds[1],
        tolerance
    )
    : side == PSQ_SIDE_BOTTOM
    ? portable_region_horizontal_boundary_length(
        record[PSO_REGION],
        bounds[2],
        tolerance
    )
    : portable_region_horizontal_boundary_length(
        record[PSO_REGION],
        bounds[3],
        tolerance
    );

function portable_record_raw_side_segments(
    record,
    side,
    tolerance
) =
    let(bounds = record[PSO_GLOBAL_BOUNDS])
    side == PSQ_SIDE_LEFT
    ? portable_region_vertical_boundary_segments(
        record[PSO_REGION],
        bounds[0],
        tolerance
    )
    : side == PSQ_SIDE_RIGHT
    ? portable_region_vertical_boundary_segments(
        record[PSO_REGION],
        bounds[1],
        tolerance
    )
    : side == PSQ_SIDE_BOTTOM
    ? portable_region_horizontal_boundary_segments(
        record[PSO_REGION],
        bounds[2],
        tolerance
    )
    : portable_region_horizontal_boundary_segments(
        record[PSO_REGION],
        bounds[3],
        tolerance
    );

function portable_shared_side_length(
    records,
    record,
    columns,
    rows,
    side,
    tolerance
) =
    let(
        neighbor = portable_quality_neighbor_record(
            records,
            record,
            columns,
            rows,
            side
        )
    )
    (
        !record[PSO_OCCUPIED]
        || is_undef(neighbor)
        || !neighbor[PSO_OCCUPIED]
    )
    ? 0
    : min(
        portable_record_raw_side_length(
            record,
            side,
            tolerance
        ),
        portable_record_raw_side_length(
            neighbor,
            portable_quality_opposite_side(side),
            tolerance
        )
    );

function portable_shared_side_segments(
    records,
    record,
    columns,
    rows,
    side,
    tolerance
) =
    let(
        neighbor = portable_quality_neighbor_record(
            records,
            record,
            columns,
            rows,
            side
        )
    )
    (
        !record[PSO_OCCUPIED]
        || is_undef(neighbor)
        || !neighbor[PSO_OCCUPIED]
    )
    ? 0
    : min(
        portable_record_raw_side_segments(
            record,
            side,
            tolerance
        ),
        portable_record_raw_side_segments(
            neighbor,
            portable_quality_opposite_side(side),
            tolerance
        )
    );

function portable_quality_seam_lengths(
    records,
    record,
    columns,
    rows,
    tolerance
) = [
    for (side = [0 : 3])
        portable_shared_side_length(
            records,
            record,
            columns,
            rows,
            side,
            tolerance
        )
];

function portable_quality_seam_segments(
    records,
    record,
    columns,
    rows,
    tolerance
) = [
    for (side = [0 : 3])
        portable_shared_side_segments(
            records,
            record,
            columns,
            rows,
            side,
            tolerance
        )
];
