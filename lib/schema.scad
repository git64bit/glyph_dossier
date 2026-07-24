//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Glyph Dossier
// FileGroup: Record Schema
// FileSummary: Project, glyph, source, and observation records.
//////////////////////////////////////////////////////////////////////

PR_NAME = 0;
PR_KIND = 1;
PR_EDITION = 2;
PR_SCOPE = 3;
PR_BASELINE = 4;
PR_STATUS = 5;

function glyph_project(
    name,
    kind,
    edition,
    scope,
    baseline,
    status
) = [
    name,
    kind,
    edition,
    scope,
    baseline,
    status
];

GD_ID = 0;
GD_GLYPH = 1;
GD_GROUP = 2;
GD_ARCHETYPE = 3;
GD_COMPONENTS_MIN = 4;
GD_COMPONENTS_MAX = 5;
GD_COUNTERS_MIN = 6;
GD_COUNTERS_MAX = 7;
GD_VERTICAL_CLASS = 8;
GD_FEATURES = 9;
GD_RISKS = 10;
GD_VARIANTS = 11;
GD_PRIORITY = 12;
GD_NOTE = 13;

function glyph_dossier(
    id,
    glyph,
    group,
    archetype,
    components_min,
    components_max,
    counters_min,
    counters_max,
    vertical_class,
    features,
    risks,
    variants,
    priority,
    note
) = [
    id,
    glyph,
    group,
    archetype,
    components_min,
    components_max,
    counters_min,
    counters_max,
    vertical_class,
    features,
    risks,
    variants,
    priority,
    note
];

FS_ID = 0;
FS_KIND = 1;
FS_LABEL = 2;
FS_FONT_NAME = 3;
FS_LICENSE = 4;
FS_URL = 5;
FS_REVISION = 6;
FS_STATUS = 7;

function font_source(
    id,
    kind,
    label,
    font_name,
    license_name,
    source_url,
    revision,
    status
) = [
    id,
    kind,
    label,
    font_name,
    license_name,
    source_url,
    revision,
    status
];

OBS_UNKNOWN = -999999;

OB_ID = 0;
OB_SOURCE_ID = 1;
OB_GLYPH_ID = 2;
OB_STATUS = 3;
OB_VARIANT = 4;
OB_COMPONENTS = 5;
OB_COUNTERS = 6;
OB_LEFT = 7;
OB_RIGHT = 8;
OB_BOTTOM = 9;
OB_TOP = 10;
OB_MIN_STROKE = 11;
OB_MIN_GAP = 12;
OB_NOTE = 13;

function glyph_observation(
    id,
    source_id,
    glyph_id,
    status,
    variant,
    components,
    counters,
    left_extent,
    right_extent,
    bottom_extent,
    top_extent,
    minimum_stroke,
    minimum_gap,
    note
) = [
    id,
    source_id,
    glyph_id,
    status,
    variant,
    components,
    counters,
    left_extent,
    right_extent,
    bottom_extent,
    top_extent,
    minimum_stroke,
    minimum_gap,
    note
];

function observation_value_known(value) =
    value != OBS_UNKNOWN;

function observation_has_bounds(observation) =
    observation_value_known(observation[OB_LEFT])
    && observation_value_known(observation[OB_RIGHT])
    && observation_value_known(observation[OB_BOTTOM])
    && observation_value_known(observation[OB_TOP]);

function observation_width(observation) =
    observation_has_bounds(observation)
    ? observation[OB_RIGHT] - observation[OB_LEFT]
    : OBS_UNKNOWN;

function observation_height(observation) =
    observation_has_bounds(observation)
    ? observation[OB_TOP] - observation[OB_BOTTOM]
    : OBS_UNKNOWN;

function record_name(record) = record[0];
