//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Glyph Dossier
// FileGroup: Workbench Configuration
// FileSummary: Resolves wrapper inputs into stable wb_* values.
//////////////////////////////////////////////////////////////////////

wb_workbench_name = is_undef(workbench_name)
    ? "development" : workbench_name;
wb_project_name = is_undef(project_name_selected)
    ? "GLYPH_DOSSIER_LAB" : project_name_selected;
wb_glyph_id = is_undef(glyph_id_selected)
    ? "U_A" : glyph_id_selected;
wb_render_mode = is_undef(render_mode)
    ? "dossier" : render_mode;
wb_report_level = is_undef(report_level)
    ? "full" : report_level;

wb_source_kind = is_undef(source_kind)
    ? "font" : source_kind;
wb_font_name = is_undef(font_name)
    ? "" : font_name;
wb_font_license = is_undef(font_license)
    ? "unrecorded" : font_license;
wb_font_source_url = is_undef(font_source_url)
    ? "" : font_source_url;
wb_font_revision = is_undef(font_revision)
    ? "" : font_revision;

wb_nominal_size = is_undef(nominal_size)
    ? 120 : nominal_size;
wb_extrusion_depth = is_undef(extrusion_depth)
    ? 6 : extrusion_depth;
wb_guide_depth = is_undef(guide_depth)
    ? 0.8 : guide_depth;
wb_show_guides = is_undef(show_guides)
    ? true : show_guides;
wb_show_frame = is_undef(show_frame)
    ? true : show_frame;

wb_x_height_ratio = is_undef(x_height_ratio)
    ? 0.52 : x_height_ratio;
wb_cap_height_ratio = is_undef(cap_height_ratio)
    ? 0.72 : cap_height_ratio;
wb_ascender_ratio = is_undef(ascender_ratio)
    ? 0.78 : ascender_ratio;
wb_descender_ratio = is_undef(descender_ratio)
    ? 0.22 : descender_ratio;

wb_sheet_columns = is_undef(sheet_columns)
    ? 5 : sheet_columns;
wb_sheet_cell_size = is_undef(sheet_cell_size)
    ? 72 : sheet_cell_size;
wb_sheet_glyph_size = is_undef(sheet_glyph_size)
    ? 42 : sheet_glyph_size;
wb_sheet_depth = is_undef(sheet_depth)
    ? 2 : sheet_depth;
