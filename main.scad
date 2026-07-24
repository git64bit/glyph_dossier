//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Glyph Dossier
// FileGroup: Shared Workbench Orchestrator
// FileSummary: Resolves, validates, reports, and dispatches analysis.
//////////////////////////////////////////////////////////////////////

include <config/defaults.scad>
include <lib/schema.scad>
include <registries/laboratory_projects.scad>
include <registries/catalog_projects.scad>
include <config/projects.scad>

include <registries/uppercase.scad>
include <registries/lowercase.scad>
include <registries/digits.scad>
include <registries/punctuation.scad>
include <registries/study_sets.scad>
include <config/glyphs.scad>

include <config/workbenches.scad>
include <lib/lookup.scad>
include <lib/validation.scad>
include <lib/reporting.scad>
include <geometry/glyph_profile.scad>
include <geometry/analysis_guides.scad>
include <geometry/dossier_scene.scad>
include <geometry/contact_sheet.scad>

module run_glyph_dossier() {
    validate_workbench_selection(
        wb_workbench_name,
        wb_render_mode,
        wb_source_kind
    );

    project = named_record(
        PROJECTS,
        wb_project_name,
        "Glyph Dossier project"
    );

    validate_project(project);
    validate_glyph_registry(ALL_GLYPHS);
    report_project(project, wb_report_level);
    report_source(
        wb_source_kind,
        wb_font_name,
        wb_font_license,
        wb_font_source_url,
        wb_font_revision
    );

    if (project[PR_KIND] == "catalog_notice") {
        report_catalog_notice(project);
    } else if (wb_render_mode == "contact_sheet") {
        validate_id_set(
            REPRESENTATIVE_SET_IDS,
            ALL_GLYPHS,
            "representative study set"
        );
        report_study_set(
            "REPRESENTATIVE_SET",
            REPRESENTATIVE_SET_IDS
        );
        glyph_contact_sheet(
            REPRESENTATIVE_SET_IDS,
            ALL_GLYPHS,
            wb_source_kind,
            wb_font_name,
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

        if (wb_render_mode != "report_only")
            render_glyph_dossier(
                dossier,
                wb_render_mode,
                wb_source_kind,
                wb_font_name,
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

run_glyph_dossier();
