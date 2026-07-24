//////////////////////////////////////////////////////////////////////
// LibFile: measurement_guides.scad
// Project: Glyph Dossier
// FileGroup: Manual Observation Geometry
// FileSummary: Bounds, stroke, and gap guides for explicit observation.
//////////////////////////////////////////////////////////////////////

module _thin_line_2d(length, thickness) {
    square([length, thickness], center = true);
}

module _manual_bounds_2d(observation, thickness) {
    width = observation_width(observation);
    height = observation_height(observation);
    center_x = (
        observation[OB_LEFT] + observation[OB_RIGHT]
    ) / 2;
    center_y = (
        observation[OB_BOTTOM] + observation[OB_TOP]
    ) / 2;

    translate([center_x, center_y])
        difference() {
            square([width, height], center = true);
            square(
                [
                    max(0.01, width - 2 * thickness),
                    max(0.01, height - 2 * thickness)
                ],
                center = true
            );
        }
}

module _stroke_probe_2d(
    minimum_stroke,
    probe_x,
    probe_y,
    orientation,
    probe_length
) {
    translate([probe_x, probe_y])
        if (orientation == "vertical")
            square(
                [minimum_stroke, probe_length],
                center = true
            );
        else
            square(
                [probe_length, minimum_stroke],
                center = true
            );
}

module _gap_probe_2d(
    minimum_gap,
    probe_x,
    probe_y,
    orientation,
    probe_length,
    thickness
) {
    if (orientation == "vertical") {
        translate([
            probe_x - minimum_gap / 2,
            probe_y
        ])
            rotate([0, 0, 90])
                _thin_line_2d(probe_length, thickness);
        translate([
            probe_x + minimum_gap / 2,
            probe_y
        ])
            rotate([0, 0, 90])
                _thin_line_2d(probe_length, thickness);
    } else {
        translate([
            probe_x,
            probe_y - minimum_gap / 2
        ])
            _thin_line_2d(probe_length, thickness);
        translate([
            probe_x,
            probe_y + minimum_gap / 2
        ])
            _thin_line_2d(probe_length, thickness);
    }
}

module manual_measurement_guides_3d(
    observation,
    depth,
    stroke_probe_x,
    stroke_probe_y,
    stroke_probe_orientation,
    stroke_probe_length,
    gap_probe_x,
    gap_probe_y,
    gap_probe_orientation,
    gap_probe_length
) {
    thickness = 0.6;

    if (observation_has_bounds(observation))
        color([0.90, 0.30, 0.20, 0.65])
            linear_extrude(height = depth)
                _manual_bounds_2d(
                    observation,
                    thickness
                );

    if (
        observation_value_known(observation[OB_MIN_STROKE])
        && observation[OB_MIN_STROKE] > 0
    )
        color([0.20, 0.70, 0.35, 0.55])
            linear_extrude(height = depth)
                _stroke_probe_2d(
                    observation[OB_MIN_STROKE],
                    stroke_probe_x,
                    stroke_probe_y,
                    stroke_probe_orientation,
                    stroke_probe_length
                );

    if (
        observation_value_known(observation[OB_MIN_GAP])
        && observation[OB_MIN_GAP] >= 0
    )
        color([0.68, 0.30, 0.86, 0.75])
            linear_extrude(height = depth)
                _gap_probe_2d(
                    observation[OB_MIN_GAP],
                    gap_probe_x,
                    gap_probe_y,
                    gap_probe_orientation,
                    gap_probe_length,
                    thickness
                );
}
