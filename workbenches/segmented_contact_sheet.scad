//////////////////////////////////////////////////////////////////////
// LibFile: segmented_contact_sheet.scad
// Project: Glyph Dossier
// FileGroup: Executable Segmented Workbench
// FileSummary: Sixty-six mapping-state cells for one source set.
//////////////////////////////////////////////////////////////////////

/* [Segmented source] */
segmented_set_id_selected = "PROCEDURAL_14_SEGMENT_EXTENDED_R1"; // [PROCEDURAL_14_SEGMENT_EXTENDED_R1,PROCEDURAL_7_SEGMENT_EXTENDED_R1]

/* [Contact sheet] */
segmented_contact_columns = 11;
segmented_contact_cell_width = 130;
segmented_contact_cell_height = 220;
segmented_contact_show_unsupported = true;
segmented_extrusion_depth = 1.5;
segmented_frame_line_width = 1.5;

/* [Hidden] */
segmented_glyph_id_selected = "D_8";
segmented_render_mode = "contact_sheet";
segmented_target_height = 600;
segmented_show_inactive = false;
segmented_show_frame = true;
segmented_section_cell_width = 200;
segmented_section_cell_height = 200;
segmented_grid_line_width = 1.2;
segmented_occupancy_area_epsilon = 0.000001;
segmented_boolean_epsilon = 0.000000001;
segmented_overlay_depth = 0.5;

include <../segmented_main.scad>
