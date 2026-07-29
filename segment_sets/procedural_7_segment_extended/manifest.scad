//////////////////////////////////////////////////////////////////////
// LibFile: manifest.scad
// Project: Glyph Dossier
// FileGroup: Procedural Segmented Source Set
// FileSummary: PROCEDURAL_7_SEGMENT_EXTENDED_R1 immutable manifest.
//////////////////////////////////////////////////////////////////////

include <template.scad>
include <mappings_uppercase.scad>
include <mappings_lowercase.scad>
include <mappings_digits_punctuation.scad>

S7R1_MAPPINGS = concat(
    S7R1_UPPERCASE_MAPPINGS,
    S7R1_LOWERCASE_MAPPINGS,
    S7R1_DIGITS_PUNCTUATION_MAPPINGS
);

S7R1_SOURCE_SET = segmented_source_set(
    "PROCEDURAL_7_SEGMENT_EXTENDED_R1",
    "Procedural 7 Segment Extended",
    "Regular",
    "1",
    "Project-authored; repository terms",
    "procedural_segment_adapter",
    "59d7b03feec0020b616571bda1bd6d287acfc1a78ed147ca39c920fc8a12f867",
    S7R1_TEMPLATE,
    S7R1_MAPPINGS
);
