//////////////////////////////////////////////////////////////////////
// LibFile: source_comparison.scad
// Project: Glyph Dossier
// FileGroup: Source Diagnostic Rendering
// FileSummary: Same glyph rendered across exact source identities.
//////////////////////////////////////////////////////////////////////

module render_source_comparison(
    dossier,
    sources,
    source_ids,
    nominal_size,
    depth,
    spacing
) {
    for (index = [0 : len(source_ids) - 1]) {
        source = named_record(
            sources,
            source_ids[index],
            "comparison source"
        );
        x = (
            index - (len(source_ids) - 1) / 2
        ) * spacing;

        color([0.88, 0.68, 0.24])
            translate([x, 0, 0])
                glyph_source_record_3d(
                    dossier,
                    source,
                    nominal_size,
                    depth
                );
    }
}
