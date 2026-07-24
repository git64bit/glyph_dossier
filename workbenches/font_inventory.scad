//////////////////////////////////////////////////////////////////////
// LibFile: font_inventory.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Console inventory of configured and resolved fonts.
//////////////////////////////////////////////////////////////////////

/* [Selected specimen source] */
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


/* [Runtime metrics] */
runtime_fontmetrics_enabled = false;
font_metrics_size = 20;

/* [Specimen] */
source_sample_size = 42;
source_sample_depth = 2;
source_sample_line_gap = 1.35;

/* [Hidden] */
workbench_name = "font_inventory";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "font_inventory";
report_level = "full";
source_kind = "font";

include <../main.scad>
