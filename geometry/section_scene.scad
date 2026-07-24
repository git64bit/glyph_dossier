//////////////////////////////////////////////////////////////////////
// LibFile: section_scene.scad
// Project: Glyph Dossier
// FileGroup: Section Rendering
// FileSummary: Normalized uppercase-A plan, layout, and export.
//////////////////////////////////////////////////////////////////////

module normalized_glyph_section_3d(
    dossier,
    source,
    method,
    target_height,
    probe_size,
    depth,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    epsilon
) {
    intersection() {
        normalized_glyph_3d(
            dossier,
            source,
            method,
            target_height,
            probe_size,
            depth,
            manual_left,
            manual_right,
            manual_bottom,
            manual_top
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

module render_a_section_plan(
    dossier,
    source,
    method,
    target_height,
    probe_size,
    depth,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    show_grid,
    show_hazards,
    show_bounds,
    grid_line_width,
    hazard_line_width,
    bounds_line_width,
    apex_y_ratio,
    counter_bottom_ratio,
    counter_top_ratio,
    crossbar_y_ratio,
    counter_half_width_ratio
) {
    color([0.88, 0.68, 0.24])
        normalized_glyph_3d(
            dossier,
            source,
            method,
            target_height,
            probe_size,
            depth,
            manual_left,
            manual_right,
            manual_bottom,
            manual_top
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
        color([0.15, 0.70, 0.42, 0.55])
            translate([0, 0, depth + 1.3])
                linear_extrude(height = 0.8)
                    normalized_reference_bounds_2d(
                        target_height,
                        section_plan_width(
                            cell_width,
                            columns
                        ) / 2,
                        bounds_line_width
                    );

    if (show_hazards)
        color([0.88, 0.22, 0.18, 0.70])
            translate([0, 0, depth + 2.3])
                a_hazard_guides_3d(
                    target_height,
                    apex_y_ratio,
                    counter_bottom_ratio,
                    counter_top_ratio,
                    crossbar_y_ratio,
                    counter_half_width_ratio,
                    hazard_line_width,
                    0.8
                );
}

module render_a_section_layout(
    dossier,
    source,
    method,
    target_height,
    probe_size,
    depth,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top,
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
                    normalized_glyph_section_3d(
                        dossier,
                        source,
                        method,
                        target_height,
                        probe_size,
                        depth,
                        manual_left,
                        manual_right,
                        manual_bottom,
                        manual_top,
                        origin_x,
                        origin_y,
                        cell_width,
                        cell_height,
                        column,
                        row,
                        epsilon
                    );
}

module render_a_section_export(
    dossier,
    source,
    method,
    target_height,
    probe_size,
    depth,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top,
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
        normalized_glyph_section_3d(
            dossier,
            source,
            method,
            target_height,
            probe_size,
            depth,
            manual_left,
            manual_right,
            manual_bottom,
            manual_top,
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            column,
            row,
            epsilon
        );
}
