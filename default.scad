//////////////////////////////////////////////////////////////////////
// LibFile: default.scad
// Project: Glyph Dossier
// FileGroup: Maintainer Workbench
// FileSummary: Broad mutable development entry point.
//////////////////////////////////////////////////////////////////////

workbench_name = "development";
project_name_selected = "GLYPH_DOSSIER_LAB";
glyph_id_selected = "U_A";
render_mode = "dossier";
report_level = "full";

source_kind = "font";
font_name = "";
font_license = "unrecorded";
font_source_url = "";
font_revision = "";

nominal_size = 120;
extrusion_depth = 6;
guide_depth = 0.8;
show_guides = true;
show_frame = true;

x_height_ratio = 0.52;
cap_height_ratio = 0.72;
ascender_ratio = 0.78;
descender_ratio = 0.22;

sheet_columns = 5;
sheet_cell_size = 72;
sheet_glyph_size = 42;
sheet_depth = 2;

include <main.scad>
