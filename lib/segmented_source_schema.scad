//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_schema.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Schema
// FileSummary: Immutable templates, mappings, and source sets.
//////////////////////////////////////////////////////////////////////

SE_ID = 0;
SE_PATH = 1;

ST_ID = 0;
ST_WIDTH = 1;
ST_HEIGHT = 2;
ST_ADVANCE_WIDTH = 3;
ST_ELEMENTS = 4;

SM_GLYPH_ID = 0;
SM_CHARACTER = 1;
SM_CODEPOINT = 2;
SM_GROUP = 3;
SM_STATUS = 4;
SM_ACTIVE_SEGMENTS = 5;
SM_NOTES = 6;

SSS_ID = 0;
SSS_FAMILY = 1;
SSS_STYLE = 2;
SSS_VERSION = 3;
SSS_LICENSE = 4;
SSS_SOURCE_KIND = 5;
SSS_FINGERPRINT = 6;
SSS_TEMPLATE = 7;
SSS_MAPPINGS = 8;

SEGMENT_STATUS_VISIBLE = "visible";
SEGMENT_STATUS_INTENTIONAL_BLANK =
    "intentional_blank";
SEGMENT_STATUS_UNSUPPORTED = "unsupported";

VALID_SEGMENT_MAPPING_STATUSES = [
    SEGMENT_STATUS_VISIBLE,
    SEGMENT_STATUS_INTENTIONAL_BLANK,
    SEGMENT_STATUS_UNSUPPORTED
];

function segment_element(element_id, path) = [
    element_id,
    path
];

function segment_template(
    template_id,
    width,
    height,
    advance_width,
    elements
) = [
    template_id,
    width,
    height,
    advance_width,
    elements
];

function segment_mapping(
    glyph_id,
    character,
    codepoint,
    group_name,
    status,
    active_segments,
    notes
) = [
    glyph_id,
    character,
    codepoint,
    group_name,
    status,
    active_segments,
    notes
];

function segmented_source_set(
    set_id,
    family,
    style,
    version,
    license_name,
    source_kind,
    fingerprint,
    template,
    mappings
) = [
    set_id,
    family,
    style,
    version,
    license_name,
    source_kind,
    fingerprint,
    template,
    mappings
];
