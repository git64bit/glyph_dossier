//////////////////////////////////////////////////////////////////////
// LibFile: default.scad
// Project: Glyph Dossier
// FileGroup: Maintainer Workbench
// FileSummary: Broad mutable development entry point.
//////////////////////////////////////////////////////////////////////

workbench_name = "development";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
source_id_selected = "SRC_1";
render_mode = "a_section_plan";
report_level = "full";

source_1_label = "Source 1";
source_1_font_name = "";
source_1_license = "unrecorded";
source_1_url = "";
source_1_revision = "";

source_2_label = "Source 2";
source_2_font_name = "";
source_2_license = "unrecorded";
source_2_url = "";
source_2_revision = "";

source_3_label = "Source 3";
source_3_font_name = "";
source_3_license = "unrecorded";
source_3_url = "";
source_3_revision = "";

compare_source_1_id = "SRC_1";
compare_source_2_id = "SRC_2";
compare_source_3_id = "SRC_3";

observed_status = "pending";
observed_variant = "unobserved";
observed_components = -999999;
observed_counters = -999999;
observed_left_extent = -999999;
observed_right_extent = -999999;
observed_bottom_extent = -999999;
observed_top_extent = -999999;
observed_minimum_stroke = -999999;
observed_minimum_gap = -999999;
observation_note = "Awaiting source-specific inspection.";

stroke_probe_x = 0;
stroke_probe_y = 45;
stroke_probe_orientation = "vertical";
stroke_probe_length = 30;
gap_probe_x = 0;
gap_probe_y = 25;
gap_probe_orientation = "horizontal";
gap_probe_length = 30;

nominal_size = 600;
extrusion_depth = 6;
guide_depth = 0.8;
show_guides = false;
show_frame = false;
show_manual_guides = false;

x_height_ratio = 0.52;
cap_height_ratio = 0.72;
ascender_ratio = 0.78;
descender_ratio = 0.22;

sheet_columns = 5;
sheet_cell_size = 72;
sheet_glyph_size = 42;
sheet_depth = 2;

source_sample_size = 42;
source_sample_depth = 2;
source_sample_line_gap = 1.35;
comparison_spacing = 170;

section_origin_x = -300;
section_origin_y = -20;
section_cell_width = 200;
section_cell_height = 200;
section_columns = 3;
section_rows = 3;
selected_section_column = 0;
selected_section_row = 0;
section_epsilon = 0.05;
layout_gap = 20;
bed_x = 220;
bed_y = 220;

show_section_grid = true;
show_hazard_guides = true;
grid_line_width = 1.2;
hazard_line_width = 5;

a_apex_y_ratio = 0.72;
a_counter_bottom_ratio = 0.22;
a_counter_top_ratio = 0.55;
a_crossbar_y_ratio = 0.34;
a_counter_half_width_ratio = 0.17;

include <main.scad>
