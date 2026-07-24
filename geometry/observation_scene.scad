//////////////////////////////////////////////////////////////////////
// LibFile: observation_scene.scad
// Project: Glyph Dossier
// FileGroup: Diagnostic Rendering
// FileSummary: Source glyph with nominal and manually entered guides.
//////////////////////////////////////////////////////////////////////

module render_observation_scene(
    dossier,
    source,
    observation,
    nominal_size,
    extrusion_depth,
    guide_depth,
    show_guides,
    show_frame,
    show_manual_guides,
    x_height_ratio,
    cap_height_ratio,
    ascender_ratio,
    descender_ratio,
    stroke_probe_x,
    stroke_probe_y,
    stroke_probe_orientation,
    stroke_probe_length,
    gap_probe_x,
    gap_probe_y,
    gap_probe_orientation,
    gap_probe_length
) {
    if (show_guides)
        color([0.45, 0.55, 0.70, 0.40])
            nominal_guides_3d(
                nominal_size,
                guide_depth,
                x_height_ratio,
                cap_height_ratio,
                ascender_ratio,
                descender_ratio,
                show_frame
            );

    color([0.88, 0.68, 0.24])
        translate([0, 0, guide_depth + 0.2])
            glyph_source_record_3d(
                dossier,
                source,
                nominal_size,
                extrusion_depth
            );

    if (show_manual_guides)
        translate([
            0,
            0,
            guide_depth + extrusion_depth + 0.4
        ])
            manual_measurement_guides_3d(
                observation,
                guide_depth,
                stroke_probe_x,
                stroke_probe_y,
                stroke_probe_orientation,
                stroke_probe_length,
                gap_probe_x,
                gap_probe_y,
                gap_probe_orientation,
                gap_probe_length
            );
}
