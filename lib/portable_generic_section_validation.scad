//////////////////////////////////////////////////////////////////////
// LibFile: portable_generic_section_validation.scad
// Project: Glyph Dossier
// FileGroup: Generic Portable Section Contracts
// FileSummary: Validates resolved multi-family section plans.
//////////////////////////////////////////////////////////////////////

module validate_portable_generic_section(
    set_record,
    glyph,
    target_height,
    depth,
    grid_mode,
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
    bed_y
) {
    assert(
        glyph[PG_SOURCE_SHA256]
            == set_record[PFS_SOURCE_SHA256],
        str(
            "Selected glyph does not belong to selected set: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        target_height > 0,
        "Portable section target height must be positive."
    );
    assert(
        depth > 0,
        "Portable section depth must be positive."
    );
    assert(
        in_list(
            grid_mode,
            VALID_PORTABLE_SECTION_GRID_MODES
        ),
        str(
            "Unknown portable section grid mode: ",
            grid_mode
        )
    );
    assert(
        is_num(origin_x) && is_num(origin_y),
        "Portable section origin must be numeric."
    );
    assert(
        cell_width > 0 && cell_height > 0,
        "Portable section cell dimensions must be positive."
    );
    assert(
        columns >= 1
        && floor(columns) == columns,
        "Portable resolved columns must be a positive integer."
    );
    assert(
        rows >= 1
        && floor(rows) == rows,
        "Portable resolved rows must be a positive integer."
    );
    assert(
        selected_column >= 0
        && selected_column < columns
        && floor(selected_column) == selected_column,
        str(
            "Portable selected column ",
            selected_column,
            " is outside [0, ",
            columns - 1,
            "]."
        )
    );
    assert(
        selected_row >= 0
        && selected_row < rows
        && floor(selected_row) == selected_row,
        str(
            "Portable selected row ",
            selected_row,
            " is outside [0, ",
            rows - 1,
            "]."
        )
    );
    assert(
        epsilon > 0 && epsilon <= 1,
        "Portable section epsilon must be in (0, 1]."
    );
    assert(
        layout_gap >= 0,
        "Portable section layout gap must be nonnegative."
    );
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
        grid_mode != "auto"
        || portable_generic_grid_covers_glyph(
            glyph,
            target_height,
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            columns,
            rows
        ),
        str(
            "Automatic portable grid failed to cover ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
}
