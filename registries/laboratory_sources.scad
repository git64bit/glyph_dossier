//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_sources.scad
// Project: Glyph Dossier
// FileGroup: Mutable Source Registry
// FileSummary: Three stable configurable font-source identities.
//////////////////////////////////////////////////////////////////////

LABORATORY_FONT_SOURCES = [
    font_source(
        "SRC_1",
        "font",
        wb_source_1_label,
        wb_source_1_font_name,
        wb_source_1_license,
        wb_source_1_url,
        wb_source_1_revision,
        "active"
    ),
    font_source(
        "SRC_2",
        "font",
        wb_source_2_label,
        wb_source_2_font_name,
        wb_source_2_license,
        wb_source_2_url,
        wb_source_2_revision,
        "active"
    ),
    font_source(
        "SRC_3",
        "font",
        wb_source_3_label,
        wb_source_3_font_name,
        wb_source_3_license,
        wb_source_3_url,
        wb_source_3_revision,
        "active"
    )
];
