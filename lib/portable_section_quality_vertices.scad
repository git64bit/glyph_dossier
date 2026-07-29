//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_quality_vertices.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Quality Mathematics
// FileSummary: Source-vertex proximity to internal section cuts.
//////////////////////////////////////////////////////////////////////

function portable_quality_side_is_internal(
    record,
    columns,
    rows,
    side
) =
    side == PSQ_SIDE_LEFT
    ? record[PSO_COLUMN] > 0
    : side == PSQ_SIDE_RIGHT
    ? record[PSO_COLUMN] < columns - 1
    : side == PSQ_SIDE_BOTTOM
    ? record[PSO_ROW] > 0
    : record[PSO_ROW] < rows - 1;

function portable_point_in_expanded_cell(
    point,
    bounds,
    expansion
) =
    point[0] >= bounds[0] - expansion
    && point[0] <= bounds[1] + expansion
    && point[1] >= bounds[2] - expansion
    && point[1] <= bounds[3] + expansion;

function portable_point_projects_to_side(
    point,
    bounds,
    side,
    expansion
) =
    (
        side == PSQ_SIDE_LEFT
        || side == PSQ_SIDE_RIGHT
    )
    ? (
        point[1] >= bounds[2] - expansion
        && point[1] <= bounds[3] + expansion
    )
    : (
        point[0] >= bounds[0] - expansion
        && point[0] <= bounds[1] + expansion
    );

function portable_point_cut_distance(
    point,
    bounds,
    side
) =
    side == PSQ_SIDE_LEFT
    ? abs(point[0] - bounds[0])
    : side == PSQ_SIDE_RIGHT
    ? abs(point[0] - bounds[1])
    : side == PSQ_SIDE_BOTTOM
    ? abs(point[1] - bounds[2])
    : abs(point[1] - bounds[3]);

function portable_vertex_cut_distances(
    glyph,
    target_height,
    record,
    columns,
    rows,
    search_distance
) =
    let(
        bounds = record[PSO_GLOBAL_BOUNDS],
        points = portable_region_points(
            portable_normalized_region(
                glyph,
                target_height
            )
        )
    )
    [
        for (point = points)
            for (side = [0 : 3])
                if (
                    portable_quality_side_is_internal(
                        record,
                        columns,
                        rows,
                        side
                    )
                    && portable_point_in_expanded_cell(
                        point,
                        bounds,
                        search_distance
                    )
                    && portable_point_projects_to_side(
                        point,
                        bounds,
                        side,
                        search_distance
                    )
                )
                    portable_point_cut_distance(
                        point,
                        bounds,
                        side
                    )
    ];

function portable_min_vertex_cut_distance(
    glyph,
    target_height,
    record,
    columns,
    rows,
    search_distance
) =
    portable_min_or_undef(
        portable_vertex_cut_distances(
            glyph,
            target_height,
            record,
            columns,
            rows,
            search_distance
        )
    );
