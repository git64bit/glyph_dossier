//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_scenes.scad
// Project: Glyph Dossier
// FileGroup: Portable Diagnostic Rendering
// FileSummary: Single, contact, component, and live comparison views.
//////////////////////////////////////////////////////////////////////

module portable_contact_sheet(
    ids,
    records,
    columns,
    cell_size,
    glyph_height,
    depth
) {
    rows = ceil(len(ids) / columns);

    for (index = [0 : len(ids) - 1]) {
        glyph = portable_glyph_by_id(records, ids[index]);
        column = index % columns;
        row = floor(index / columns);
        x = (column - (columns - 1) / 2) * cell_size;
        y = ((rows - 1) / 2 - row) * cell_size;

        translate([x, y, 0])
            color([0.88, 0.68, 0.24])
                portable_glyph_3d(
                    glyph,
                    glyph_height,
                    depth
                );
    }
}

function portable_component_color(index) = [
    ((index + 1) % 3 == 0) ? 0.80 : 0.25,
    ((index + 1) % 3 == 1) ? 0.80 : 0.25,
    ((index + 1) % 3 == 2) ? 0.80 : 0.25
];

module portable_component_diagnostics(
    glyph,
    target_height,
    depth
) {
    normalized = portable_normalized_region(
        glyph,
        target_height
    );
    parts = region_parts(normalized);

    for (index = [0 : len(parts) - 1])
        color(portable_component_color(index))
            linear_extrude(height = depth)
                region(parts[index]);
}

module portable_live_comparison(
    glyph,
    target_height,
    depth,
    live_font_name,
    spacing
) {
    translate([-spacing / 2, 0, 0])
        color([0.35, 0.55, 0.85])
            linear_extrude(height = depth)
                resize(
                    [0, target_height],
                    auto = [true, false]
                )
                    text(
                        glyph[PG_CHARACTER],
                        size = 100,
                        font = live_font_name,
                        halign = "center",
                        valign = "bottom"
                    );

    translate([spacing / 2, 0, 0])
        color([0.88, 0.68, 0.24])
            portable_glyph_3d(
                glyph,
                target_height,
                depth
            );
}
