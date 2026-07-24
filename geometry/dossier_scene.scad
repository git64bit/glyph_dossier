//////////////////////////////////////////////////////////////////////
// LibFile: dossier_scene.scad
// Project: Glyph Dossier
// FileGroup: Diagnostic Rendering
// FileSummary: Individual profile and guide-frame render modes.
//////////////////////////////////////////////////////////////////////

module render_glyph_dossier(
    dossier,
    render_mode,
    source_kind,
    font_name,
    nominal_size,
    extrusion_depth,
    guide_depth,
    show_guides,
    show_frame,
    x_height_ratio,
    cap_height_ratio,
    ascender_ratio,
    descender_ratio
) {
    if (render_mode == "profile_2d") {
        glyph_source_2d(
            dossier,
            source_kind,
            font_name,
            nominal_size
        );
    } else if (render_mode == "profile_3d") {
        glyph_profile_3d(
            dossier,
            source_kind,
            font_name,
            nominal_size,
            extrusion_depth
        );
    } else if (render_mode == "dossier") {
        if (show_guides)
            color([0.45, 0.55, 0.70, 0.45])
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
                glyph_profile_3d(
                    dossier,
                    source_kind,
                    font_name,
                    nominal_size,
                    extrusion_depth
                );
    }
}
