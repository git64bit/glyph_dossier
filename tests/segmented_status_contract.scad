    //////////////////////////////////////////////////////////////////////
    // LibFile: segmented_status_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Visible, intentional blank, and unsupported semantics.
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


    set7 = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        "PROCEDURAL_7_SEGMENT_EXTENDED_R1"
    );
    digit8 = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "D_8"
    );
    blank = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "P_exclamation"
    );
    unsupported = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "U_A"
    );

    assert(segmented_mapping_is_visible(digit8));
    assert(
        len(segmented_mapping_region(set7, digit8))
            == 7
    );

    assert(segmented_mapping_is_blank(blank));
    assert(
        len(segmented_mapping_region(set7, blank))
            == 0
    );
    assert(
        len(blank[SM_ACTIVE_SEGMENTS]) == 0
    );

    assert(
        segmented_mapping_is_unsupported(
            unsupported
        )
    );
    assert(
        len(
            segmented_mapping_region(
                set7,
                unsupported
            )
        ) == 0
    );

    echo("PASS", "segmented_status_contract");
