//////////////////////////////////////////////////////////////////////
// LibFile: normalization.scad
// Project: Glyph Dossier
// FileGroup: Normalization Mathematics
// FileSummary: Manual-bound scale and final-dimension calculations.
//////////////////////////////////////////////////////////////////////

function profile_bounds_known(
    left,
    right,
    bottom,
    top
) =
    left != OBS_UNKNOWN
    && right != OBS_UNKNOWN
    && bottom != OBS_UNKNOWN
    && top != OBS_UNKNOWN;

function profile_bounds_valid(
    left,
    right,
    bottom,
    top
) =
    profile_bounds_known(left, right, bottom, top)
    && left < right
    && bottom < top;

function profile_observed_width(left, right) =
    right - left;

function profile_observed_height(bottom, top) =
    top - bottom;

function exact_height_scale(
    target_height,
    observed_bottom,
    observed_top
) =
    target_height
    / profile_observed_height(
        observed_bottom,
        observed_top
    );

function normalized_profile_width(
    target_height,
    observed_left,
    observed_right,
    observed_bottom,
    observed_top
) =
    profile_observed_width(
        observed_left,
        observed_right
    )
    * exact_height_scale(
        target_height,
        observed_bottom,
        observed_top
    );

function normalized_center_shift_x(
    observed_left,
    observed_right,
    scale_factor
) =
    -(
        observed_left + observed_right
    ) / 2 * scale_factor;

function normalized_bottom_shift_y(
    observed_bottom,
    scale_factor
) =
    -observed_bottom * scale_factor;
