//////////////////////////////////////////////////////////////////////
// LibFile: portable_catalog_defaults.scad
// Project: Glyph Dossier
// FileGroup: Multi-Family Catalog Configuration
// FileSummary: Resolves family, glyph, render, and sheet controls.
//////////////////////////////////////////////////////////////////////

pc_set_id = is_undef(portable_set_id_selected)
    ? "LIBERATION_SANS_REGULAR_R1" : portable_set_id_selected;
pc_glyph_id = is_undef(portable_glyph_id_selected)
    ? "U_A" : portable_glyph_id_selected;
pc_render_mode = is_undef(portable_render_mode)
    ? "glyph_3d" : portable_render_mode;
pc_target_height = is_undef(portable_target_height)
    ? 120 : portable_target_height;
pc_depth = is_undef(portable_extrusion_depth)
    ? 6 : portable_extrusion_depth;
pc_sheet_group = is_undef(portable_sheet_group)
    ? "representative" : portable_sheet_group;
pc_sheet_columns = is_undef(portable_sheet_columns)
    ? 5 : portable_sheet_columns;
pc_sheet_cell_size = is_undef(portable_sheet_cell_size)
    ? 90 : portable_sheet_cell_size;
pc_sheet_glyph_height = is_undef(portable_sheet_glyph_height)
    ? 58 : portable_sheet_glyph_height;
pc_family_spacing = is_undef(portable_family_spacing)
    ? 170 : portable_family_spacing;

VALID_PORTABLE_CATALOG_MODES = [
    "glyph_2d",
    "glyph_3d",
    "diagnostics",
    "contact_sheet",
    "family_comparison",
    "report_only"
];

module validate_portable_catalog_workbench() {
    assert(
        in_list(pc_render_mode, VALID_PORTABLE_CATALOG_MODES),
        str("Unknown portable catalog mode: ", pc_render_mode)
    );
    assert(pc_target_height > 0, "Portable catalog height must be positive.");
    assert(pc_depth > 0, "Portable catalog depth must be positive.");
    assert(pc_sheet_columns >= 1, "Portable sheet columns must be positive.");
    assert(pc_family_spacing > 0, "Portable family spacing must be positive.");
    validate_portable_sheet_group(pc_sheet_group);
}
