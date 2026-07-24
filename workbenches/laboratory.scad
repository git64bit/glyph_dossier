//////////////////////////////////////////////////////////////////////
// LibFile: laboratory.scad
// Project: Glyph Dossier
// FileGroup: Executable Workbench
// FileSummary: Main individual-character analysis workbench.
//////////////////////////////////////////////////////////////////////

/* [View] */
render_mode = "dossier"; // [dossier,profile_2d,profile_3d,report_only]
report_level = "full"; // [full,summary]

/* [Character] */
glyph_id_selected = "U_A";

/* [Source] */
source_kind = "font";
font_name = "";
font_license = "unrecorded";
font_source_url = "";
font_revision = "";

/* [Profile] */
nominal_size = 120;
extrusion_depth = 6;

/* [Nominal analysis guides] */
guide_depth = 0.8;
show_guides = true;
show_frame = true;
x_height_ratio = 0.52;
cap_height_ratio = 0.72;
ascender_ratio = 0.78;
descender_ratio = 0.22;

/* [Contact sheet] */
sheet_columns = 5;
sheet_cell_size = 72;
sheet_glyph_size = 42;
sheet_depth = 2;


/* [Hidden] */
workbench_name = "laboratory";
project_name_selected = "GLYPH_DOSSIER_LAB";

include <../main.scad>
