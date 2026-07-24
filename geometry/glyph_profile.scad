//////////////////////////////////////////////////////////////////////
// LibFile: glyph_profile.scad
// Project: Glyph Dossier
// FileGroup: Source Adapter
// FileSummary: Font-backed text, glyph, source, and extrusion adapters.
//////////////////////////////////////////////////////////////////////

module font_text_2d(
    value,
    font_name,
    nominal_size,
    halign_value = "center",
    valign_value = "baseline"
) {
    if (font_name == "")
        text(
            text = value,
            size = nominal_size,
            halign = halign_value,
            valign = valign_value
        );
    else
        text(
            text = value,
            size = nominal_size,
            font = font_name,
            halign = halign_value,
            valign = valign_value
        );
}

module font_glyph_2d(glyph, font_name, nominal_size) {
    font_text_2d(
        glyph,
        font_name,
        nominal_size,
        "center",
        "baseline"
    );
}

module glyph_source_2d(
    dossier,
    source_kind,
    font_name,
    nominal_size
) {
    assert(
        source_kind == "font",
        str("Source adapter does not implement kind: ", source_kind)
    );

    font_glyph_2d(
        dossier[GD_GLYPH],
        font_name,
        nominal_size
    );
}

module glyph_profile_3d(
    dossier,
    source_kind,
    font_name,
    nominal_size,
    depth
) {
    linear_extrude(height = depth)
        glyph_source_2d(
            dossier,
            source_kind,
            font_name,
            nominal_size
        );
}

module glyph_source_record_2d(
    dossier,
    source,
    nominal_size
) {
    glyph_source_2d(
        dossier,
        source[FS_KIND],
        source[FS_FONT_NAME],
        nominal_size
    );
}

module glyph_source_record_3d(
    dossier,
    source,
    nominal_size,
    depth
) {
    glyph_profile_3d(
        dossier,
        source[FS_KIND],
        source[FS_FONT_NAME],
        nominal_size,
        depth
    );
}
