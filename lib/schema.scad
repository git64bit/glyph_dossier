//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Glyph Dossier
// FileGroup: Record Schema
// FileSummary: Project and glyph dossier constructors and indexes.
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

function record_name(record) = record[0];
