//////////////////////////////////////////////////////////////////////
// LibFile: portable_generic_section_defaults.scad
// Project: Glyph Dossier
// FileGroup: Generic Portable Section Configuration
// FileSummary: Resolves set, glyph, grid, layout, and export controls.
//////////////////////////////////////////////////////////////////////

ps_set_id = is_undef(portable_set_id_selected)
    ? "LIBERATION_SANS_REGULAR_R1"
    : portable_set_id_selected;
ps_glyph_id = is_undef(portable_glyph_id_selected)
    ? "U_A"
    : portable_glyph_id_selected;
ps_render_mode = is_undef(portable_render_mode)
    ? "section_plan"
    : portable_render_mode;

ps_target_height = is_undef(portable_target_height)
    ? 600
    : portable_target_height;
ps_depth = is_undef(portable_extrusion_depth)
    ? 6
    : portable_extrusion_depth;

ps_grid_mode = is_undef(portable_section_grid_mode)
    ? "auto"
    : portable_section_grid_mode;
ps_cell_width = is_undef(portable_section_cell_width)
    ? 200
    : portable_section_cell_width;
ps_cell_height = is_undef(portable_section_cell_height)
    ? 200
    : portable_section_cell_height;

ps_manual_origin_x = is_undef(portable_section_origin_x)
    ? -300
    : portable_section_origin_x;
ps_manual_origin_y = is_undef(portable_section_origin_y)
    ? 0
    : portable_section_origin_y;
ps_manual_columns = is_undef(portable_section_columns)
    ? 3
    : portable_section_columns;
ps_manual_rows = is_undef(portable_section_rows)
    ? 3
    : portable_section_rows;

ps_selected_column =
    is_undef(portable_selected_section_column)
    ? 0
    : portable_selected_section_column;
ps_selected_row =
    is_undef(portable_selected_section_row)
    ? 0
    : portable_selected_section_row;

ps_epsilon = is_undef(portable_section_epsilon)
    ? 0.05
    : portable_section_epsilon;
ps_layout_gap = is_undef(portable_section_layout_gap)
    ? 20
    : portable_section_layout_gap;
ps_bed_x = is_undef(portable_section_bed_x)
    ? 220
    : portable_section_bed_x;
ps_bed_y = is_undef(portable_section_bed_y)
    ? 220
    : portable_section_bed_y;

ps_show_grid = is_undef(portable_show_section_grid)
    ? true
    : portable_show_section_grid;
ps_show_bounds = is_undef(portable_show_normalized_bounds)
    ? true
    : portable_show_normalized_bounds;
ps_grid_line_width =
    is_undef(portable_section_grid_line_width)
    ? 1.2
    : portable_section_grid_line_width;
ps_bounds_line_width =
    is_undef(portable_bounds_line_width)
    ? 1.5
    : portable_bounds_line_width;

ps_occupancy_area_epsilon =
    is_undef(portable_occupancy_area_epsilon)
    ? 0.000001
    : portable_occupancy_area_epsilon;
ps_occupancy_boolean_epsilon =
    is_undef(portable_occupancy_boolean_epsilon)
    ? 0.000000001
    : portable_occupancy_boolean_epsilon;
ps_occupancy_overlay_depth =
    is_undef(portable_occupancy_overlay_depth)
    ? 0.5
    : portable_occupancy_overlay_depth;
ps_show_empty_occupancy_cells =
    is_undef(portable_show_empty_occupancy_cells)
    ? true
    : portable_show_empty_occupancy_cells;
ps_selected_occupied_ordinal =
    is_undef(portable_selected_occupied_ordinal)
    ? 0
    : portable_selected_occupied_ordinal;

ps_quality_small_component_area =
    is_undef(portable_quality_small_component_area)
    ? 100
    : portable_quality_small_component_area;
ps_quality_thin_component_estimate =
    is_undef(portable_quality_thin_component_estimate)
    ? 5
    : portable_quality_thin_component_estimate;
ps_quality_vertex_cut_distance =
    is_undef(portable_quality_vertex_cut_distance)
    ? 5
    : portable_quality_vertex_cut_distance;
