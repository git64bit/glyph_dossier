//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Glyph Dossier
// FileGroup: Shared Workbench Orchestrator
// FileSummary: Dispatches anatomy, observation, and normalized A work.
//////////////////////////////////////////////////////////////////////

include <lib/schema.scad>
include <config/defaults.scad>

include <registries/laboratory_projects.scad>
include <registries/catalog_projects.scad>
include <config/projects.scad>

include <registries/uppercase.scad>
include <registries/lowercase.scad>
include <registries/digits.scad>
include <registries/punctuation.scad>
include <registries/study_sets.scad>
include <config/glyphs.scad>

include <registries/laboratory_sources.scad>
include <config/sources.scad>
include <registries/representative_observations.scad>
include <config/observations.scad>

include <config/workbenches.scad>
include <lib/lookup.scad>
include <lib/sectioning.scad>
include <lib/normalization.scad>
include <lib/validation.scad>
include <lib/reporting.scad>

include <geometry/glyph_profile.scad>
include <geometry/analysis_guides.scad>
include <geometry/dossier_scene.scad>
include <geometry/contact_sheet.scad>
include <geometry/measurement_guides.scad>
include <geometry/observation_scene.scad>
include <geometry/source_sample.scad>
include <geometry/source_comparison.scad>
include <geometry/source_contact_sheet.scad>
include <geometry/section_grid.scad>
include <geometry/a_hazard_map.scad>
include <geometry/normalized_glyph.scad>
include <geometry/normalized_profile_scene.scad>
include <geometry/section_scene.scad>

module report_active_normalization() {
    if (wb_normalization_method == "manual")
        report_manual_normalization(
            wb_target_assembled_height,
            wb_normalization_probe_size,
            wb_manual_profile_left,
            wb_manual_profile_right,
            wb_manual_profile_bottom,
            wb_manual_profile_top
        );
    else if (wb_normalization_method == "textmetrics")
        report_textmetrics_notice(
            wb_target_assembled_height,
            wb_normalization_probe_size
        );
    else
        report_resize_normalization(
            wb_target_assembled_height,
            wb_normalization_probe_size
        );
}

module validate_active_normalized_a(dossier) {
    validate_normalization(
        dossier,
        wb_normalization_method,
        wb_target_assembled_height,
        wb_normalization_probe_size,
        wb_manual_profile_left,
        wb_manual_profile_right,
        wb_manual_profile_bottom,
        wb_manual_profile_top
    );
}

module render_active_normalized_a(
    dossier,
    source
) {
    render_normalized_profile(
        dossier,
        source,
        wb_normalization_method,
        wb_target_assembled_height,
        wb_normalization_probe_size,
        wb_extrusion_depth,
        wb_manual_profile_left,
        wb_manual_profile_right,
        wb_manual_profile_bottom,
        wb_manual_profile_top,
        wb_show_normalized_bounds,
        wb_normalized_bounds_line_width,
        section_plan_width(
            wb_section_cell_width,
            wb_section_columns
        ) / 2
    );
}

