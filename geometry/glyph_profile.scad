//////////////////////////////////////////////////////////////////////
// LibFile: glyph_profile.scad
// Project: Glyph Dossier
// FileGroup: Source Adapter
// FileSummary: Font-backed 2D and extruded glyph profiles.
//////////////////////////////////////////////////////////////////////

module font_glyph_2d(glyph, font_name, nominal_size) {
    if (font_name == "")
        text(
            text = glyph,
            size = nominal_size,
            halign = "center",
            valign = "baseline"
        );
    else
        text(
            text = glyph,
            size = nominal_size,
            font = font_name,
            halign = "center",
            valign = "baseline"
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
        str("Batch 001 does not implement source kind: ", source_kind)
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
