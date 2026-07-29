    //////////////////////////////////////////////////////////////////////
    // LibFile: segmented_adapter_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Every visible mask becomes a valid portable glyph.
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


    visible_count = sum([
        for (source_set = SEGMENTED_SOURCE_SETS)
            len(
                segmented_visible_mappings(
                    source_set[SSS_MAPPINGS]
                )
            )
    ]);

    assert(visible_count == 79);

    for (source_set = SEGMENTED_SOURCE_SETS)
        for (
            mapping =
                segmented_visible_mappings(
                    source_set[SSS_MAPPINGS]
                )
        ) {
            glyph = segmented_portable_glyph(
                source_set,
                mapping
            );

            validate_portable_glyph(glyph);
            assert(
                glyph[PG_SOURCE_SHA256]
                    == source_set[SSS_FINGERPRINT]
            );
            assert(
                glyph[PG_COMPONENT_COUNT]
                    == len(
                        mapping[SM_ACTIVE_SEGMENTS]
                    )
            );
            assert(
                portable_normalized_height(
                    glyph,
                    137
                ) == 137
            );
        }

    echo(
        "SEGMENTED_VISIBLE_ADAPTER_COUNT",
        visible_count
    );
    echo("PASS", "segmented_adapter_contract");