module render_active_a_sections(
    dossier,
    source
) {
    validate_active_normalized_a(dossier);

    validate_a_section_plan(
        dossier,
        wb_section_cell_width,
        wb_section_cell_height,
        wb_section_columns,
        wb_section_rows,
        wb_selected_section_column,
        wb_selected_section_row,
        wb_section_epsilon,
        wb_bed_x,
        wb_bed_y,
        wb_a_apex_y_ratio,
        wb_a_counter_bottom_ratio,
        wb_a_counter_top_ratio,
        wb_a_crossbar_y_ratio,
        wb_a_counter_half_width_ratio
    );

    report_active_normalization();

    report_section_plan(
        wb_section_origin_x,
        wb_section_origin_y,
        wb_section_cell_width,
        wb_section_cell_height,
        wb_section_columns,
        wb_section_rows,
        wb_bed_x,
        wb_bed_y
    );

    report_section_manifest(
        wb_section_origin_x,
        wb_section_origin_y,
        wb_section_cell_width,
        wb_section_cell_height,
        wb_section_columns,
        wb_section_rows
    );

    if (wb_render_mode == "a_section_plan")
        render_a_section_plan(
            dossier,
            source,
            wb_normalization_method,
            wb_target_assembled_height,
            wb_normalization_probe_size,
            wb_extrusion_depth,
            wb_manual_profile_left,
            wb_manual_profile_right,
            wb_manual_profile_bottom,
            wb_manual_profile_top,
            wb_section_origin_x,
            wb_section_origin_y,
            wb_section_cell_width,
            wb_section_cell_height,
            wb_section_columns,
            wb_section_rows,
            wb_show_section_grid,
            wb_show_hazard_guides,
            wb_show_normalized_bounds,
            wb_grid_line_width,
            wb_hazard_line_width,
            wb_normalized_bounds_line_width,
            wb_a_apex_y_ratio,
            wb_a_counter_bottom_ratio,
            wb_a_counter_top_ratio,
            wb_a_crossbar_y_ratio,
            wb_a_counter_half_width_ratio
        );
    else if (wb_render_mode == "a_section_layout")
        render_a_section_layout(
            dossier,
            source,
            wb_normalization_method,
            wb_target_assembled_height,
            wb_normalization_probe_size,
            wb_extrusion_depth,
            wb_manual_profile_left,
            wb_manual_profile_right,
            wb_manual_profile_bottom,
            wb_manual_profile_top,
            wb_section_origin_x,
            wb_section_origin_y,
            wb_section_cell_width,
            wb_section_cell_height,
            wb_section_columns,
            wb_section_rows,
            wb_section_epsilon,
            wb_layout_gap
        );
    else {
        report_selected_section(
            wb_section_origin_x,
            wb_section_origin_y,
            wb_section_cell_width,
            wb_section_cell_height,
            wb_selected_section_column,
            wb_selected_section_row
        );

        render_a_section_export(
            dossier,
            source,
            wb_normalization_method,
            wb_target_assembled_height,
            wb_normalization_probe_size,
            wb_extrusion_depth,
            wb_manual_profile_left,
            wb_manual_profile_right,
            wb_manual_profile_bottom,
            wb_manual_profile_top,
            wb_section_origin_x,
            wb_section_origin_y,
            wb_section_cell_width,
            wb_section_cell_height,
            wb_selected_section_column,
            wb_selected_section_row,
            wb_section_epsilon
        );
    }
}

module run_glyph_dossier() {
    validate_workbench_selection(
        wb_workbench_name,
        wb_render_mode,
        wb_source_kind,
        wb_stroke_probe_orientation,
        wb_gap_probe_orientation
    );

    project = named_record(
        PROJECTS,
        wb_project_name,
        "Glyph Dossier project"
    );

    source = named_record(
        FONT_SOURCES,
        wb_source_id,
        "font source"
    );

    validate_project(project);
    validate_glyph_registry(ALL_GLYPHS);
    validate_font_source_registry(FONT_SOURCES);
    validate_observation_registry(
        GLYPH_OBSERVATIONS,
        FONT_SOURCES,
        ALL_GLYPHS
    );

    report_environment();
    report_project(project, wb_report_level);
    report_font_source(source, wb_report_level);

