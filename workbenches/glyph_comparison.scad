//////////////////////////////////////////////////////////////////////
// LibFile: glyph_comparison.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Same glyph across three configured font sources.
//////////////////////////////////////////////////////////////////////

/* [Character] */
glyph_id_selected = "U_A";

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


/* [Comparison order] */
compare_source_1_id = "SRC_1"; // [SRC_1,SRC_2,SRC_3]
compare_source_2_id = "SRC_2"; // [SRC_1,SRC_2,SRC_3]
compare_source_3_id = "SRC_3"; // [SRC_1,SRC_2,SRC_3]
comparison_spacing = 170;

/* [Profile] */
nominal_size = 120;
extrusion_depth = 6;

/* [Hidden] */
workbench_name = "glyph_comparison";
project_name_selected = "GLYPH_DOSSIER_LAB";
source_id_selected = "SRC_1";
render_mode = "comparison";
report_level = "full";
source_kind = "font";

include <../main.scad>
