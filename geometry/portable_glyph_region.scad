//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_region.scad
// Project: Glyph Dossier
// FileGroup: BOSL2 Portable Geometry
// FileSummary: Normalizes and renders captured point-list regions.
//////////////////////////////////////////////////////////////////////

function portable_target_scale(glyph, target_height) =
    target_height / portable_glyph_height(glyph);

function portable_normalized_region(glyph, target_height) =
    let(
        bounds = glyph[PG_REGION_BOUNDS],
        scale_factor = portable_target_scale(glyph, target_height),
        center_x = (bounds[0] + bounds[2]) / 2,
        bottom_y = bounds[1]
    )
    [
        for (path = glyph[PG_REGION])
            [
                for (point = path)
                    [
                        (point[0] - center_x) * scale_factor,
                        (point[1] - bottom_y) * scale_factor
                    ]
            ]
    ];

function portable_normalized_width(glyph, target_height) =
    portable_glyph_width(glyph)
    * portable_target_scale(glyph, target_height);

module portable_glyph_2d(glyph, target_height) {
    region(portable_normalized_region(glyph, target_height));
}

module portable_glyph_3d(glyph, target_height, depth) {
    linear_extrude(height = depth)
        portable_glyph_2d(glyph, target_height);
}
