//////////////////////////////////////////////////////////////////////
// LibFile: a_normalized_profile.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Whole uppercase A at exact assembled height.
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


/* [Reference bounds] */
show_normalized_bounds = true;
normalized_bounds_line_width = 1.5;
section_cell_width = 200;
section_columns = 3;

/* [Hidden] */
workbench_name = "a_normalized_profile";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "a_normalized_profile";
report_level = "full";
source_kind = "font";
section_origin_x = -300;
section_origin_y = 0;
section_cell_height = 200;
section_rows = 3;
selected_section_column = 0;
selected_section_row = 0;
section_epsilon = 0.05;
layout_gap = 20;
bed_x = 220;
bed_y = 220;

include <../main.scad>
