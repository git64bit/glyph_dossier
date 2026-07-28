//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_validation.scad
// Project: Glyph Dossier
// FileGroup: Portable Font Set Validation
// FileSummary: Validates isolated 66-glyph family packages.
//////////////////////////////////////////////////////////////////////

module validate_portable_font_set(set_record) {
    assert(len(set_record) == 10, "Portable font set record length changed.");
    assert(len(set_record[PFS_ID]) > 0, "Portable font set ID is empty.");
    assert(len(set_record[PFS_FAMILY]) > 0, "Portable family is empty.");
    assert(len(set_record[PFS_STYLE]) > 0, "Portable style is empty.");
    assert(
        len(set_record[PFS_GLYPHS]) == 66,
        str(
            "Expected 66 glyphs in ",
            set_record[PFS_ID],
            "; found ",
            len(set_record[PFS_GLYPHS])
        )
    );

    for (glyph = set_record[PFS_GLYPHS]) {
        validate_portable_glyph(glyph);
        assert(
            glyph[PG_SOURCE_SHA256] == set_record[PFS_SOURCE_SHA256],
            str("Source checksum mismatch: ", set_record[PFS_ID], " ", glyph[PG_ID])
        );
        assert(
            portable_glyph_id_count(set_record[PFS_GLYPHS], glyph[PG_ID]) == 1,
            str("Duplicate glyph ID inside ", set_record[PFS_ID], ": ", glyph[PG_ID])
        );
    }
}

module validate_portable_font_registry(records) {
    assert(len(records) >= 2, "Multi-family registry requires at least two sets.");
    for (set_record = records) {
        validate_portable_font_set(set_record);
        assert(
            portable_font_set_id_count(records, set_record[PFS_ID]) == 1,
            str("Duplicate portable set ID: ", set_record[PFS_ID])
        );
    }
}
