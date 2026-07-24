//////////////////////////////////////////////////////////////////////
// LibFile: portable_a_normalized_profile.scad
// Project: Glyph Dossier
// FileGroup: Executable Portable Workbench
// FileSummary: Captured U_A normalized to an exact physical height.
//////////////////////////////////////////////////////////////////////

portable_glyph_id_selected = "U_A";
portable_render_mode = "a_normalized_profile";
portable_target_height = 600;
portable_extrusion_depth = 6;
portable_show_normalized_bounds = true;
portable_bounds_line_width = 1.5;

/* [Hidden grid validation values] */
portable_section_origin_x = -300;
portable_section_origin_y = 0;
portable_section_cell_width = 200;
portable_section_cell_height = 200;
portable_section_columns = 3;
portable_section_rows = 3;
portable_selected_section_column = 0;
portable_selected_section_row = 0;
portable_section_epsilon = 0.05;
portable_section_layout_gap = 20;
portable_section_bed_x = 220;
portable_section_bed_y = 220;
portable_a_apex_y_ratio = 0.96;
portable_a_counter_bottom_ratio = 0.28;
portable_a_counter_top_ratio = 0.62;
portable_a_crossbar_y_ratio = 0.40;
portable_a_counter_half_width_ratio = 0.17;

include <../portable_main.scad>
