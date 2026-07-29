    //////////////////////////////////////////////////////////////////////
    // LibFile: segmented_schema_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Two exact source sets and complete identity matrices.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_glyph_validation.scad>
include <../lib/sectioning.scad>
include <../lib/portable_generic_sectioning.scad>
include <../lib/portable_section_occupancy_schema.scad>
include <../lib/portable_section_occupancy.scad>
include <../lib/segmented_source_schema.scad>
include <../lib/segmented_source_lookup.scad>
include <../lib/segmented_source_adapter.scad>
include <../lib/segmented_source_validation.scad>
include <../registries/segmented_source_sets.scad>
include <../geometry/portable_glyph_region.scad>


    assert(len(SEGMENTED_SOURCE_SETS) == 2);
    assert(
        SEGMENTED_SOURCE_SET_IDS == [
            "PROCEDURAL_14_SEGMENT_EXTENDED_R1",
            "PROCEDURAL_7_SEGMENT_EXTENDED_R1"
        ]
    );

    for (source_set = SEGMENTED_SOURCE_SETS) {
        validate_segmented_source_set(source_set);
        assert(len(source_set[SSS_MAPPINGS]) == 66);
        assert(
            len(source_set[SSS_FINGERPRINT]) == 64
        );
    }

    set14 = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        "PROCEDURAL_14_SEGMENT_EXTENDED_R1"
    );
    set7 = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        "PROCEDURAL_7_SEGMENT_EXTENDED_R1"
    );

    assert(
        len(set14[SSS_TEMPLATE][ST_ELEMENTS]) == 17
    );
    assert(
        len(set7[SSS_TEMPLATE][ST_ELEMENTS]) == 10
    );
    assert(
        len(segmented_visible_mappings(
            set14[SSS_MAPPINGS]
        )) == 66
    );
    assert(
        len(segmented_visible_mappings(
            set7[SSS_MAPPINGS]
        )) == 13
    );
    assert(
        len(segmented_blank_mappings(
            set7[SSS_MAPPINGS]
        )) == 1
    );
    assert(
        len(segmented_unsupported_mappings(
            set7[SSS_MAPPINGS]
        )) == 52
    );

    echo("PASS", "segmented_schema_contract");
