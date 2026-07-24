//////////////////////////////////////////////////////////////////////
// LibFile: normalized_profile_scene.scad
// Project: Glyph Dossier
// FileGroup: Exact-Height Diagnostic Rendering
// FileSummary: Whole normalized A with target-height reference bounds.
//////////////////////////////////////////////////////////////////////

module normalized_reference_bounds_2d(
    target_height,
    reference_half_width,
    line_width
) {
    difference() {
        translate([0, target_height / 2])
            square(
                [
                    2 * reference_half_width,
                    target_height
                ],
                center = true
            );

        translate([0, target_height / 2])
            square(
                [
                    max(
                        0.01,
                        2 * reference_half_width
                            - 2 * line_width
                    ),
                    max(
                        0.01,
                        target_height
                            - 2 * line_width
                    )
                ],
                center = true
            );
    }
}

module render_normalized_profile(
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
    show_bounds,
    bounds_line_width,
    reference_half_width
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

    if (show_bounds)
        color([0.20, 0.45, 0.85, 0.55])
            translate([0, 0, depth + 0.3])
                linear_extrude(height = 0.8)
                    normalized_reference_bounds_2d(
                        target_height,
                        reference_half_width,
                        bounds_line_width
                    );
}
