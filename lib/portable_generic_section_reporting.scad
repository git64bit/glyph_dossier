//////////////////////////////////////////////////////////////////////
// LibFile: portable_generic_section_reporting.scad
// Project: Glyph Dossier
// FileGroup: Generic Portable Section Reporting
// FileSummary: Reports resolved plan, manifest, and selected export.
//////////////////////////////////////////////////////////////////////

module report_portable_generic_section_plan(
    set_record,
    glyph,
    target_height,
    grid_mode,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    bed_x,
    bed_y
) {
    echo(
        "PORTABLE_SECTION_SET_ID",
        set_record[PFS_ID]
    );
    echo(
        "PORTABLE_SECTION_GLYPH_ID",
        glyph[PG_ID]
    );
    echo(
        "PORTABLE_SECTION_CHARACTER",
        glyph[PG_CHARACTER]
    );
    echo(
        "PORTABLE_SECTION_GRID_MODE",
        grid_mode
    );
    echo(
        "PORTABLE_SECTION_TARGET_HEIGHT_MM",
        target_height
    );
    echo(
        "PORTABLE_SECTION_NORMALIZED_BOUNDS_MM",
        portable_normalized_bounds(
            glyph,
            target_height
        )
    );
    echo(
        "PORTABLE_SECTION_ORIGIN_MM",
        [origin_x, origin_y]
    );
    echo(
        "PORTABLE_SECTION_CELL_MM",
        [cell_width, cell_height]
    );
    echo(
        "PORTABLE_SECTION_GRID",
        [columns, rows]
    );
    echo(
        "PORTABLE_SECTION_COUNT",
        section_count(columns, rows)
    );
    echo(
        "PORTABLE_SECTION_PLAN_SIZE_MM",
        [
            section_plan_width(
                cell_width,
                columns
            ),
            section_plan_height(
                cell_height,
                rows
            )
        ]
    );
    echo(
        "PORTABLE_SECTION_BED_MM",
        [bed_x, bed_y]
    );
    echo(
        "PORTABLE_SECTION_GRID_COVERS_GLYPH",
        portable_generic_grid_covers_glyph(
            glyph,
            target_height,
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            columns,
            rows
        )
    );
    echo(
        "PORTABLE_SECTION_OCCUPANCY_STATUS",
        "Computed in Batch 011 occupancy modes; base manifest remains complete."
    );
}

module report_portable_generic_section_manifest(
    set_record,
    glyph,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows
) {
    echo(
        "PORTABLE_SECTION_MANIFEST_COUNT",
        section_count(columns, rows)
    );

    for (row = [0 : rows - 1])
        for (column = [0 : columns - 1])
            echo(
                "PORTABLE_SECTION_MANIFEST_ENTRY",
                [
                    portable_section_object_id(
                        set_record[PFS_ID],
                        glyph[PG_ID],
                        column,
                        row
                    ),
                    "section_id",
                    section_id(column, row),
                    "index",
                    [column, row],
                    "global_bounds",
                    portable_section_global_bounds(
                        origin_x,
                        origin_y,
                        cell_width,
                        cell_height,
                        column,
                        row
                    ),
                    "local_bounds",
                    portable_section_local_bounds(
                        cell_width,
                        cell_height
                    )
                ]
            );
}

module report_portable_generic_selected_section(
    set_record,
    glyph,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row
) {
    echo(
        "PORTABLE_SELECTED_SECTION_OBJECT_ID",
        portable_section_object_id(
            set_record[PFS_ID],
            glyph[PG_ID],
            column,
            row
        )
    );
    echo(
        "PORTABLE_SELECTED_SECTION_ID",
        section_id(column, row)
    );
    echo(
        "PORTABLE_SELECTED_SECTION_INDEX",
        [column, row]
    );
    echo(
        "PORTABLE_SELECTED_SECTION_GLOBAL_BOUNDS",
        portable_section_global_bounds(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row
        )
    );
    echo(
        "PORTABLE_SELECTED_SECTION_LOCAL_BOUNDS",
        portable_section_local_bounds(
            cell_width,
            cell_height
        )
    );
}
