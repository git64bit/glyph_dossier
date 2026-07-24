//////////////////////////////////////////////////////////////////////
// LibFile: source_sample.scad
// Project: Glyph Dossier
// FileGroup: Source Diagnostic Rendering
// FileSummary: Four-line representative source specimen.
//////////////////////////////////////////////////////////////////////

SOURCE_SAMPLE_LINES = [
    "ABOSZ",
    "agijms",
    "01248",
    "?!:;"
];

module render_source_sample(
    source,
    sample_size,
    depth,
    line_gap
) {
    for (index = [0 : len(SOURCE_SAMPLE_LINES) - 1])
        translate([
            0,
            -index * sample_size * line_gap,
            0
        ])
            linear_extrude(height = depth)
                font_text_2d(
                    SOURCE_SAMPLE_LINES[index],
                    source[FS_FONT_NAME],
                    sample_size,
                    "center",
                    "baseline"
                );
}
