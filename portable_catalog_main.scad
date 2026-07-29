//////////////////////////////////////////////////////////////////////
// LibFile: portable_catalog_main.scad
// Project: Glyph Dossier
// FileGroup: Multi-Family Catalog Orchestrator
// FileSummary: Selects one set and one glyph without OS font lookup.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>

include <lib/portable_glyph_schema.scad>
include <lib/portable_font_set_schema.scad>
include <glyph_sets/liberation_sans_regular/manifest.scad>
include <registries/portable_font_sets.scad>

include <lib/portable_glyph_lookup.scad>
include <lib/portable_glyph_validation.scad>
include <lib/portable_catalog_groups.scad>
include <lib/portable_font_set_lookup.scad>
include <lib/portable_font_set_validation.scad>
include <lib/portable_font_set_reporting.scad>
include <lib/portable_glyph_reporting.scad>
include <lib/portable_normalization_validation.scad>
include <lib/portable_normalization_reporting.scad>
include <config/portable_catalog_defaults.scad>

include <geometry/portable_glyph_region.scad>
include <geometry/portable_glyph_scenes.scad>
include <geometry/portable_font_family_scenes.scad>
include <geometry/portable_normalized_profile_scene.scad>

module run_portable_catalog() {
    validate_portable_catalog_workbench();

    set_record = portable_font_set_by_id(
        PORTABLE_FONT_SETS,
        pc_set_id
    );
    glyph = portable_glyph_by_id(
        set_record[PFS_GLYPHS],
        pc_glyph_id
    );

    validate_portable_glyph(glyph);
    report_portable_font_registry(PORTABLE_FONT_SETS);
    report_selected_portable_font_set(set_record);
    report_portable_glyph(glyph);

    if (pc_render_mode == "glyph_2d")
        portable_glyph_2d(glyph, pc_target_height);
    else if (pc_render_mode == "glyph_3d")
        portable_glyph_3d(glyph, pc_target_height, pc_depth);
    else if (pc_render_mode == "normalized_profile") {
        validate_portable_normalization_profile(
            set_record,
            glyph,
            pc_target_height,
            pc_depth,
            pc_bounds_line_width
        );
        report_generic_portable_normalization(
            set_record,
            glyph,
            pc_target_height
        );
        portable_generic_normalized_profile(
            glyph,
            pc_target_height,
            pc_depth,
            pc_show_normalized_bounds,
            pc_bounds_line_width
        );
    } else if (pc_render_mode == "diagnostics")
        portable_component_diagnostics(
            glyph,
            pc_target_height,
            pc_depth
        );
    else if (pc_render_mode == "contact_sheet") {
        validate_portable_font_set(set_record);
        portable_contact_sheet(
            portable_sheet_ids(pc_sheet_group),
            set_record[PFS_GLYPHS],
            pc_sheet_columns,
            pc_sheet_cell_size,
            pc_sheet_glyph_height,
            pc_depth
        );
    } else if (pc_render_mode == "family_comparison") {
        validate_portable_font_registry(PORTABLE_FONT_SETS);
        portable_font_family_comparison(
            PORTABLE_FONT_SETS,
            pc_glyph_id,
            pc_target_height,
            pc_depth,
            pc_family_spacing
        );
    }
}

run_portable_catalog();
