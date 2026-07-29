//////////////////////////////////////////////////////////////////////
// LibFile: manifest.scad
// Project: Glyph Dossier
// FileGroup: Procedural Segmented Source Set
// FileSummary: PROCEDURAL_14_SEGMENT_EXTENDED_R1 immutable manifest.
//////////////////////////////////////////////////////////////////////

include <template.scad>
include <mappings_uppercase.scad>
include <mappings_lowercase.scad>
include <mappings_digits_punctuation.scad>

S14R1_MAPPINGS = concat(
    S14R1_UPPERCASE_MAPPINGS,
    S14R1_LOWERCASE_MAPPINGS,
    S14R1_DIGITS_PUNCTUATION_MAPPINGS
);

S14R1_SOURCE_SET = segmented_source_set(
    "PROCEDURAL_14_SEGMENT_EXTENDED_R1",
    "Procedural 14 Segment Extended",
    "Regular",
    "1",
    "Project-authored; repository terms",
    "procedural_segment_adapter",
    "9cba58270b1642bb91ac32f12fa77be13be1e1519da1712f90ff1b618b216e06",
    S14R1_TEMPLATE,
    S14R1_MAPPINGS
);
