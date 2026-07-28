//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_reporting.scad
// Project: Glyph Dossier
// FileGroup: Portable Font Set Reporting
// FileSummary: Selected-family and registry console reports.
//////////////////////////////////////////////////////////////////////

module report_portable_font_registry(records) {
    echo("PORTABLE_FONT_REGISTRY_COUNT", len(records));
    for (index = [0 : len(records) - 1])
        echo("PORTABLE_FONT_REGISTRY_ENTRY", [
            index,
            records[index][PFS_ID],
            records[index][PFS_FAMILY],
            records[index][PFS_STYLE]
        ]);
}

module report_selected_portable_font_set(set_record) {
    echo("PORTABLE_SELECTED_SET_ID", set_record[PFS_ID]);
    echo("PORTABLE_SELECTED_FAMILY", set_record[PFS_FAMILY]);
    echo("PORTABLE_SELECTED_STYLE", set_record[PFS_STYLE]);
    echo("PORTABLE_SELECTED_FONT_VERSION", set_record[PFS_FONT_VERSION]);
    echo("PORTABLE_SELECTED_LICENSE", set_record[PFS_LICENSE]);
    echo("PORTABLE_SELECTED_SOURCE_URL", set_record[PFS_SOURCE_URL]);
    echo("PORTABLE_SELECTED_SOURCE_FILENAME", set_record[PFS_SOURCE_FILENAME]);
    echo("PORTABLE_SELECTED_SOURCE_SHA256", set_record[PFS_SOURCE_SHA256]);
    echo("PORTABLE_SELECTED_FLATTEN_TOLERANCE", set_record[PFS_FLATTEN_TOLERANCE]);
    echo("PORTABLE_SELECTED_GLYPH_COUNT", len(set_record[PFS_GLYPHS]));
    echo("PORTABLE_SELECTED_BOSL2_INCLUDE", "BOSL2/std.scad");
}
