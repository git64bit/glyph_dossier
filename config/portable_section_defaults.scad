//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_defaults.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Configuration
// FileSummary: Resolves portable A normalization and grid inputs.
//////////////////////////////////////////////////////////////////////

pg_section_origin_x = is_undef(portable_section_origin_x)
    ? -300 : portable_section_origin_x;
pg_section_origin_y = is_undef(portable_section_origin_y)
    ? 0 : portable_section_origin_y;
pg_section_cell_width = is_undef(portable_section_cell_width)
    ? 200 : portable_section_cell_width;
pg_section_cell_height = is_undef(portable_section_cell_height)
    ? 200 : portable_section_cell_height;
pg_section_columns = is_undef(portable_section_columns)
    ? 3 : portable_section_columns;
pg_section_rows = is_undef(portable_section_rows)
    ? 3 : portable_section_rows;
pg_selected_section_column =
    is_undef(portable_selected_section_column)
    ? 0 : portable_selected_section_column;
pg_selected_section_row =
    is_undef(portable_selected_section_row)
    ? 0 : portable_selected_section_row;
pg_section_epsilon = is_undef(portable_section_epsilon)
    ? 0.05 : portable_section_epsilon;
pg_section_layout_gap = is_undef(portable_section_layout_gap)
    ? 20 : portable_section_layout_gap;
pg_section_bed_x = is_undef(portable_section_bed_x)
    ? 220 : portable_section_bed_x;
pg_section_bed_y = is_undef(portable_section_bed_y)
    ? 220 : portable_section_bed_y;

pg_show_section_grid = is_undef(portable_show_section_grid)
    ? true : portable_show_section_grid;
pg_show_hazard_guides = is_undef(portable_show_hazard_guides)
    ? true : portable_show_hazard_guides;
pg_show_normalized_bounds =
    is_undef(portable_show_normalized_bounds)
    ? true : portable_show_normalized_bounds;

pg_section_grid_line_width =
    is_undef(portable_section_grid_line_width)
    ? 1.2 : portable_section_grid_line_width;
pg_hazard_line_width = is_undef(portable_hazard_line_width)
    ? 5 : portable_hazard_line_width;
pg_bounds_line_width = is_undef(portable_bounds_line_width)
    ? 1.5 : portable_bounds_line_width;

pg_a_apex_y_ratio = is_undef(portable_a_apex_y_ratio)
    ? 0.96 : portable_a_apex_y_ratio;
pg_a_counter_bottom_ratio =
    is_undef(portable_a_counter_bottom_ratio)
    ? 0.28 : portable_a_counter_bottom_ratio;
pg_a_counter_top_ratio =
    is_undef(portable_a_counter_top_ratio)
    ? 0.62 : portable_a_counter_top_ratio;
pg_a_crossbar_y_ratio =
    is_undef(portable_a_crossbar_y_ratio)
    ? 0.40 : portable_a_crossbar_y_ratio;
pg_a_counter_half_width_ratio =
    is_undef(portable_a_counter_half_width_ratio)
    ? 0.17 : portable_a_counter_half_width_ratio;
