//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_family_scenes.scad
// Project: Glyph Dossier
// FileGroup: Multi-Family Portable Scenes
// FileSummary: Same glyph rendered across every registered family.
//////////////////////////////////////////////////////////////////////

module portable_font_family_comparison(
    set_records,
    glyph_id,
    target_height,
    depth,
    spacing
) {
    count = len(set_records);
    for (index = [0 : count - 1]) {
        set_record = set_records[index];
        glyph = portable_glyph_by_id(
            set_record[PFS_GLYPHS],
            glyph_id
        );
        x = (index - (count - 1) / 2) * spacing;
        echo("PORTABLE_FAMILY_COMPARISON_ENTRY", [
            index,
            set_record[PFS_ID],
            glyph_id,
            portable_normalized_width(glyph, target_height)
        ]);
        translate([x, 0, 0])
            color(portable_component_color(index))
                portable_glyph_3d(glyph, target_height, depth);
    }
}
