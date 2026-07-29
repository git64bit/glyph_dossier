//////////////////////////////////////////////////////////////////////
// LibFile: segmented_nonvisible_pipeline_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Unsupported normalized view remains non-fatal.
//////////////////////////////////////////////////////////////////////

segmented_set_id_selected =
    "PROCEDURAL_7_SEGMENT_EXTENDED_R1";
segmented_glyph_id_selected = "U_A";
segmented_render_mode = "normalized_profile";

segmented_target_height = 120;
segmented_extrusion_depth = 3;
segmented_show_inactive = false;
segmented_show_frame = true;
segmented_frame_line_width = 1;

segmented_section_cell_width = 60;
segmented_section_cell_height = 60;
segmented_grid_line_width = 0.8;
segmented_occupancy_area_epsilon = 0.000001;
segmented_boolean_epsilon = 0.000000001;
segmented_overlay_depth = 0.5;

segmented_contact_columns = 11;
segmented_contact_cell_width = 130;
segmented_contact_cell_height = 220;
segmented_contact_show_unsupported = true;

include <../segmented_main.scad>

echo(
    "PASS",
    "segmented_nonvisible_pipeline_contract"
);
