//////////////////////////////////////////////////////////////////////
// LibFile: portable_main.scad
// Project: Glyph Dossier
// FileGroup: Portable Workbench Orchestrator
// FileSummary: BOSL2 dispatch for captured portable glyph geometry.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>

include <lib/portable_glyph_schema.scad>
include <glyph_sets/liberation_sans_regular/manifest.scad>
include <config/portable_defaults.scad>
include <config/portable_section_defaults.scad>

include <lib/sectioning.scad>
include <lib/portable_glyph_lookup.scad>
include <lib/portable_glyph_validation.scad>
include <lib/portable_glyph_reporting.scad>
include <lib/portable_section_validation.scad>
include <lib/portable_section_reporting.scad>

include <geometry/section_grid.scad>
include <geometry/a_hazard_map.scad>
include <geometry/portable_glyph_region.scad>
include <geometry/portable_glyph_scenes.scad>
include <geometry/portable_section_scene.scad>

REPRESENTATIVE_PORTABLE_IDS = [
    "U_A", "U_B", "U_O", "U_S", "U_Z",
    "L_a", "L_g", "L_i", "L_j", "L_m", "L_s",
    "D_0", "D_1", "D_2", "D_4", "D_8",
    "P_question", "P_exclamation", "P_colon", "P_semicolon"
];

module validate_active_portable_a(glyph) {
    validate_portable_a_section(
        glyph,
        pg_target_height,
        pg_depth,
        pg_section_origin_x,
        pg_section_origin_y,
        pg_section_cell_width,
        pg_section_cell_height,
        pg_section_columns,
        pg_section_rows,
        pg_selected_section_column,
        pg_selected_section_row,
        pg_section_epsilon,
        pg_section_layout_gap,
        pg_section_bed_x,
        pg_section_bed_y,
        pg_a_apex_y_ratio,
        pg_a_counter_bottom_ratio,
        pg_a_counter_top_ratio,
        pg_a_crossbar_y_ratio,
        pg_a_counter_half_width_ratio
    );
}

module report_active_portable_a(glyph) {
    report_portable_normalization(
        glyph,
        pg_target_height
    );
}

module report_active_portable_sections(glyph) {
    report_active_portable_a(glyph);

    report_portable_section_plan(
        glyph,
        pg_target_height,
        pg_section_origin_x,
        pg_section_origin_y,
        pg_section_cell_width,
        pg_section_cell_height,
        pg_section_columns,
        pg_section_rows,
        pg_section_bed_x,
        pg_section_bed_y
    );

    report_portable_section_manifest(
        pg_section_origin_x,
        pg_section_origin_y,
        pg_section_cell_width,
        pg_section_cell_height,
        pg_section_columns,
        pg_section_rows
    );
}

module render_active_portable_sections(glyph) {
    if (pg_render_mode == "a_section_plan")
        portable_a_section_plan(
            glyph,
            pg_target_height,
            pg_depth,
            pg_section_origin_x,
            pg_section_origin_y,
            pg_section_cell_width,
            pg_section_cell_height,
            pg_section_columns,
            pg_section_rows,
            pg_show_section_grid,
            pg_show_hazard_guides,
            pg_show_normalized_bounds,
            pg_section_grid_line_width,
            pg_hazard_line_width,
            pg_bounds_line_width,
            pg_a_apex_y_ratio,
            pg_a_counter_bottom_ratio,
            pg_a_counter_top_ratio,
            pg_a_crossbar_y_ratio,
            pg_a_counter_half_width_ratio
        );
    else if (pg_render_mode == "a_section_layout")
        portable_a_section_layout(
            glyph,
            pg_target_height,
            pg_depth,
            pg_section_origin_x,
            pg_section_origin_y,
            pg_section_cell_width,
            pg_section_cell_height,
            pg_section_columns,
            pg_section_rows,
            pg_section_epsilon,
            pg_section_layout_gap
        );
    else {
        report_portable_selected_section(
            pg_section_origin_x,
            pg_section_origin_y,
            pg_section_cell_width,
            pg_section_cell_height,
            pg_selected_section_column,
            pg_selected_section_row
        );

        portable_a_section_export(
            glyph,
            pg_target_height,
            pg_depth,
            pg_section_origin_x,
            pg_section_origin_y,
            pg_section_cell_width,
            pg_section_cell_height,
            pg_selected_section_column,
            pg_selected_section_row,
            pg_section_epsilon
        );
    }
}

module run_portable_glyph_workbench() {
    validate_portable_workbench();

    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        pg_glyph_id
    );

    validate_portable_glyph(glyph);
    report_portable_set();
    report_portable_glyph(glyph);

    if (pg_render_mode == "glyph_2d") {
        report_active_portable_a(glyph);
        portable_glyph_2d(glyph, pg_target_height);
    } else if (pg_render_mode == "glyph_3d") {
        report_active_portable_a(glyph);
        portable_glyph_3d(
            glyph,
            pg_target_height,
            pg_depth
        );
    } else if (pg_render_mode == "contact_sheet") {
        validate_portable_glyph_set(PORTABLE_GLYPHS);
        portable_contact_sheet(
            REPRESENTATIVE_PORTABLE_IDS,
            PORTABLE_GLYPHS,
            pg_sheet_columns,
            pg_sheet_cell_size,
            pg_sheet_glyph_height,
            pg_depth
        );
    } else if (pg_render_mode == "diagnostics") {
        report_active_portable_a(glyph);
        portable_component_diagnostics(
            glyph,
            pg_target_height,
            pg_depth
        );
    } else if (pg_render_mode == "compare_live") {
        report_active_portable_a(glyph);
        portable_live_comparison(
            glyph,
            pg_target_height,
            pg_depth,
            pg_live_font_name,
            pg_compare_spacing
        );
    } else if (pg_render_mode == "a_normalized_profile") {
        validate_active_portable_a(glyph);
        report_active_portable_a(glyph);
        portable_a_normalized_profile(
            glyph,
            pg_target_height,
            pg_depth,
            pg_show_normalized_bounds,
            pg_bounds_line_width
        );
    } else if (
        pg_render_mode == "a_section_plan"
        || pg_render_mode == "a_section_layout"
        || pg_render_mode == "a_section_export"
    ) {
        validate_active_portable_a(glyph);
        report_active_portable_sections(glyph);
        render_active_portable_sections(glyph);
    }
}

run_portable_glyph_workbench();
