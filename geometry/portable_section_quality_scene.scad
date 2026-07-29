//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_quality_scene.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Quality Geometry
// FileSummary: Quality plan and review-only exploded layout.
//////////////////////////////////////////////////////////////////////

function portable_quality_overlay_color(record) =
    !record[PSQ_OCCUPIED]
    ? [0.45, 0.45, 0.45, 0.08]
    : record[PSQ_REVIEW]
    ? [0.90, 0.25, 0.15, 0.28]
    : [0.20, 0.75, 0.38, 0.18];

module portable_quality_cell_overlay(
    record,
    occupancy_record,
    depth,
    overlay_depth
) {
    bounds = occupancy_record[PSO_GLOBAL_BOUNDS];

    color(portable_quality_overlay_color(record))
        translate([
            bounds[0],
            bounds[2],
            depth + 0.2
        ])
            cube([
                bounds[1] - bounds[0],
                bounds[3] - bounds[2],
                overlay_depth
            ]);
}

module portable_section_quality_plan(
    glyph,
    target_height,
    depth,
    occupancy_records,
    quality_records,
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

    for (index = [0 : len(quality_records) - 1])
        if (
            quality_records[index][PSQ_OCCUPIED]
            || show_empty_cells
        )
            portable_quality_cell_overlay(
                quality_records[index],
                occupancy_records[index],
                depth,
                overlay_depth
            );

    color([0.20, 0.45, 0.85, 0.70])
        translate([
            0,
            0,
            depth + overlay_depth + 0.4
        ])
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

module portable_quality_review_layout(
    occupancy_records,
    quality_records,
    cell_width,
    cell_height,
    gap,
    depth
) {
    for (index = [0 : len(quality_records) - 1])
        if (quality_records[index][PSQ_REVIEW])
            let(
                quality = quality_records[index],
                occupancy = occupancy_records[index]
            )
            translate([
                section_layout_x(
                    quality[PSQ_COLUMN],
                    cell_width,
                    gap
                ) - occupancy[PSO_GLOBAL_BOUNDS][0],
                section_layout_y(
                    quality[PSQ_ROW],
                    cell_height,
                    gap
                ) - occupancy[PSO_GLOBAL_BOUNDS][2],
                0
            ])
                color([0.88, 0.68, 0.24])
                    linear_extrude(height = depth)
                        region(quality[PSQ_REGION]);
}
