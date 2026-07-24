//////////////////////////////////////////////////////////////////////
// LibFile: portable_main.scad
// Project: Glyph Dossier
// FileGroup: Portable Workbench Orchestrator
// FileSummary: BOSL2 dispatch for captured source-independent glyphs.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <lib/portable_glyph_schema.scad>
include <glyph_sets/liberation_sans_regular/manifest.scad>
include <config/portable_defaults.scad>
include <lib/portable_glyph_lookup.scad>
include <lib/portable_glyph_validation.scad>
include <lib/portable_glyph_reporting.scad>
include <geometry/portable_glyph_region.scad>
include <geometry/portable_glyph_scenes.scad>

module run_portable_glyph_workbench() {
    validate_portable_workbench();
    glyph = portable_glyph_by_id(
        PORTABLE_GLYPHS,
        pg_glyph_id
    );
    validate_portable_glyph(glyph);
    report_portable_set();
    report_portable_glyph(glyph);
    echo("PORTABLE_NORMALIZED_HEIGHT_MM", pg_target_height);
    echo(
        "PORTABLE_NORMALIZED_WIDTH_MM",
        portable_normalized_width(glyph, pg_target_height)
    );

    if (pg_render_mode == "glyph_2d")
        portable_glyph_2d(glyph, pg_target_height);
    else if (pg_render_mode == "glyph_3d")
        portable_glyph_3d(
            glyph,
            pg_target_height,
            pg_depth
        );
    else if (pg_render_mode == "contact_sheet") {
        validate_portable_glyph_set(PORTABLE_GLYPHS);
        portable_contact_sheet(
            REPRESENTATIVE_PORTABLE_IDS,
            PORTABLE_GLYPHS,
            pg_sheet_columns,
            pg_sheet_cell_size,
            pg_sheet_glyph_height,
            pg_depth
        );
    } else if (pg_render_mode == "diagnostics")
        portable_component_diagnostics(
            glyph,
            pg_target_height,
            pg_depth
        );
    else if (pg_render_mode == "compare_live")
        portable_live_comparison(
            glyph,
            pg_target_height,
            pg_depth,
            pg_live_font_name,
            pg_compare_spacing
        );
}

REPRESENTATIVE_PORTABLE_IDS = [
    "U_A", "U_B", "U_O", "U_S", "U_Z",
    "L_a", "L_g", "L_i", "L_j", "L_m", "L_s",
    "D_0", "D_1", "D_2", "D_4", "D_8",
    "P_question", "P_exclamation", "P_colon", "P_semicolon"
];

run_portable_glyph_workbench();
