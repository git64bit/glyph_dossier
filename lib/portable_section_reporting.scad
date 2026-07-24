//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_reporting.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Reporting
// FileSummary: Exact normalization, grid, and manifest console output.
//////////////////////////////////////////////////////////////////////

module report_portable_normalization(
    glyph,
    target_height
) {
    echo(
        "PORTABLE_NORMALIZATION_SOURCE_BOUNDS",
        glyph[PG_REGION_BOUNDS]
    );
    echo(
        "PORTABLE_NORMALIZATION_SCALE",
        portable_target_scale(glyph, target_height)
    );
    echo(
        "PORTABLE_NORMALIZED_BOUNDS_MM",
        portable_normalized_bounds(glyph, target_height)
    );
    echo(
        "PORTABLE_NORMALIZED_WIDTH_MM",
        portable_normalized_width(glyph, target_height)
    );
    echo(
        "PORTABLE_NORMALIZED_HEIGHT_MM",
        portable_normalized_height(glyph, target_height)
    );
    echo(
        "PORTABLE_NORMALIZED_ANCHOR",
        "center-bottom"
    );
    echo(
        "PORTABLE_NORMALIZATION_TEXT_CALL",
        false
    );
}

module report_portable_section_plan(
    glyph,
    target_height,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    bed_x,
    bed_y
) {
    echo("PORTABLE_SECTION_ORIGIN_MM", [
        origin_x,
        origin_y
    ]);
    echo("PORTABLE_SECTION_CELL_MM", [
        cell_width,
        cell_height
    ]);
    echo("PORTABLE_SECTION_GRID", [
        columns,
        rows
    ]);
    echo(
        "PORTABLE_SECTION_COUNT",
        section_count(columns, rows)
    );
    echo("PORTABLE_SECTION_PLAN_SIZE_MM", [
        section_plan_width(cell_width, columns),
        section_plan_height(cell_height, rows)
    ]);
    echo("PORTABLE_SECTION_BED_MM", [
        bed_x,
        bed_y
    ]);
    echo(
        "PORTABLE_SECTION_GRID_COVERS_GLYPH",
        portable_grid_covers_glyph(
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
        "Not computed in Batch 006; empty intersections render no geometry."
    );
}

module report_portable_section_manifest(
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
            echo("PORTABLE_SECTION_MANIFEST_ENTRY", [
                section_id(column, row),
                "index", [column, row],
                "global_bounds", [
                    section_x0(
                        origin_x,
                        cell_width,
                        column
                    ),
                    section_x1(
                        origin_x,
                        cell_width,
                        column
                    ),
                    section_y0(
                        origin_y,
                        cell_height,
                        row
                    ),
                    section_y1(
                        origin_y,
                        cell_height,
                        row
                    )
                ],
                "local_bounds", [
                    0,
                    cell_width,
                    0,
                    cell_height
                ]
            ]);
}

module report_portable_selected_section(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row
) {
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
        [
            section_x0(
                origin_x,
                cell_width,
                column
            ),
            section_x1(
                origin_x,
                cell_width,
                column
            ),
            section_y0(
                origin_y,
                cell_height,
                row
            ),
            section_y1(
                origin_y,
                cell_height,
                row
            )
        ]
    );
    echo(
        "PORTABLE_SELECTED_SECTION_LOCAL_BOUNDS",
        [0, cell_width, 0, cell_height]
    );
}
