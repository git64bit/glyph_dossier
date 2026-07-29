//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_scene.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Geometry
// FileSummary: Active masks, blank states, and unsupported states.
//////////////////////////////////////////////////////////////////////

module segmented_template_frame_2d(
    template,
    line_width
) {
    width = template[ST_WIDTH];
    height = template[ST_HEIGHT];

    difference() {
        translate([0, (height - 8) / 2 - 8])
            square(
                [width, height],
                center = true
            );

        translate([0, (height - 8) / 2 - 8])
            square(
                [
                    max(0.01, width - 2 * line_width),
                    max(0.01, height - 2 * line_width)
                ],
                center = true
            );
    }
}

module segmented_unsupported_cross_2d(
    template,
    thickness
) {
    width = template[ST_WIDTH];
    height = template[ST_HEIGHT];
    usable_height = height - 20;

    translate([0, usable_height / 2 - 4])
        rotate(atan2(usable_height, width))
            square(
                [
                    sqrt(
                        width * width
                        + usable_height * usable_height
                    ),
                    thickness
                ],
                center = true
            );

    translate([0, usable_height / 2 - 4])
        rotate(-atan2(usable_height, width))
            square(
                [
                    sqrt(
                        width * width
                        + usable_height * usable_height
                    ),
                    thickness
                ],
                center = true
            );
}

module segmented_source_state_2d(
    source_set,
    mapping,
    show_inactive,
    show_frame,
    frame_line_width
) {
    template = source_set[SSS_TEMPLATE];
    elements = template[ST_ELEMENTS];

    if (show_inactive)
        for (element = elements)
            if (
                !in_list(
                    element[SE_ID],
                    mapping[SM_ACTIVE_SEGMENTS]
                )
            )
                color([0.35, 0.35, 0.35, 0.12])
                    polygon(element[SE_PATH]);

    if (segmented_mapping_is_visible(mapping))
        for (
            element =
                segmented_active_elements(
                    source_set,
                    mapping
                )
        )
            color([0.88, 0.68, 0.24])
                polygon(element[SE_PATH]);

    if (show_frame)
        color([0.20, 0.45, 0.85, 0.55])
            segmented_template_frame_2d(
                template,
                frame_line_width
            );

    if (segmented_mapping_is_unsupported(mapping))
        color([0.85, 0.20, 0.15, 0.50])
            segmented_unsupported_cross_2d(
                template,
                frame_line_width * 2
            );
}

module segmented_source_state_3d(
    source_set,
    mapping,
    depth,
    show_inactive,
    show_frame,
    frame_line_width
) {
    linear_extrude(height = depth)
        segmented_source_state_2d(
            source_set,
            mapping,
            show_inactive,
            show_frame,
            frame_line_width
        );
}

module segmented_contact_sheet(
    source_set,
    columns,
    cell_width,
    cell_height,
    depth,
    frame_line_width,
    show_unsupported
) {
    mappings = source_set[SSS_MAPPINGS];
    template = source_set[SSS_TEMPLATE];
    scale_factor =
        min(
            (cell_width - 20) / template[ST_WIDTH],
            (cell_height - 20) / template[ST_HEIGHT]
        );

    for (index = [0 : len(mappings) - 1]) {
        mapping = mappings[index];
        column = index % columns;
        row = floor(index / columns);

        if (
            show_unsupported
            || !segmented_mapping_is_unsupported(
                mapping
            )
        )
            translate([
                column * cell_width,
                -row * cell_height,
                0
            ])
                scale([
                    scale_factor,
                    scale_factor,
                    1
                ])
                    segmented_source_state_3d(
                        source_set,
                        mapping,
                        depth,
                        false,
                        true,
                        frame_line_width
                    );
    }
}
