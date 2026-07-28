//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_sets.scad
// Project: Glyph Dossier
// FileGroup: Portable Font Set Registry
// FileSummary: Six isolated portable font families.
//////////////////////////////////////////////////////////////////////

include <../glyph_sets/montserrat_regular/manifest.scad>
include <../glyph_sets/alpha_slab_one_regular/manifest.scad>
include <../glyph_sets/fira_sans_regular/manifest.scad>
include <../glyph_sets/miama_nueva_medium/manifest.scad>
include <../glyph_sets/playfair_display_regular/manifest.scad>

LIBERATION_SANS_REGULAR_R1_FONT_SET = portable_font_set(
    PORTABLE_GLYPH_SET_ID,
    PORTABLE_GLYPH_FAMILY,
    PORTABLE_GLYPH_STYLE,
    PORTABLE_GLYPH_FONT_VERSION,
    PORTABLE_GLYPH_LICENSE,
    PORTABLE_GLYPH_SOURCE_URL,
    "LiberationSans-Regular.ttf",
    PORTABLE_GLYPH_SOURCE_SHA256,
    PORTABLE_GLYPH_FLATTEN_TOLERANCE,
    PORTABLE_GLYPHS
);

MSR1_FONT_SET = portable_font_set(
    MSR1_SET_ID,
    MSR1_FAMILY,
    MSR1_STYLE,
    MSR1_FONT_VERSION,
    MSR1_LICENSE,
    MSR1_SOURCE_URL,
    MSR1_SOURCE_FILENAME,
    MSR1_SOURCE_SHA256,
    MSR1_FLATTEN_TOLERANCE,
    MSR1_GLYPHS
);
ASOR1_FONT_SET = portable_font_set(
    ASOR1_SET_ID,
    ASOR1_FAMILY,
    ASOR1_STYLE,
    ASOR1_FONT_VERSION,
    ASOR1_LICENSE,
    ASOR1_SOURCE_URL,
    ASOR1_SOURCE_FILENAME,
    ASOR1_SOURCE_SHA256,
    ASOR1_FLATTEN_TOLERANCE,
    ASOR1_GLYPHS
);
FSR1_FONT_SET = portable_font_set(
    FSR1_SET_ID,
    FSR1_FAMILY,
    FSR1_STYLE,
    FSR1_FONT_VERSION,
    FSR1_LICENSE,
    FSR1_SOURCE_URL,
    FSR1_SOURCE_FILENAME,
    FSR1_SOURCE_SHA256,
    FSR1_FLATTEN_TOLERANCE,
    FSR1_GLYPHS
);
MNMR1_FONT_SET = portable_font_set(
    MNMR1_SET_ID,
    MNMR1_FAMILY,
    MNMR1_STYLE,
    MNMR1_FONT_VERSION,
    MNMR1_LICENSE,
    MNMR1_SOURCE_URL,
    MNMR1_SOURCE_FILENAME,
    MNMR1_SOURCE_SHA256,
    MNMR1_FLATTEN_TOLERANCE,
    MNMR1_GLYPHS
);
PDR1_FONT_SET = portable_font_set(
    PDR1_SET_ID,
    PDR1_FAMILY,
    PDR1_STYLE,
    PDR1_FONT_VERSION,
    PDR1_LICENSE,
    PDR1_SOURCE_URL,
    PDR1_SOURCE_FILENAME,
    PDR1_SOURCE_SHA256,
    PDR1_FLATTEN_TOLERANCE,
    PDR1_GLYPHS
);

PORTABLE_FONT_SETS = [
    LIBERATION_SANS_REGULAR_R1_FONT_SET,
    MSR1_FONT_SET,
    ASOR1_FONT_SET,
    FSR1_FONT_SET,
    MNMR1_FONT_SET,
    PDR1_FONT_SET
];

PORTABLE_FONT_SET_IDS = [
    for (set_record = PORTABLE_FONT_SETS)
        set_record[PFS_ID]
];
