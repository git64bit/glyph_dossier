//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_schema.scad
// Project: Glyph Dossier
// FileGroup: Portable Glyph Record Schema
// FileSummary: Indexes for generated source-independent glyph records.
//////////////////////////////////////////////////////////////////////

PG_ID = 0;
PG_CHARACTER = 1;
PG_CODEPOINT = 2;
PG_GLYPH_NAME = 3;
PG_UNITS_PER_EM = 4;
PG_ADVANCE_WIDTH = 5;
PG_EXACT_BOUNDS = 6;
PG_REGION_BOUNDS = 7;
PG_CONTOUR_COUNT = 8;
PG_COMPONENT_COUNT = 9;
PG_COUNTER_COUNT = 10;
PG_POINT_COUNT = 11;
PG_FLATTEN_TOLERANCE = 12;
PG_SOURCE_SHA256 = 13;
PG_REGION = 14;

function portable_glyph_width(glyph) =
    glyph[PG_REGION_BOUNDS][2]
    - glyph[PG_REGION_BOUNDS][0];

function portable_glyph_height(glyph) =
    glyph[PG_REGION_BOUNDS][3]
    - glyph[PG_REGION_BOUNDS][1];

function portable_region_point_count(region_data) =
    sum([for (path = region_data) len(path)]);
