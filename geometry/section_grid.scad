//////////////////////////////////////////////////////////////////////
// LibFile: section_grid.scad
// Project: Glyph Dossier
// FileGroup: Section Geometry
// FileSummary: Rectangular clipping cells and preview grid.
//////////////////////////////////////////////////////////////////////

module section_cell_clip_3d(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row,
    depth,
    epsilon
) {
    translate([
        section_x0(origin_x, cell_width, column),
        section_y0(origin_y, cell_height, row),
        -epsilon
    ])
        cube([
            cell_width,
            cell_height,
            depth + 2 * epsilon
        ]);
}

module _vertical_grid_line_2d(
    x,
    y0,
    height,
    line_width
) {
    translate([x, y0 + height / 2])
        square([line_width, height], center = true);
}

module _horizontal_grid_line_2d(
    x0,
    y,
    width,
    line_width
) {
    translate([x0 + width / 2, y])
        square([width, line_width], center = true);
}

module section_grid_2d(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    line_width
) {
    total_width = section_plan_width(cell_width, columns);
    total_height = section_plan_height(cell_height, rows);

    union() {
        for (column = [0 : columns])
            _vertical_grid_line_2d(
                origin_x + column * cell_width,
                origin_y,
                total_height,
                line_width
            );

        for (row = [0 : rows])
            _horizontal_grid_line_2d(
                origin_x,
                origin_y + row * cell_height,
                total_width,
                line_width
            );
    }
}

module section_grid_3d(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    line_width,
    depth
) {
    linear_extrude(height = depth)
        section_grid_2d(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            columns,
            rows,
            line_width
        );
}
