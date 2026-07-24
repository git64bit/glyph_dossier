//////////////////////////////////////////////////////////////////////
// LibFile: contact_sheet.scad
// Project: Glyph Dossier
// FileGroup: Diagnostic Rendering
// FileSummary: Representative-set preview grid.
//////////////////////////////////////////////////////////////////////

module _contact_cell_frame(cell_size, depth) {
    frame_thickness = 0.8;

    color([0.35, 0.40, 0.48, 0.35])
        linear_extrude(height = depth)
            difference() {
                square(
                    [cell_size, cell_size],
                    center = true
                );
                square(
                    [
                        cell_size - 2 * frame_thickness,
                        cell_size - 2 * frame_thickness
                    ],
                    center = true
                );
            }
}

module glyph_contact_sheet(
    ids,
    records,
    source_kind,
    font_name,
    columns,
    cell_size,
    glyph_size,
    depth
) {
    rows = ceil(len(ids) / columns);

    for (index = [0 : len(ids) - 1]) {
        row = floor(index / columns);
        column = index % columns;
        x = (column - (columns - 1) / 2) * cell_size;
        y = ((rows - 1) / 2 - row) * cell_size;
        dossier = named_record(
            records,
            ids[index],
            "contact-sheet dossier"
        );

        translate([x, y, 0]) {
            _contact_cell_frame(cell_size, 0.6);

            color([0.88, 0.68, 0.24])
                translate([0, -glyph_size * 0.25, 0.8])
                    glyph_profile_3d(
                        dossier,
                        source_kind,
                        font_name,
                        glyph_size,
                        depth
                    );
        }
    }
}
