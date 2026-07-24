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
wb_source_id = is_undef(source_id_selected)
    ? "SRC_1" : source_id_selected;
wb_render_mode = is_undef(render_mode)
    ? "dossier" : render_mode;
wb_report_level = is_undef(report_level)
    ? "full" : report_level;

legacy_font_name = is_undef(font_name) ? "" : font_name;
legacy_font_license = is_undef(font_license)
    ? "unrecorded" : font_license;
legacy_font_url = is_undef(font_source_url)
    ? "" : font_source_url;
legacy_font_revision = is_undef(font_revision)
    ? "" : font_revision;

wb_source_kind = is_undef(source_kind)
    ? "font" : source_kind;

wb_source_1_label = is_undef(source_1_label)
    ? "Source 1" : source_1_label;
wb_source_1_font_name = is_undef(source_1_font_name)
    ? legacy_font_name : source_1_font_name;
wb_source_1_license = is_undef(source_1_license)
    ? legacy_font_license : source_1_license;
wb_source_1_url = is_undef(source_1_url)
    ? legacy_font_url : source_1_url;
wb_source_1_revision = is_undef(source_1_revision)
    ? legacy_font_revision : source_1_revision;

wb_source_2_label = is_undef(source_2_label)
    ? "Source 2" : source_2_label;
wb_source_2_font_name = is_undef(source_2_font_name)
    ? "" : source_2_font_name;
wb_source_2_license = is_undef(source_2_license)
    ? "unrecorded" : source_2_license;
wb_source_2_url = is_undef(source_2_url)
    ? "" : source_2_url;
wb_source_2_revision = is_undef(source_2_revision)
    ? "" : source_2_revision;

wb_source_3_label = is_undef(source_3_label)
    ? "Source 3" : source_3_label;
wb_source_3_font_name = is_undef(source_3_font_name)
    ? "" : source_3_font_name;
wb_source_3_license = is_undef(source_3_license)
    ? "unrecorded" : source_3_license;
wb_source_3_url = is_undef(source_3_url)
    ? "" : source_3_url;
wb_source_3_revision = is_undef(source_3_revision)
    ? "" : source_3_revision;

wb_compare_source_1_id = is_undef(compare_source_1_id)
    ? "SRC_1" : compare_source_1_id;
wb_compare_source_2_id = is_undef(compare_source_2_id)
    ? "SRC_2" : compare_source_2_id;
wb_compare_source_3_id = is_undef(compare_source_3_id)
    ? "SRC_3" : compare_source_3_id;

wb_observed_status = is_undef(observed_status)
    ? "pending" : observed_status;
wb_observed_variant = is_undef(observed_variant)
    ? "unobserved" : observed_variant;
wb_observed_components = is_undef(observed_components)
    ? -999999 : observed_components;
wb_observed_counters = is_undef(observed_counters)
    ? -999999 : observed_counters;
wb_observed_left_extent = is_undef(observed_left_extent)
    ? -999999 : observed_left_extent;
wb_observed_right_extent = is_undef(observed_right_extent)
    ? -999999 : observed_right_extent;
wb_observed_bottom_extent = is_undef(observed_bottom_extent)
    ? -999999 : observed_bottom_extent;
wb_observed_top_extent = is_undef(observed_top_extent)
    ? -999999 : observed_top_extent;
wb_observed_minimum_stroke = is_undef(observed_minimum_stroke)
    ? -999999 : observed_minimum_stroke;
wb_observed_minimum_gap = is_undef(observed_minimum_gap)
    ? -999999 : observed_minimum_gap;
wb_observation_note = is_undef(observation_note)
    ? "Awaiting source-specific inspection." : observation_note;

wb_stroke_probe_x = is_undef(stroke_probe_x)
    ? 0 : stroke_probe_x;
wb_stroke_probe_y = is_undef(stroke_probe_y)
    ? 45 : stroke_probe_y;
wb_stroke_probe_orientation = is_undef(stroke_probe_orientation)
    ? "vertical" : stroke_probe_orientation;
wb_stroke_probe_length = is_undef(stroke_probe_length)
    ? 30 : stroke_probe_length;

wb_gap_probe_x = is_undef(gap_probe_x)
    ? 0 : gap_probe_x;
wb_gap_probe_y = is_undef(gap_probe_y)
    ? 25 : gap_probe_y;
wb_gap_probe_orientation = is_undef(gap_probe_orientation)
    ? "horizontal" : gap_probe_orientation;
wb_gap_probe_length = is_undef(gap_probe_length)
    ? 30 : gap_probe_length;

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
wb_show_manual_guides = is_undef(show_manual_guides)
    ? true : show_manual_guides;

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

wb_source_sample_size = is_undef(source_sample_size)
    ? 42 : source_sample_size;
wb_source_sample_depth = is_undef(source_sample_depth)
    ? 2 : source_sample_depth;
wb_source_sample_line_gap = is_undef(source_sample_line_gap)
    ? 1.35 : source_sample_line_gap;
wb_comparison_spacing = is_undef(comparison_spacing)
    ? 170 : comparison_spacing;

// Batch 001 compatibility aliases.
wb_font_name = wb_source_1_font_name;
wb_font_license = wb_source_1_license;
wb_font_source_url = wb_source_1_url;
wb_font_revision = wb_source_1_revision;
