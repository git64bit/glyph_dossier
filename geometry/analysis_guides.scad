//////////////////////////////////////////////////////////////////////
// LibFile: analysis_guides.scad
// Project: Glyph Dossier
// FileGroup: Diagnostic Geometry
// FileSummary: Nominal, non-measured baseline and height guides.
//////////////////////////////////////////////////////////////////////

module _guide_line_2d(width, thickness, y) {
    translate([0, y])
        square([width, thickness], center = true);
}

module nominal_guides_2d(
    nominal_size,
    x_height_ratio,
    cap_height_ratio,
    ascender_ratio,
    descender_ratio,
    show_frame = true
) {
    guide_width = nominal_size * 1.45;
    thickness = max(0.35, nominal_size * 0.004);
    lower = -nominal_size * descender_ratio;
    upper = nominal_size * ascender_ratio;

    union() {
        _guide_line_2d(guide_width, thickness, 0);
        _guide_line_2d(
            guide_width,
            thickness,
            nominal_size * x_height_ratio
        );
        _guide_line_2d(
            guide_width,
            thickness,
            nominal_size * cap_height_ratio
        );
        _guide_line_2d(guide_width, thickness, upper);
        _guide_line_2d(guide_width, thickness, lower);

        if (show_frame)
            difference() {
                translate([0, (upper + lower) / 2])
                    square(
                        [guide_width, upper - lower],
                        center = true
                    );
                translate([0, (upper + lower) / 2])
                    square(
                        [
                            guide_width - 2 * thickness,
                            upper - lower - 2 * thickness
                        ],
                        center = true
                    );
            }
    }
}

module nominal_guides_3d(
    nominal_size,
    depth,
    x_height_ratio,
    cap_height_ratio,
    ascender_ratio,
    descender_ratio,
    show_frame = true
) {
    linear_extrude(height = depth)
        nominal_guides_2d(
            nominal_size,
            x_height_ratio,
            cap_height_ratio,
            ascender_ratio,
            descender_ratio,
            show_frame
        );
}
