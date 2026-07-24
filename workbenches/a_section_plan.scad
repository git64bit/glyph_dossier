//////////////////////////////////////////////////////////////////////
// LibFile: a_section_plan.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Exact-height uppercase-A grid and hazard preview.
//////////////////////////////////////////////////////////////////////

/* [Selected source] */
source_id_selected = "SRC_1"; // [SRC_1,SRC_2,SRC_3]

/* [Source 1] */
source_1_label = "Source 1";
source_1_font_name = "";
source_1_license = "unrecorded";
source_1_url = "";
source_1_revision = "";

/* [Source 2] */
source_2_label = "Source 2";
source_2_font_name = "";
source_2_license = "unrecorded";
source_2_url = "";
source_2_revision = "";

/* [Source 3] */
source_3_label = "Source 3";
source_3_font_name = "";
source_3_license = "unrecorded";
source_3_url = "";
source_3_revision = "";


/* [Exact assembled height] */
normalization_method = "resize"; // [resize,manual,textmetrics]
target_assembled_height = 600;
normalization_probe_size = 100;

/* [Manual source-profile bounds] */
manual_profile_left = -999999;
manual_profile_right = -999999;
manual_profile_bottom = -999999;
manual_profile_top = -999999;

/* [Profile] */
extrusion_depth = 6;


/* [Section grid after normalization] */
section_origin_x = -300;
section_origin_y = 0;
section_cell_width = 200;
section_cell_height = 200;
section_columns = 3;
section_rows = 3;
section_epsilon = 0.05;
bed_x = 220;
bed_y = 220;

/* [Plan appearance] */
show_section_grid = true;
show_hazard_guides = true;
show_normalized_bounds = true;
grid_line_width = 1.2;
hazard_line_width = 5;
normalized_bounds_line_width = 1.5;

/* [Normalized A hazard guides] */
a_apex_y_ratio = 0.96;
a_counter_bottom_ratio = 0.28;
a_counter_top_ratio = 0.62;
a_crossbar_y_ratio = 0.40;
a_counter_half_width_ratio = 0.17;


/* [Hidden] */
workbench_name = "a_section_plan";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "a_section_plan";
report_level = "full";
source_kind = "font";
selected_section_column = 0;
selected_section_row = 0;
layout_gap = 20;

include <../main.scad>
