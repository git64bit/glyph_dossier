//////////////////////////////////////////////////////////////////////
// LibFile: portable_a_section_layout.scad
// Project: Glyph Dossier
// FileGroup: Executable Portable Workbench
// FileSummary: Exploded layout of all portable U_A grid cells.
//////////////////////////////////////////////////////////////////////

/* [Portable glyph] */
portable_glyph_id_selected = "U_A";

/* [Exact assembled geometry] */
portable_target_height = 600;
portable_extrusion_depth = 6;

/* [Section grid] */
portable_section_origin_x = -300;
portable_section_origin_y = 0;
portable_section_cell_width = 200;
portable_section_cell_height = 200;
portable_section_columns = 3;
portable_section_rows = 3;
portable_section_epsilon = 0.05;
portable_section_bed_x = 220;
portable_section_bed_y = 220;

/* [Plan appearance] */
portable_show_section_grid = true;
portable_show_hazard_guides = true;
portable_show_normalized_bounds = true;
portable_section_grid_line_width = 1.2;
portable_hazard_line_width = 5;
portable_bounds_line_width = 1.5;

/* [A-specific guides] */
portable_a_apex_y_ratio = 0.96;
portable_a_counter_bottom_ratio = 0.28;
portable_a_counter_top_ratio = 0.62;
portable_a_crossbar_y_ratio = 0.40;
portable_a_counter_half_width_ratio = 0.17;


/* [Exploded layout] */
portable_section_layout_gap = 20;

/* [Hidden] */
portable_render_mode = "a_section_layout";
portable_selected_section_column = 0;
portable_selected_section_row = 0;

include <../portable_main.scad>
