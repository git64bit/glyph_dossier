//////////////////////////////////////////////////////////////////////
// LibFile: portable_defaults.scad
// Project: Glyph Dossier
// FileGroup: Portable Workbench Configuration
// FileSummary: Resolves portable_* wrapper inputs.
//////////////////////////////////////////////////////////////////////

pg_glyph_id = is_undef(portable_glyph_id_selected)
    ? "U_A" : portable_glyph_id_selected;
pg_render_mode = is_undef(portable_render_mode)
    ? "glyph_3d" : portable_render_mode;
pg_target_height = is_undef(portable_target_height)
    ? 120 : portable_target_height;
pg_depth = is_undef(portable_extrusion_depth)
    ? 6 : portable_extrusion_depth;
pg_sheet_columns = is_undef(portable_sheet_columns)
    ? 5 : portable_sheet_columns;
pg_sheet_cell_size = is_undef(portable_sheet_cell_size)
    ? 90 : portable_sheet_cell_size;
pg_sheet_glyph_height = is_undef(portable_sheet_glyph_height)
    ? 58 : portable_sheet_glyph_height;
pg_live_font_name = is_undef(portable_live_font_name)
    ? "Liberation Sans:style=Regular" : portable_live_font_name;
pg_compare_spacing = is_undef(portable_compare_spacing)
    ? 190 : portable_compare_spacing;

VALID_PORTABLE_RENDER_MODES = [
    "glyph_2d",
    "glyph_3d",
    "contact_sheet",
    "diagnostics",
    "compare_live",
    "report_only"
];

module validate_portable_workbench() {
    assert(
        in_list(pg_render_mode, VALID_PORTABLE_RENDER_MODES),
        str("Unknown portable render mode: ", pg_render_mode)
    );
    assert(pg_target_height > 0, "Portable target height must be positive.");
    assert(pg_depth > 0, "Portable extrusion depth must be positive.");
    assert(pg_sheet_columns >= 1, "Portable sheet columns must be positive.");
}
