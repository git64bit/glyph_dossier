//////////////////////////////////////////////////////////////////////
// LibFile: source_contact_sheet.scad
// Project: Glyph Dossier
// FileGroup: Source Diagnostic Rendering
// FileSummary: Representative contact sheet for one exact source.
//////////////////////////////////////////////////////////////////////

module render_source_contact_sheet(
    ids,
    records,
    source,
    columns,
    cell_size,
    glyph_size,
    depth
) {
    glyph_contact_sheet(
        ids,
        records,
        source[FS_KIND],
        source[FS_FONT_NAME],
        columns,
        cell_size,
        glyph_size,
        depth
    );
}
