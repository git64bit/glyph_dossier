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


function portable_normalized_height(glyph, target_height) =
    portable_glyph_height(glyph)
    * portable_target_scale(glyph, target_height);

function portable_normalized_left(glyph, target_height) =
    -portable_normalized_width(glyph, target_height) / 2;

function portable_normalized_right(glyph, target_height) =
    portable_normalized_width(glyph, target_height) / 2;

function portable_normalized_bottom(glyph, target_height) =
    0;

function portable_normalized_top(glyph, target_height) =
    portable_normalized_height(glyph, target_height);

function portable_normalized_bounds(glyph, target_height) = [
    portable_normalized_left(glyph, target_height),
    portable_normalized_bottom(glyph, target_height),
    portable_normalized_right(glyph, target_height),
    portable_normalized_top(glyph, target_height)
];

function portable_source_center_x(glyph) =
    (
        glyph[PG_REGION_BOUNDS][0]
        + glyph[PG_REGION_BOUNDS][2]
    ) / 2;

function portable_source_bottom(glyph) =
    glyph[PG_REGION_BOUNDS][1];

function portable_source_top(glyph) =
    glyph[PG_REGION_BOUNDS][3];

function portable_source_baseline_offset(glyph) =
    -portable_source_bottom(glyph);

function portable_normalized_baseline_y(
    glyph,
    target_height
) =
    portable_source_baseline_offset(glyph)
    * portable_target_scale(glyph, target_height);

function portable_normalized_advance_width(
    glyph,
    target_height
) =
    glyph[PG_ADVANCE_WIDTH]
    * portable_target_scale(glyph, target_height);

module portable_glyph_2d(glyph, target_height) {
    region(portable_normalized_region(glyph, target_height));
}

module portable_glyph_3d(glyph, target_height, depth) {
    linear_extrude(height = depth)
        portable_glyph_2d(glyph, target_height);
}
