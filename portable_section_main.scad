//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_main.scad
// Project: Glyph Dossier
// FileGroup: Generic Multi-Family Section Orchestrator
// FileSummary: Normalization, grid, occupancy, layout, and export.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>

include <lib/portable_glyph_schema.scad>
include <lib/portable_font_set_schema.scad>
include <lib/portable_section_occupancy_schema.scad>
include <glyph_sets/liberation_sans_regular/manifest.scad>
include <registries/portable_font_sets.scad>

include <lib/sectioning.scad>
include <lib/portable_glyph_lookup.scad>
include <lib/portable_glyph_validation.scad>
include <lib/portable_font_set_lookup.scad>
include <lib/portable_font_set_validation.scad>
include <lib/portable_font_set_reporting.scad>
include <lib/portable_glyph_reporting.scad>
include <lib/portable_normalization_validation.scad>
include <lib/portable_normalization_reporting.scad>
include <lib/portable_generic_sectioning.scad>
include <lib/portable_generic_section_validation.scad>
include <lib/portable_generic_section_reporting.scad>
include <lib/portable_section_occupancy.scad>
include <lib/portable_section_occupancy_validation.scad>
include <lib/portable_section_occupancy_reporting.scad>
include <config/portable_generic_section_defaults.scad>

include <geometry/portable_glyph_region.scad>
include <geometry/section_grid.scad>
include <geometry/portable_normalized_profile_scene.scad>
include <geometry/portable_generic_section_scene.scad>
include <geometry/portable_section_occupancy_scene.scad>

function portable_section_mode_needs_occupancy(
    render_mode
) =
    in_list(
        render_mode,
        [
            "occupancy_plan",
            "occupied_layout",
            "occupied_export",
            "occupancy_report"
        ]
    );

module run_portable_section_workbench() {
    validate_portable_generic_section_controls();

    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        ps_set_id
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        ps_glyph_id
    );

    columns = portable_resolved_section_columns(
        glyph,
        ps_target_height,
        ps_cell_width,
        ps_manual_columns,
        ps_grid_mode
    );
    rows = portable_resolved_section_rows(
        ps_target_height,
        ps_cell_height,
        ps_manual_rows,
        ps_grid_mode
    );
    origin_x = portable_resolved_section_origin_x(
        glyph,
        ps_target_height,
        ps_cell_width,
        ps_manual_origin_x,
        ps_manual_columns,
        ps_grid_mode
    );
    origin_y = portable_resolved_section_origin_y(
        ps_manual_origin_y,
        ps_grid_mode
    );

    occupancy_needed =
        portable_section_mode_needs_occupancy(
            ps_render_mode
        );
    occupancy_records =
        occupancy_needed
        ? portable_section_occupancy_records(
            set_record[PFS_ID],
            glyph,
            ps_target_height,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            columns,
            rows,
            ps_occupancy_area_epsilon,
            ps_occupancy_boolean_epsilon
        )
        : [];

    validate_portable_glyph(glyph);
    validate_portable_normalization_profile(
        set_record,
        glyph,
        ps_target_height,
        ps_depth,
        ps_bounds_line_width
    );
    validate_portable_generic_section(
        set_record,
        glyph,
        ps_target_height,
        ps_depth,
        ps_grid_mode,
        origin_x,
        origin_y,
        ps_cell_width,
        ps_cell_height,
        columns,
        rows,
        ps_selected_column,
        ps_selected_row,
        ps_epsilon,
        ps_layout_gap,
        ps_bed_x,
        ps_bed_y
    );

    if (occupancy_needed)
        validate_portable_section_occupancy_records(
            occupancy_records,
            columns,
            rows,
            ps_cell_width,
            ps_cell_height,
            ps_occupancy_area_epsilon
        );

    report_portable_font_registry(
        PORTABLE_FONT_SETS
    );
    report_selected_portable_font_set(
        set_record
    );
    report_portable_glyph(glyph);
    report_generic_portable_normalization(
        set_record,
        glyph,
        ps_target_height
    );
    report_portable_generic_section_plan(
        set_record,
        glyph,
        ps_target_height,
        ps_grid_mode,
        origin_x,
        origin_y,
        ps_cell_width,
        ps_cell_height,
        columns,
        rows,
        ps_bed_x,
        ps_bed_y
    );
    report_portable_generic_section_manifest(
        set_record,
        glyph,
        origin_x,
        origin_y,
        ps_cell_width,
        ps_cell_height,
        columns,
        rows
    );

    if (occupancy_needed) {
        report_portable_section_occupancy_summary(
            set_record,
            glyph,
            ps_target_height,
            occupancy_records,
            ps_occupancy_area_epsilon,
            ps_occupancy_boolean_epsilon
        );
        report_portable_section_occupancy_manifest(
            occupancy_records
        );
    }

    if (ps_render_mode == "section_plan")
        portable_generic_section_plan(
            glyph,
            ps_target_height,
            ps_depth,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            columns,
            rows,
            ps_show_grid,
            ps_show_bounds,
            ps_grid_line_width,
            ps_bounds_line_width
        );
    else if (ps_render_mode == "section_layout")
        portable_generic_section_layout(
            glyph,
            ps_target_height,
            ps_depth,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            columns,
            rows,
            ps_epsilon,
            ps_layout_gap
        );
    else if (ps_render_mode == "section_export") {
        selected_record =
            portable_section_occupancy_record(
                set_record[PFS_ID],
                glyph,
                ps_target_height,
                origin_x,
                origin_y,
                ps_cell_width,
                ps_cell_height,
                ps_selected_column,
                ps_selected_row,
                ps_occupancy_area_epsilon,
                ps_occupancy_boolean_epsilon
            );

        report_portable_generic_selected_section(
            set_record,
            glyph,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            ps_selected_column,
            ps_selected_row
        );
        report_portable_selected_occupancy_record(
            selected_record
        );

        portable_generic_section_export(
            glyph,
            ps_target_height,
            ps_depth,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            ps_selected_column,
            ps_selected_row,
            ps_epsilon
        );
    } else if (ps_render_mode == "occupancy_plan")
        portable_section_occupancy_plan(
            glyph,
            ps_target_height,
            ps_depth,
            occupancy_records,
            origin_x,
            origin_y,
            ps_cell_width,
            ps_cell_height,
            columns,
            rows,
            ps_grid_line_width,
            ps_occupancy_overlay_depth,
            ps_show_empty_occupancy_cells
        );
    else if (ps_render_mode == "occupied_layout")
        portable_occupied_section_layout(
            occupancy_records,
            ps_cell_width,
            ps_cell_height,
            ps_layout_gap,
            ps_depth
        );
    else if (ps_render_mode == "occupied_export") {
        occupied_record =
            portable_occupied_record_by_ordinal(
                occupancy_records,
                ps_selected_occupied_ordinal
            );

        report_portable_selected_occupancy_record(
            occupied_record,
            ps_selected_occupied_ordinal
        );
        portable_occupancy_record_export(
            occupied_record,
            ps_depth
        );
    }
}

run_portable_section_workbench();
