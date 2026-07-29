//////////////////////////////////////////////////////////////////////
// LibFile: portable_generic_section_scene.scad
// Project: Glyph Dossier
// FileGroup: Generic Portable Section Geometry
// FileSummary: Plan, exploded layout, and local cell export.
//////////////////////////////////////////////////////////////////////

module portable_generic_glyph_section_3d(
    glyph,
    target_height,
    depth,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    epsilon
) {
    intersection() {
        portable_glyph_3d(
            glyph,
            target_height,
            depth
        );

        section_cell_clip_3d(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row,
            depth,
            epsilon
        );
    }
}

module portable_generic_section_plan(
    glyph,
    target_height,
    depth,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    show_grid,
    show_bounds,
    grid_line_width,
    bounds_line_width
) {
    color([0.88, 0.68, 0.24])
        portable_glyph_3d(
            glyph,
            target_height,
            depth
        );

    if (show_grid)
        color([0.20, 0.45, 0.85, 0.65])
            translate([0, 0, depth + 0.3])
                section_grid_3d(
                    origin_x,
                    origin_y,
                    cell_width,
                    cell_height,
                    columns,
                    rows,
                    grid_line_width,
                    0.8
                );

    if (show_bounds)
        color([0.15, 0.70, 0.42, 0.60])
            translate([0, 0, depth + 1.3])
                linear_extrude(height = 0.8)
                    portable_normalized_bounds_frame_2d(
                        glyph,
                        target_height,
                        bounds_line_width
                    );
}

module portable_generic_section_layout(
    glyph,
    target_height,
    depth,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    epsilon,
    gap
) {
    for (row = [0 : rows - 1])
        for (column = [0 : columns - 1])
            translate([
                section_layout_x(
                    column,
                    cell_width,
                    gap
                )
                    - section_x0(
                        origin_x,
                        cell_width,
                        column
                    ),
                section_layout_y(
                    row,
                    cell_height,
                    gap
                )
                    - section_y0(
                        origin_y,
                        cell_height,
                        row
                    ),
                0
            ])
                color([0.88, 0.68, 0.24])
                    portable_generic_glyph_section_3d(
                        glyph,
                        target_height,
                        depth,
                        origin_x,
                        origin_y,
                        cell_width,
                        cell_height,
                        column,
                        row,
                        epsilon
                    );
}

module portable_generic_section_export(
    glyph,
    target_height,
    depth,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    epsilon
) {
    translate([
        -section_x0(
            origin_x,
            cell_width,
            column
        ),
        -section_y0(
            origin_y,
            cell_height,
            row
        ),
        0
    ])
        portable_generic_glyph_section_3d(
            glyph,
            target_height,
            depth,
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row,
            epsilon
        );
}
