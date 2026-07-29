//////////////////////////////////////////////////////////////////////
// LibFile: segmented_pipeline.scad
// Project: Glyph Dossier
// FileGroup: Executable Segmented Workbench
// FileSummary: Portable normalization, sectioning, and occupancy proof.
//////////////////////////////////////////////////////////////////////

/* [Segmented source] */
segmented_set_id_selected = "PROCEDURAL_14_SEGMENT_EXTENDED_R1"; // [PROCEDURAL_14_SEGMENT_EXTENDED_R1,PROCEDURAL_7_SEGMENT_EXTENDED_R1]
segmented_glyph_id_selected = "D_8"; // [U_A,U_B,U_C,U_D,U_E,U_F,U_G,U_H,U_I,U_J,U_K,U_L,U_M,U_N,U_O,U_P,U_Q,U_R,U_S,U_T,U_U,U_V,U_W,U_X,U_Y,U_Z,L_a,L_b,L_c,L_d,L_e,L_f,L_g,L_h,L_i,L_j,L_k,L_l,L_m,L_n,L_o,L_p,L_q,L_r,L_s,L_t,L_u,L_v,L_w,L_x,L_y,L_z,D_0,D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,D_9,P_question,P_exclamation,P_colon,P_semicolon]

/* [Pipeline view] */
segmented_pipeline_view = "section_plan"; // [normalized_profile,section_plan,occupancy_plan]

/* [Exact geometry] */
segmented_target_height = 600;
segmented_extrusion_depth = 6;

/* [Section grid] */
segmented_section_cell_width = 200;
segmented_section_cell_height = 200;
segmented_grid_line_width = 1.2;

/* [Occupancy] */
segmented_occupancy_area_epsilon = 0.000001;
segmented_boolean_epsilon = 0.000000001;
segmented_overlay_depth = 0.5;

/* [Hidden] */
segmented_render_mode = segmented_pipeline_view;
segmented_show_inactive = false;
segmented_show_frame = true;
segmented_frame_line_width = 1.5;
segmented_contact_columns = 11;
segmented_contact_cell_width = 130;
segmented_contact_cell_height = 220;
segmented_contact_show_unsupported = true;

include <../segmented_main.scad>
