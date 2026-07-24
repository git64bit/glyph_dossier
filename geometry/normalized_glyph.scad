//////////////////////////////////////////////////////////////////////
// LibFile: normalized_glyph.scad
// Project: Glyph Dossier
// FileGroup: Exact-Height Geometry
// FileSummary: Center-bottom glyph normalization by three methods.
//////////////////////////////////////////////////////////////////////

module _source_text_left_baseline_2d(
    dossier,
    source,
    probe_size
) {
    font_text_2d(
        dossier[GD_GLYPH],
        source[FS_FONT_NAME],
        probe_size,
        "left",
        "baseline"
    );
}

module _source_text_center_bottom_2d(
    dossier,
    source,
    probe_size
) {
    font_text_2d(
        dossier[GD_GLYPH],
        source[FS_FONT_NAME],
        probe_size,
        "center",
        "bottom"
    );
}

module _manual_normalized_glyph_2d(
    dossier,
    source,
    target_height,
    probe_size,
    left,
    right,
    bottom,
    top
) {
    scale_factor = exact_height_scale(
        target_height,
        bottom,
        top
    );

    translate([
        normalized_center_shift_x(
            left,
            right,
            scale_factor
        ),
        normalized_bottom_shift_y(
            bottom,
            scale_factor
        )
    ])
        scale([scale_factor, scale_factor])
            _source_text_left_baseline_2d(
                dossier,
                source,
                probe_size
            );
}

module _resize_normalized_glyph_2d(
    dossier,
    source,
    target_height,
    probe_size
) {
    resize(
        [0, target_height],
        auto = [true, false]
    )
        _source_text_center_bottom_2d(
            dossier,
            source,
            probe_size
        );
}

module _textmetrics_normalized_glyph_2d(
    dossier,
    source,
    target_height,
    probe_size
) {
    if (source[FS_FONT_NAME] == "")
        let(
            metrics = textmetrics(
                text = dossier[GD_GLYPH],
                size = probe_size,
                halign = "left",
                valign = "baseline"
            ),
            scale_factor =
                target_height / metrics.size.y,
            center_x =
                metrics.position.x
                + metrics.size.x / 2
        ) {
            echo("TEXTMETRICS_PROFILE", metrics);
            echo(
                "NORMALIZATION_SCALE",
                scale_factor
            );
            echo(
                "NORMALIZED_PROFILE_WIDTH_MM",
                metrics.size.x * scale_factor
            );
            echo(
                "NORMALIZED_PROFILE_HEIGHT_MM",
                target_height
            );

            translate([
                -center_x * scale_factor,
                -metrics.position.y * scale_factor
            ])
                scale([scale_factor, scale_factor])
                    _source_text_left_baseline_2d(
                        dossier,
                        source,
                        probe_size
                    );
        }
    else
        let(
            metrics = textmetrics(
                text = dossier[GD_GLYPH],
                size = probe_size,
                font = source[FS_FONT_NAME],
                halign = "left",
                valign = "baseline"
            ),
            scale_factor =
                target_height / metrics.size.y,
            center_x =
                metrics.position.x
                + metrics.size.x / 2
        ) {
            echo("TEXTMETRICS_PROFILE", metrics);
            echo(
                "NORMALIZATION_SCALE",
                scale_factor
            );
            echo(
                "NORMALIZED_PROFILE_WIDTH_MM",
                metrics.size.x * scale_factor
            );
            echo(
                "NORMALIZED_PROFILE_HEIGHT_MM",
                target_height
            );

            translate([
                -center_x * scale_factor,
                -metrics.position.y * scale_factor
            ])
                scale([scale_factor, scale_factor])
                    _source_text_left_baseline_2d(
                        dossier,
                        source,
                        probe_size
                    );
        }
}

module normalized_glyph_2d(
    dossier,
    source,
    method,
    target_height,
    probe_size,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top
) {
    if (method == "manual")
        _manual_normalized_glyph_2d(
            dossier,
            source,
            target_height,
            probe_size,
            manual_left,
            manual_right,
            manual_bottom,
            manual_top
        );
    else if (method == "textmetrics")
        _textmetrics_normalized_glyph_2d(
            dossier,
            source,
            target_height,
            probe_size
        );
    else
        _resize_normalized_glyph_2d(
            dossier,
            source,
            target_height,
            probe_size
        );
}

module normalized_glyph_3d(
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
) {
    linear_extrude(height = depth)
        normalized_glyph_2d(
            dossier,
            source,
            method,
            target_height,
            probe_size,
            manual_left,
            manual_right,
            manual_bottom,
            manual_top
        );
}
