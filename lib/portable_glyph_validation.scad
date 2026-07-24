//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_validation.scad
// Project: Glyph Dossier
// FileGroup: BOSL2 Portable Validation
// FileSummary: Validates captured records and BOSL2 regions.
//////////////////////////////////////////////////////////////////////

module validate_portable_glyph(glyph) {
    assert(
        len(glyph) == 15,
        str("Portable glyph record length is ", len(glyph))
    );
    assert(len(glyph[PG_ID]) > 0, "Portable glyph ID is empty.");
    assert(
        len(glyph[PG_CHARACTER]) == 1,
        str("Portable character is invalid: ", glyph[PG_ID])
    );
    assert(
        glyph[PG_CODEPOINT] >= 0,
        str("Portable codepoint is invalid: ", glyph[PG_ID])
    );
    assert(
        glyph[PG_UNITS_PER_EM] > 0,
        str("Units per em is invalid: ", glyph[PG_ID])
    );
    assert(
        portable_glyph_width(glyph) > 0
        && portable_glyph_height(glyph) > 0,
        str("Portable bounds are invalid: ", glyph[PG_ID])
    );
    assert(
        len(glyph[PG_REGION]) == glyph[PG_CONTOUR_COUNT],
        str("Contour count mismatch: ", glyph[PG_ID])
    );
    assert(
        portable_region_point_count(glyph[PG_REGION])
            == glyph[PG_POINT_COUNT],
        str("Point count mismatch: ", glyph[PG_ID])
    );
    assert(
        glyph[PG_COMPONENT_COUNT]
            + glyph[PG_COUNTER_COUNT]
            == glyph[PG_CONTOUR_COUNT],
        str("Component/counter count mismatch: ", glyph[PG_ID])
    );
    assert(
        is_region(glyph[PG_REGION]),
        str("BOSL2 does not recognize region structure: ", glyph[PG_ID])
    );
    assert(
        is_valid_region(glyph[PG_REGION]),
        str("BOSL2 region is invalid: ", glyph[PG_ID])
    );
    assert(
        len(region_parts(glyph[PG_REGION]))
            == glyph[PG_COMPONENT_COUNT],
        str("BOSL2 component count mismatch: ", glyph[PG_ID])
    );
}

module validate_portable_glyph_set(records) {
    assert(
        len(records) == 66,
        str("Expected 66 captured glyphs; found ", len(records))
    );

    for (glyph = records) {
        validate_portable_glyph(glyph);
        assert(
            portable_glyph_id_count(records, glyph[PG_ID]) == 1,
            str("Duplicate portable glyph ID: ", glyph[PG_ID])
        );
        assert(
            glyph[PG_SOURCE_SHA256]
                == PORTABLE_GLYPH_SOURCE_SHA256,
            str("Source checksum mismatch: ", glyph[PG_ID])
        );
    }
}