ps_quality_short_seam_length =
    is_undef(portable_quality_short_seam_length)
    ? 15
    : portable_quality_short_seam_length;
ps_quality_counter_segment_count =
    is_undef(portable_quality_counter_segment_count)
    ? 2
    : portable_quality_counter_segment_count;
ps_quality_boundary_tolerance =
    is_undef(portable_quality_boundary_tolerance)
    ? 0.000001
    : portable_quality_boundary_tolerance;
ps_quality_overlay_depth =
    is_undef(portable_quality_overlay_depth)
    ? 0.6
    : portable_quality_overlay_depth;
ps_show_empty_quality_cells =
    is_undef(portable_show_empty_quality_cells)
    ? true
    : portable_show_empty_quality_cells;

VALID_PORTABLE_GENERIC_SECTION_MODES = [
    "section_plan",
    "section_layout",
    "section_export",
    "occupancy_plan",
    "occupied_layout",
    "occupied_export",
    "occupancy_report",
    "quality_plan",
    "quality_review_layout",
    "quality_report",
    "report_only"
];

VALID_PORTABLE_SECTION_GRID_MODES = [
    "auto",
    "manual"
];

module validate_portable_generic_section_controls() {
    assert(
        in_list(
            ps_render_mode,
            VALID_PORTABLE_GENERIC_SECTION_MODES
        ),
        str(
            "Unknown portable section render mode: ",
            ps_render_mode
        )
    );
    assert(
        in_list(
            ps_grid_mode,
            VALID_PORTABLE_SECTION_GRID_MODES
        ),
        str(
            "Unknown portable section grid mode: ",
            ps_grid_mode
        )
    );
    assert(
        ps_target_height > 0,
        "Portable section target height must be positive."
    );
    assert(
        ps_depth > 0,
        "Portable section depth must be positive."
    );
    assert(
        ps_cell_width > 0,
        "Portable section cell width must be positive."
    );
    assert(
        ps_cell_height > 0,
        "Portable section cell height must be positive."
    );
    assert(
        ps_epsilon > 0 && ps_epsilon <= 1,
        "Portable section epsilon must be in (0, 1]."
    );
    assert(
        ps_layout_gap >= 0,
        "Portable section layout gap must be nonnegative."
    );
    assert(
        ps_bed_x > 0 && ps_bed_y > 0,
        "Portable configured bed dimensions must be positive."
    );
    assert(
        ps_grid_line_width > 0,
        "Portable section grid line width must be positive."
    );
    assert(
        ps_bounds_line_width > 0,
        "Portable section bounds line width must be positive."
    );
    assert(
        ps_occupancy_area_epsilon >= 0,
        "Portable occupancy area epsilon must be nonnegative."
    );
    assert(
        ps_occupancy_boolean_epsilon > 0,
        "Portable occupancy Boolean epsilon must be positive."
    );
    assert(
        ps_occupancy_overlay_depth > 0,
        "Portable occupancy overlay depth must be positive."
    );
    assert(
        ps_quality_small_component_area >= 0,
        "Quality small-component area must be nonnegative."
    );
    assert(
        ps_quality_thin_component_estimate >= 0,
        "Quality thickness estimate must be nonnegative."
    );
    assert(
        ps_quality_vertex_cut_distance >= 0,
        "Quality vertex distance must be nonnegative."
    );
    assert(
        ps_quality_short_seam_length >= 0,
        "Quality short-seam length must be nonnegative."
    );
    assert(
        ps_quality_counter_segment_count >= 2
        && floor(ps_quality_counter_segment_count)
            == ps_quality_counter_segment_count,
        "Quality counter segment count must be an integer of at least two."
    );
    assert(
        ps_quality_boundary_tolerance > 0,
        "Quality boundary tolerance must be positive."
    );
    assert(
        ps_quality_overlay_depth > 0,
        "Quality overlay depth must be positive."
    );
    assert(
        ps_selected_occupied_ordinal >= 0
        && floor(ps_selected_occupied_ordinal)
            == ps_selected_occupied_ordinal,
        "Portable occupied ordinal must be a nonnegative integer."
    );
}
