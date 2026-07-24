//////////////////////////////////////////////////////////////////////
// LibFile: normalization_math_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Manual-bound exact-height calculations.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../lib/normalization.scad>

left = 10;
right = 80;
bottom = -5;
top = 65;
target = 700;

assert(
    profile_bounds_known(
        left,
        right,
        bottom,
        top
    )
);
assert(
    profile_bounds_valid(
        left,
        right,
        bottom,
        top
    )
);
assert(profile_observed_width(left, right) == 70);
assert(profile_observed_height(bottom, top) == 70);
assert(exact_height_scale(target, bottom, top) == 10);
assert(
    normalized_profile_width(
        target,
        left,
        right,
        bottom,
        top
    ) == 700
);
assert(
    normalized_center_shift_x(
        left,
        right,
        10
    ) == -450
);
assert(
    normalized_bottom_shift_y(
        bottom,
        10
    ) == 50
);

echo("PASS", "normalization_math_contract");
