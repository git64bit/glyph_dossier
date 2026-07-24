//////////////////////////////////////////////////////////////////////
// LibFile: a_hazard_map.scad
// Project: Glyph Dossier
// FileGroup: Character-Specific Analysis
// FileSummary: Nominal uppercase-A apex, counter, and crossbar guides.
//////////////////////////////////////////////////////////////////////

module _hazard_horizontal_line_2d(
    y,
    half_width,
    line_width
) {
    translate([0, y])
        square(
            [2 * half_width, line_width],
            center = true
        );
}

module _hazard_vertical_line_2d(
    x,
    y0,
    y1,
    line_width
) {
    translate([x, (y0 + y1) / 2])
        square(
            [line_width, y1 - y0],
            center = true
        );
}

module a_hazard_guides_2d(
    nominal_size,
    apex_y_ratio,
    counter_bottom_ratio,
    counter_top_ratio,
    crossbar_y_ratio,
    counter_half_width_ratio,
    line_width
) {
    apex_y = nominal_size * apex_y_ratio;
    counter_bottom = nominal_size * counter_bottom_ratio;
    counter_top = nominal_size * counter_top_ratio;
    crossbar_y = nominal_size * crossbar_y_ratio;
    counter_half_width =
        nominal_size * counter_half_width_ratio;
    apex_half_width = nominal_size * 0.10;
    crossbar_half_width = nominal_size * 0.34;

    union() {
        _hazard_horizontal_line_2d(
            apex_y,
            apex_half_width,
            line_width
        );

        _hazard_horizontal_line_2d(
            counter_bottom,
            counter_half_width,
            line_width
        );

        _hazard_horizontal_line_2d(
            counter_top,
            counter_half_width,
            line_width
        );

        _hazard_vertical_line_2d(
            -counter_half_width,
            counter_bottom,
            counter_top,
            line_width
        );

        _hazard_vertical_line_2d(
            counter_half_width,
            counter_bottom,
            counter_top,
            line_width
        );

        _hazard_horizontal_line_2d(
            crossbar_y,
            crossbar_half_width,
            line_width
        );
    }
}

module a_hazard_guides_3d(
    nominal_size,
    apex_y_ratio,
    counter_bottom_ratio,
    counter_top_ratio,
    crossbar_y_ratio,
    counter_half_width_ratio,
    line_width,
    depth
) {
    linear_extrude(height = depth)
        a_hazard_guides_2d(
            nominal_size,
            apex_y_ratio,
            counter_bottom_ratio,
            counter_top_ratio,
            crossbar_y_ratio,
            counter_half_width_ratio,
            line_width
        );
}
