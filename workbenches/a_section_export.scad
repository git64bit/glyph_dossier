//////////////////////////////////////////////////////////////////////
// LibFile: a_section_export.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: One uppercase-A section at local print coordinates.
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


/* [Large A] */
nominal_size = 600;
extrusion_depth = 6;

/* [Section grid] */
section_origin_x = -300;
section_origin_y = -20;
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
grid_line_width = 1.2;
hazard_line_width = 5;

/* [Nominal A hazard guides] */
a_apex_y_ratio = 0.72;
a_counter_bottom_ratio = 0.22;
a_counter_top_ratio = 0.55;
a_crossbar_y_ratio = 0.34;
a_counter_half_width_ratio = 0.17;


/* [Selected section: zero based] */
selected_section_column = 0;
selected_section_row = 0;

/* [Hidden] */
workbench_name = "a_section_export";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "a_section_export";
report_level = "full";
source_kind = "font";
layout_gap = 20;

include <../main.scad>
