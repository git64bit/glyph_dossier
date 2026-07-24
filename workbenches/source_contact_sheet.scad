//////////////////////////////////////////////////////////////////////
// LibFile: source_contact_sheet.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Representative study set from one configured source.
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


/* [Sheet] */
sheet_columns = 5;
sheet_cell_size = 72;
sheet_glyph_size = 42;
sheet_depth = 2;

/* [Hidden] */
workbench_name = "source_contact_sheet";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "source_contact_sheet";
report_level = "full";
source_kind = "font";

include <../main.scad>
