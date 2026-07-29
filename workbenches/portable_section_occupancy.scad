    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_section_occupancy.scad
    // Project: Glyph Dossier
    // FileGroup: Executable Occupancy Workbench
    // FileSummary: Occupied and empty grid cells for any portable glyph.
    //////////////////////////////////////////////////////////////////////

    /* [Portable source] */
portable_set_id_selected = "LIBERATION_SANS_REGULAR_R1"; // [LIBERATION_SANS_REGULAR_R1,MONTSERRAT_REGULAR_R1,ALPHA_SLAB_ONE_REGULAR_R1,FIRA_SANS_REGULAR_R1,MIAMA_NUEVA_MEDIUM_R1,PLAYFAIR_DISPLAY_REGULAR_R1]
portable_glyph_id_selected = "U_A"; // [U_A,U_B,U_C,U_D,U_E,U_F,U_G,U_H,U_I,U_J,U_K,U_L,U_M,U_N,U_O,U_P,U_Q,U_R,U_S,U_T,U_U,U_V,U_W,U_X,U_Y,U_Z,L_a,L_b,L_c,L_d,L_e,L_f,L_g,L_h,L_i,L_j,L_k,L_l,L_m,L_n,L_o,L_p,L_q,L_r,L_s,L_t,L_u,L_v,L_w,L_x,L_y,L_z,D_0,D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,D_9,P_question,P_exclamation,P_colon,P_semicolon]

/* [Exact assembled geometry] */
portable_target_height = 600;
portable_extrusion_depth = 6;

/* [Grid resolution] */
portable_section_grid_mode = "auto"; // [auto,manual]
portable_section_cell_width = 200;
portable_section_cell_height = 200;

/* [Manual grid: used only in manual mode] */
portable_section_origin_x = -300;
portable_section_origin_y = 0;
portable_section_columns = 3;
portable_section_rows = 3;

/* [Configured build area] */
portable_section_bed_x = 220;
portable_section_bed_y = 220;

/* [Occupancy] */
portable_occupancy_area_epsilon = 0.000001;
portable_occupancy_boolean_epsilon = 0.000000001;

/* [Section geometry] */
portable_section_epsilon = 0.05;
portable_section_layout_gap = 20;

/* [Hidden validation controls] */
portable_selected_section_column = 0;
portable_selected_section_row = 0;
portable_section_grid_line_width = 1.2;
portable_bounds_line_width = 1.5;


    /* [Occupancy appearance] */
    portable_show_empty_occupancy_cells = true;
    portable_occupancy_overlay_depth = 0.5;

    /* [Hidden] */
    portable_selected_occupied_ordinal = 0;
    portable_render_mode = "occupancy_plan";

    include <../portable_section_main.scad>
