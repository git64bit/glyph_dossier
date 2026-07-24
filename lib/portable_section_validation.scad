//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_validation.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Contracts
// FileSummary: Validates the portable uppercase-A grid experiment.
//////////////////////////////////////////////////////////////////////

module validate_portable_a_section(
    glyph,
    target_height,
    depth,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    selected_column,
    selected_row,
    epsilon,
    layout_gap,
    bed_x,
    bed_y,
    apex_y_ratio,
    counter_bottom_ratio,
    counter_top_ratio,
    crossbar_y_ratio,
    counter_half_width_ratio
) {
    assert(
        glyph[PG_ID] == "U_A",
        str(
            "Batch 006 sections portable U_A only; selected ",
            glyph[PG_ID]
        )
    );
    assert(target_height > 0, "Portable target height must be positive.");
    assert(depth > 0, "Portable extrusion depth must be positive.");
    assert(cell_width > 0, "Portable section width must be positive.");
    assert(cell_height > 0, "Portable section height must be positive.");
    assert(
        columns >= 1 && floor(columns) == columns,
        "Portable section columns must be a positive integer."
    );
    assert(
        rows >= 1 && floor(rows) == rows,
        "Portable section rows must be a positive integer."
    );
    assert(
        selected_column >= 0
        && selected_column < columns
        && floor(selected_column) == selected_column,
        "Portable selected column is outside the grid."
    );
    assert(
        selected_row >= 0
        && selected_row < rows
        && floor(selected_row) == selected_row,
        "Portable selected row is outside the grid."
    );
    assert(
        epsilon > 0 && epsilon <= 1,
        "Portable clipping epsilon must be in (0, 1]."
    );
    assert(layout_gap >= 0, "Portable layout gap must be nonnegative.");
    assert(
        cell_width <= bed_x,
        str(
            "Portable section width ",
            cell_width,
            " exceeds configured bed width ",
            bed_x
        )
    );
    assert(
        cell_height <= bed_y,
        str(
            "Portable section height ",
            cell_height,
            " exceeds configured bed height ",
            bed_y
        )
    );
    assert(
        apex_y_ratio > 0 && apex_y_ratio <= 1,
        "Portable A apex ratio must be in (0, 1]."
    );
    assert(
        counter_bottom_ratio >= 0
        && counter_bottom_ratio < counter_top_ratio,
        "Portable A counter ratios are invalid."
    );
    assert(
        counter_top_ratio <= apex_y_ratio,
        "Portable A counter top must remain below the apex."
    );
    assert(
        crossbar_y_ratio >= counter_bottom_ratio
        && crossbar_y_ratio <= counter_top_ratio,
        "Portable A crossbar must remain inside the counter range."
    );
    assert(
        counter_half_width_ratio > 0
        && counter_half_width_ratio < 0.5,
        "Portable A counter half-width ratio must be in (0, 0.5)."
    );
}

function portable_grid_covers_glyph(
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows
) =
    origin_x <= portable_normalized_left(
        glyph,
        target_height
    )
    && origin_y <= portable_normalized_bottom(
        glyph,
        target_height
    )
    && origin_x + section_plan_width(
        cell_width,
        columns
    ) >= portable_normalized_right(
        glyph,
        target_height
    )
    && origin_y + section_plan_height(
        cell_height,
        rows
    ) >= portable_normalized_top(
        glyph,
        target_height
    );