    if (project[PR_KIND] == "catalog_notice") {
        report_catalog_notice(project);
    } else if (wb_render_mode == "font_inventory") {
        report_configured_font_sources(
            FONT_SOURCES,
            wb_report_level
        );
        report_runtime_fontmetrics(
            FONT_SOURCES,
            wb_runtime_fontmetrics_enabled,
            wb_font_metrics_size
        );
        render_source_sample(
            source,
            wb_source_sample_size,
            wb_source_sample_depth,
            wb_source_sample_line_gap
        );
    } else if (wb_render_mode == "source_sample") {
        render_source_sample(
            source,
            wb_source_sample_size,
            wb_source_sample_depth,
            wb_source_sample_line_gap
        );
    } else if (
        wb_render_mode == "contact_sheet"
        || wb_render_mode == "source_contact_sheet"
    ) {
        validate_id_set(
            REPRESENTATIVE_SET_IDS,
            ALL_GLYPHS,
            "representative study set"
        );
        report_study_set(
            "REPRESENTATIVE_SET",
            REPRESENTATIVE_SET_IDS
        );
        render_source_contact_sheet(
            REPRESENTATIVE_SET_IDS,
            ALL_GLYPHS,
            source,
            wb_sheet_columns,
            wb_sheet_cell_size,
            wb_sheet_glyph_size,
            wb_sheet_depth
        );
    } else {
        dossier = named_record(
            ALL_GLYPHS,
            wb_glyph_id,
            "glyph dossier"
        );

        validate_glyph_dossier(dossier);
        report_glyph_dossier(dossier, wb_report_level);

        if (wb_render_mode == "a_normalized_profile") {
            validate_active_normalized_a(dossier);
            report_active_normalization();
            render_active_normalized_a(dossier, source);
        } else if (
            wb_render_mode == "a_section_plan"
            || wb_render_mode == "a_section_layout"
            || wb_render_mode == "a_section_export"
        ) {
            render_active_a_sections(dossier, source);
        } else if (wb_render_mode == "comparison") {
            comparison_ids = [
                wb_compare_source_1_id,
                wb_compare_source_2_id,
                wb_compare_source_3_id
            ];

            validate_id_set(
                comparison_ids,
                FONT_SOURCES,
                "comparison source set"
            );
            report_source_order(comparison_ids);

            for (source_id = comparison_ids)
                report_font_source(
                    named_record(
                        FONT_SOURCES,
                        source_id,
                        "comparison source"
                    ),
                    wb_report_level
                );

            render_source_comparison(
                dossier,
                FONT_SOURCES,
                comparison_ids,
                wb_nominal_size,
                wb_extrusion_depth,
                wb_comparison_spacing
            );
        } else if (wb_render_mode == "observation") {
            ledger_matches = observation_matches(
                GLYPH_OBSERVATIONS,
                source[FS_ID],
                dossier[GD_ID]
            );

            if (len(ledger_matches) == 1)
                report_glyph_observation(
                    ledger_matches[0],
                    wb_report_level,
                    "LEDGER"
                );
            else
                echo(
                    "LEDGER_STATUS",
                    str(
                        "No unique pending slot for ",
                        source[FS_ID],
                        " ",
                        dossier[GD_ID]
                    )
                );

            candidate = glyph_observation(
                str(
                    "CANDIDATE_",
                    source[FS_ID],
                    "_",
                    dossier[GD_ID]
                ),
                source[FS_ID],
                dossier[GD_ID],
                wb_observed_status,
                wb_observed_variant,
                wb_observed_components,
                wb_observed_counters,
                wb_observed_left_extent,
                wb_observed_right_extent,
                wb_observed_bottom_extent,
                wb_observed_top_extent,
                wb_observed_minimum_stroke,
                wb_observed_minimum_gap,
                wb_observation_note
            );

            validate_glyph_observation(candidate);
            report_glyph_observation(
                candidate,
                wb_report_level,
                "CANDIDATE"
            );

            render_observation_scene(
                dossier,
                source,
                candidate,
                wb_nominal_size,
                wb_extrusion_depth,
                wb_guide_depth,
                wb_show_guides,
                wb_show_frame,
                wb_show_manual_guides,
                wb_x_height_ratio,
                wb_cap_height_ratio,
                wb_ascender_ratio,
                wb_descender_ratio,
                wb_stroke_probe_x,
                wb_stroke_probe_y,
                wb_stroke_probe_orientation,
                wb_stroke_probe_length,
                wb_gap_probe_x,
                wb_gap_probe_y,
                wb_gap_probe_orientation,
                wb_gap_probe_length
            );
        } else if (wb_render_mode != "report_only") {
            render_glyph_dossier(
                dossier,
                wb_render_mode,
                source[FS_KIND],
                source[FS_FONT_NAME],
                wb_nominal_size,
                wb_extrusion_depth,
                wb_guide_depth,
                wb_show_guides,
                wb_show_frame,
                wb_x_height_ratio,
                wb_cap_height_ratio,
                wb_ascender_ratio,
                wb_descender_ratio
            );
        }
    }
}

run_glyph_dossier();
