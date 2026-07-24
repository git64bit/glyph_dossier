//////////////////////////////////////////////////////////////////////
// LibFile: glyph_observation.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Manual source-specific glyph observation candidate.
//////////////////////////////////////////////////////////////////////

/* [Character and source] */
glyph_id_selected = "U_A";
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


/* [Observation record] */
observed_status = "pending"; // [pending,observed,verified]
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

/* [Stroke probe] */
stroke_probe_x = 0;
stroke_probe_y = 45;
stroke_probe_orientation = "vertical"; // [vertical,horizontal]
stroke_probe_length = 30;

/* [Gap probe] */
gap_probe_x = 0;
gap_probe_y = 25;
gap_probe_orientation = "horizontal"; // [horizontal,vertical]
gap_probe_length = 30;

/* [Profile] */
nominal_size = 120;
extrusion_depth = 6;

/* [Guides] */
guide_depth = 0.8;
show_guides = true;
show_frame = true;
show_manual_guides = true;
x_height_ratio = 0.52;
cap_height_ratio = 0.72;
ascender_ratio = 0.78;
descender_ratio = 0.22;

/* [Hidden] */
workbench_name = "glyph_observation";
project_name_selected = "GLYPH_DOSSIER_LAB";
render_mode = "observation";
report_level = "full";
source_kind = "font";

include <../main.scad>
