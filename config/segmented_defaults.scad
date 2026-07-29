//////////////////////////////////////////////////////////////////////
// LibFile: segmented_defaults.scad
// Project: Glyph Dossier
// FileGroup: Segmented Workbench Configuration
// FileSummary: Resolves source, mapping, and pipeline controls.
//////////////////////////////////////////////////////////////////////

sg_set_id = is_undef(segmented_set_id_selected)
    ? "PROCEDURAL_14_SEGMENT_EXTENDED_R1"
    : segmented_set_id_selected;
sg_glyph_id = is_undef(segmented_glyph_id_selected)
    ? "D_8"
    : segmented_glyph_id_selected;
sg_render_mode = is_undef(segmented_render_mode)
    ? "source_state"
    : segmented_render_mode;

sg_target_height = is_undef(segmented_target_height)
    ? 600
    : segmented_target_height;
sg_depth = is_undef(segmented_extrusion_depth)
    ? 6
    : segmented_extrusion_depth;
sg_show_inactive = is_undef(segmented_show_inactive)
    ? true
    : segmented_show_inactive;
sg_show_frame = is_undef(segmented_show_frame)
    ? true
    : segmented_show_frame;
sg_frame_line_width =
    is_undef(segmented_frame_line_width)
    ? 1.5
    : segmented_frame_line_width;

sg_cell_width = is_undef(segmented_section_cell_width)
    ? 200
    : segmented_section_cell_width;
sg_cell_height = is_undef(segmented_section_cell_height)
    ? 200
    : segmented_section_cell_height;
sg_grid_line_width =
    is_undef(segmented_grid_line_width)
    ? 1.2
    : segmented_grid_line_width;
sg_occupancy_area_epsilon =
    is_undef(segmented_occupancy_area_epsilon)
    ? 0.000001
    : segmented_occupancy_area_epsilon;
sg_boolean_epsilon =
    is_undef(segmented_boolean_epsilon)
    ? 0.000000001
    : segmented_boolean_epsilon;
sg_overlay_depth = is_undef(segmented_overlay_depth)
    ? 0.5
    : segmented_overlay_depth;

sg_contact_columns = is_undef(segmented_contact_columns)
    ? 11
    : segmented_contact_columns;
sg_contact_cell_width =
    is_undef(segmented_contact_cell_width)
    ? 130
    : segmented_contact_cell_width;
sg_contact_cell_height =
    is_undef(segmented_contact_cell_height)
    ? 220
    : segmented_contact_cell_height;
sg_contact_show_unsupported =
    is_undef(segmented_contact_show_unsupported)
    ? true
    : segmented_contact_show_unsupported;

VALID_SEGMENTED_RENDER_MODES = [
    "source_state",
    "normalized_profile",
    "section_plan",
    "occupancy_plan",
    "contact_sheet",
    "report_only"
];

module validate_segmented_controls() {
    assert(
        in_list(
            sg_render_mode,
            VALID_SEGMENTED_RENDER_MODES
        ),
        str(
            "Unknown segmented render mode: ",
            sg_render_mode
        )
    );
    assert(
        sg_target_height > 0,
        "Segmented target height must be positive."
    );
    assert(
        sg_depth > 0,
        "Segmented extrusion depth must be positive."
    );
    assert(
        sg_frame_line_width > 0,
        "Segmented frame line width must be positive."
    );
    assert(
        sg_cell_width > 0 && sg_cell_height > 0,
        "Segmented section cell dimensions must be positive."
    );
    assert(
        sg_grid_line_width > 0,
        "Segmented grid line width must be positive."
    );
    assert(
        sg_occupancy_area_epsilon > 0
        && sg_boolean_epsilon > 0,
        "Segmented occupancy tolerances must be positive."
    );
    assert(
        sg_contact_columns >= 1
        && floor(sg_contact_columns)
            == sg_contact_columns,
        "Segmented contact columns must be a positive integer."
    );
    assert(
        sg_contact_cell_width > 0
        && sg_contact_cell_height > 0,
        "Segmented contact cell dimensions must be positive."
    );
}
