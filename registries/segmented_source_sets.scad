//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_sets.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Registry
// FileSummary: Project-authored procedural segment adapters.
//////////////////////////////////////////////////////////////////////

include <../segment_sets/procedural_14_segment_extended/manifest.scad>
include <../segment_sets/procedural_7_segment_extended/manifest.scad>

SEGMENTED_SOURCE_SETS = [
    S14R1_SOURCE_SET,
    S7R1_SOURCE_SET
];

SEGMENTED_SOURCE_SET_IDS = [
    for (source_set = SEGMENTED_SOURCE_SETS)
        source_set[SSS_ID]
];
