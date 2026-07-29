//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_occupancy_scene.scad
// Project: Glyph Dossier
// FileGroup: Portable Occupancy Geometry
// FileSummary: Occupancy plan, occupied layout, and local export.
//////////////////////////////////////////////////////////////////////

module portable_occupancy_cell_overlay(
    record,
    depth,
    overlay_depth
) {
    bounds = record[PSO_GLOBAL_BOUNDS];
    width = bounds[1] - bounds[0];
    height = bounds[3] - bounds[2];

    color(
        record[PSO_OCCUPIED]
        ? [0.20, 0.75, 0.38, 0.22]
        : [0.45, 0.45, 0.45, 0.10]
    )
        translate([
            bounds[0],
            bounds[2],
            depth + 0.2
        ])
            cube([
                width,
                height,
                overlay_depth
            ]);
}

module portable_section_occupancy_plan(
    glyph,
    target_height,
    depth,
    records,
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    grid_line_width,
    overlay_depth,
    show_empty_cells
) {
    color([0.88, 0.68, 0.24])
        portable_glyph_3d(
            glyph,
            target_height,
            depth
        );

    for (record = records)
        if (
            record[PSO_OCCUPIED]
            || show_empty_cells
        )
            portable_occupancy_cell_overlay(
                record,
                depth,
                overlay_depth
            );

    color([0.20, 0.45, 0.85, 0.70])
        translate([0, 0, depth + overlay_depth + 0.4])
            section_grid_3d(
                origin_x,
                origin_y,
                cell_width,
                cell_height,
                columns,
                rows,
                grid_line_width,
                0.7
            );
}

module portable_occupied_section_layout(
    records,
    cell_width,
    cell_height,
    gap,
    depth
) {
    for (
        record =
            portable_occupied_section_records(records)
    )
        translate([
            section_layout_x(
                record[PSO_COLUMN],
                cell_width,
                gap
            ) - record[PSO_GLOBAL_BOUNDS][0],
            section_layout_y(
                record[PSO_ROW],
                cell_height,
                gap
            ) - record[PSO_GLOBAL_BOUNDS][2],
            0
        ])
            color([0.88, 0.68, 0.24])
                linear_extrude(height = depth)
                    region(record[PSO_REGION]);
}

module portable_occupancy_record_export(
    record,
    depth
) {
    if (record[PSO_OCCUPIED])
        translate([
            -record[PSO_GLOBAL_BOUNDS][0],
            -record[PSO_GLOBAL_BOUNDS][2],
            0
        ])
            linear_extrude(height = depth)
                region(record[PSO_REGION]);
}
