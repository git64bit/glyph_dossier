//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_schema.scad
// Project: Glyph Dossier
// FileGroup: Portable Font Set Schema
// FileSummary: Immutable metadata and glyph-array identity per family.
//////////////////////////////////////////////////////////////////////

PFS_ID = 0;
PFS_FAMILY = 1;
PFS_STYLE = 2;
PFS_FONT_VERSION = 3;
PFS_LICENSE = 4;
PFS_SOURCE_URL = 5;
PFS_SOURCE_FILENAME = 6;
PFS_SOURCE_SHA256 = 7;
PFS_FLATTEN_TOLERANCE = 8;
PFS_GLYPHS = 9;

function portable_font_set(
    set_id,
    family,
    style,
    font_version,
    license_name,
    source_url,
    source_filename,
    source_sha256,
    flatten_tolerance,
    glyphs
) = [
    set_id,
    family,
    style,
    font_version,
    license_name,
    source_url,
    source_filename,
    source_sha256,
    flatten_tolerance,
    glyphs
];
