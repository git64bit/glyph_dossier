    //////////////////////////////////////////////////////////////////////
    // LibFile: segmented_render_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: State and portable pipeline scenes render together.
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

    include <../geometry/section_grid.scad>
    include <../geometry/portable_normalized_profile_scene.scad>
    include <../geometry/portable_generic_section_scene.scad>
    include <../geometry/portable_section_occupancy_scene.scad>
    include <../geometry/segmented_source_scene.scad>

    set14 = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        "PROCEDURAL_14_SEGMENT_EXTENDED_R1"
    );
    set7 = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        "PROCEDURAL_7_SEGMENT_EXTENDED_R1"
    );

    mapping14 = segment_mapping_by_id(
        set14[SSS_MAPPINGS],
        "U_A"
    );
    blank7 = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "P_exclamation"
    );
    unsupported7 = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "U_A"
    );
    digit7 = segment_mapping_by_id(
        set7[SSS_MAPPINGS],
        "D_8"
    );
    glyph7 = segmented_portable_glyph(
        set7,
        digit7
    );

    translate([-240, 0, 0])
        segmented_source_state_3d(
            set14,
            mapping14,
            3,
            true,
            true,
            1
        );

    translate([-80, 0, 0])
        segmented_source_state_3d(
            set7,
            blank7,
            3,
            true,
            true,
            1
        );

    translate([80, 0, 0])
        segmented_source_state_3d(
            set7,
            unsupported7,
            3,
            false,
            true,
            1
        );

    translate([240, 0, 0])
        portable_generic_normalized_profile(
            glyph7,
            120,
            3,
            true,
            1
        );

    echo("PASS", "segmented_render_contract");
