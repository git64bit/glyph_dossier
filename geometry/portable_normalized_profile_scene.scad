//////////////////////////////////////////////////////////////////////
// LibFile: portable_normalized_profile_scene.scad
// Project: Glyph Dossier
// FileGroup: Portable Normalized Geometry
// FileSummary: Generic exact-height profile and visible bounds.
//////////////////////////////////////////////////////////////////////

module portable_normalized_bounds_frame_2d(
    glyph,
    target_height,
    line_width
) {
    width = portable_normalized_width(
        glyph,
        target_height
    );

    difference() {
        translate([0, target_height / 2])
            square(
                [width, target_height],
                center = true
            );

        translate([0, target_height / 2])
            square(
                [
                    max(
                        0.01,
                        width - 2 * line_width
                    ),
                    max(
                        0.01,
                        target_height - 2 * line_width
                    )
                ],
                center = true
            );
    }
}

module portable_generic_normalized_profile(
    glyph,
    target_height,
    depth,
    show_bounds,
    bounds_line_width
) {
    color([0.88, 0.68, 0.24])
        portable_glyph_3d(
            glyph,
            target_height,
            depth
        );

    if (show_bounds)
        color([0.15, 0.70, 0.42, 0.60])
            translate([0, 0, depth + 0.3])
                linear_extrude(height = 0.8)
                    portable_normalized_bounds_frame_2d(
                        glyph,
                        target_height,
                        bounds_line_width
                    );
}
