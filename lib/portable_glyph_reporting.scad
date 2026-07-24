//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_reporting.scad
// Project: Glyph Dossier
// FileGroup: Portable Console Reporting
// FileSummary: Reports captured source and BOSL2 region metadata.
//////////////////////////////////////////////////////////////////////

module report_portable_set() {
    echo("PORTABLE_SET_ID", PORTABLE_GLYPH_SET_ID);
    echo("PORTABLE_SET_FAMILY", PORTABLE_GLYPH_FAMILY);
    echo("PORTABLE_SET_STYLE", PORTABLE_GLYPH_STYLE);
    echo("PORTABLE_SET_FONT_VERSION", PORTABLE_GLYPH_FONT_VERSION);
    echo("PORTABLE_SET_LICENSE", PORTABLE_GLYPH_LICENSE);
    echo("PORTABLE_SET_SOURCE_URL", PORTABLE_GLYPH_SOURCE_URL);
    echo("PORTABLE_SET_SOURCE_SHA256", PORTABLE_GLYPH_SOURCE_SHA256);
    echo("PORTABLE_SET_FLATTEN_TOLERANCE", PORTABLE_GLYPH_FLATTEN_TOLERANCE);
    echo("PORTABLE_SET_GLYPH_COUNT", len(PORTABLE_GLYPHS));
    echo("PORTABLE_SET_UPPERCASE_COUNT", len(PORTABLE_UPPERCASE_IDS));
    echo("PORTABLE_SET_LOWERCASE_COUNT", len(PORTABLE_LOWERCASE_IDS));
    echo("PORTABLE_SET_DIGIT_COUNT", len(PORTABLE_DIGIT_IDS));
    echo("PORTABLE_SET_PUNCTUATION_COUNT", len(PORTABLE_PUNCTUATION_IDS));
    echo("PORTABLE_SET_REPRESENTATIVE_COUNT", len(PORTABLE_REPRESENTATIVE_IDS));
    echo("PORTABLE_SET_BOSL2_INCLUDE", "BOSL2/std.scad");
}

module report_portable_glyph(glyph) {
    echo("PORTABLE_GLYPH_ID", glyph[PG_ID]);
    echo("PORTABLE_GLYPH_CHARACTER", glyph[PG_CHARACTER]);
    echo("PORTABLE_GLYPH_CODEPOINT", glyph[PG_CODEPOINT]);
    echo("PORTABLE_GLYPH_NAME", glyph[PG_GLYPH_NAME]);
    echo("PORTABLE_GLYPH_UNITS_PER_EM", glyph[PG_UNITS_PER_EM]);
    echo("PORTABLE_GLYPH_ADVANCE_WIDTH", glyph[PG_ADVANCE_WIDTH]);
    echo("PORTABLE_GLYPH_EXACT_BOUNDS", glyph[PG_EXACT_BOUNDS]);
    echo("PORTABLE_GLYPH_REGION_BOUNDS", glyph[PG_REGION_BOUNDS]);
    echo("PORTABLE_GLYPH_CONTOURS", glyph[PG_CONTOUR_COUNT]);
    echo("PORTABLE_GLYPH_COMPONENTS", glyph[PG_COMPONENT_COUNT]);
    echo("PORTABLE_GLYPH_COUNTERS", glyph[PG_COUNTER_COUNT]);
    echo("PORTABLE_GLYPH_POINTS", glyph[PG_POINT_COUNT]);
    echo("PORTABLE_GLYPH_BOSL2_VALID", is_valid_region(glyph[PG_REGION]));
    echo("PORTABLE_GLYPH_BOSL2_AREA", region_area(glyph[PG_REGION]));
}
