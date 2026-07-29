//////////////////////////////////////////////////////////////////////
// LibFile: portable_generic_sectioning.scad
// Project: Glyph Dossier
// FileGroup: Generic Portable Section Mathematics
// FileSummary: Resolves automatic or manual grid geometry.
//////////////////////////////////////////////////////////////////////

function portable_auto_section_columns(
    glyph,
    target_height,
    cell_width
) =
    max(
        1,
        ceil(
            portable_normalized_width(
                glyph,
                target_height
            ) / cell_width
        )
    );

function portable_auto_section_rows(
    target_height,
    cell_height
) =
    max(
        1,
        ceil(target_height / cell_height)
    );

function portable_resolved_section_columns(
    glyph,
    target_height,
    cell_width,
    manual_columns,
    grid_mode
) =
    grid_mode == "auto"
    ? portable_auto_section_columns(
        glyph,
        target_height,
        cell_width
    )
    : manual_columns;

function portable_resolved_section_rows(
    target_height,
    cell_height,
    manual_rows,
    grid_mode
) =
    grid_mode == "auto"
    ? portable_auto_section_rows(
        target_height,
        cell_height
    )
    : manual_rows;

function portable_resolved_section_origin_x(
    glyph,
    target_height,
    cell_width,
    manual_origin_x,
    manual_columns,
    grid_mode
) =
    grid_mode == "auto"
    ? -section_plan_width(
        cell_width,
        portable_auto_section_columns(
            glyph,
            target_height,
            cell_width
        )
    ) / 2
    : manual_origin_x;

function portable_resolved_section_origin_y(
    manual_origin_y,
    grid_mode
) =
    grid_mode == "auto"
    ? 0
    : manual_origin_y;

function portable_generic_grid_covers_glyph(
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    tolerance = 0.000001
) =
    origin_x <= portable_normalized_left(
        glyph,
        target_height
    ) + tolerance
    && origin_y <= portable_normalized_bottom(
        glyph,
        target_height
    ) + tolerance
    && origin_x + section_plan_width(
        cell_width,
        columns
    ) >= portable_normalized_right(
        glyph,
        target_height
    ) - tolerance
    && origin_y + section_plan_height(
        cell_height,
        rows
    ) >= portable_normalized_top(
        glyph,
        target_height
    ) - tolerance;

function portable_section_global_bounds(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row
) = [
    section_x0(origin_x, cell_width, column),
    section_x1(origin_x, cell_width, column),
    section_y0(origin_y, cell_height, row),
    section_y1(origin_y, cell_height, row)
];

function portable_section_local_bounds(
    cell_width,
    cell_height
) = [
    0,
    cell_width,
    0,
    cell_height
];

function portable_section_object_id(
    set_id,
    glyph_id,
    column,
    row
) =
    str(
        set_id,
        "__",
        glyph_id,
        "__",
        section_id(column, row)
    );
