//////////////////////////////////////////////////////////////////////
// LibFile: segmented_source_reporting.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Reporting
// FileSummary: Reports set, state, mask, and adapter identity.
//////////////////////////////////////////////////////////////////////

module report_segmented_source_set(source_set) {
    echo(
        "SEGMENTED_SOURCE_SET_ID",
        source_set[SSS_ID]
    );
    echo(
        "SEGMENTED_SOURCE_FAMILY",
        source_set[SSS_FAMILY]
    );
    echo(
        "SEGMENTED_SOURCE_STYLE",
        source_set[SSS_STYLE]
    );
    echo(
        "SEGMENTED_SOURCE_VERSION",
        source_set[SSS_VERSION]
    );
    echo(
        "SEGMENTED_SOURCE_KIND",
        source_set[SSS_SOURCE_KIND]
    );
    echo(
        "SEGMENTED_SOURCE_LICENSE",
        source_set[SSS_LICENSE]
    );
    echo(
        "SEGMENTED_SOURCE_FINGERPRINT",
        source_set[SSS_FINGERPRINT]
    );
    echo(
        "SEGMENTED_TEMPLATE_ID",
        source_set[SSS_TEMPLATE][ST_ID]
    );
    echo(
        "SEGMENTED_TEMPLATE_ELEMENT_COUNT",
        len(
            source_set[SSS_TEMPLATE][ST_ELEMENTS]
        )
    );
    echo(
        "SEGMENTED_MAPPING_COUNTS",
        [
            "visible",
            len(
                segmented_visible_mappings(
                    source_set[SSS_MAPPINGS]
                )
            ),
            "intentional_blank",
            len(
                segmented_blank_mappings(
                    source_set[SSS_MAPPINGS]
                )
            ),
            "unsupported",
            len(
                segmented_unsupported_mappings(
                    source_set[SSS_MAPPINGS]
                )
            )
        ]
    );
}

module report_segmented_mapping(
    source_set,
    mapping
) {
    echo(
        "SEGMENTED_MAPPING_GLYPH_ID",
        mapping[SM_GLYPH_ID]
    );
    echo(
        "SEGMENTED_MAPPING_CHARACTER",
        mapping[SM_CHARACTER]
    );
    echo(
        "SEGMENTED_MAPPING_CODEPOINT",
        mapping[SM_CODEPOINT]
    );
    echo(
        "SEGMENTED_MAPPING_GROUP",
        mapping[SM_GROUP]
    );
    echo(
        "SEGMENTED_MAPPING_STATUS",
        mapping[SM_STATUS]
    );
    echo(
        "SEGMENTED_MAPPING_ACTIVE_SEGMENTS",
        mapping[SM_ACTIVE_SEGMENTS]
    );
    echo(
        "SEGMENTED_MAPPING_ACTIVE_COUNT",
        len(mapping[SM_ACTIVE_SEGMENTS])
    );
    echo(
        "SEGMENTED_MAPPING_NOTES",
        mapping[SM_NOTES]
    );

    if (segmented_mapping_is_visible(mapping)) {
        glyph =
            segmented_portable_glyph(
                source_set,
                mapping
            );
        echo(
            "SEGMENTED_ADAPTER_REGION_BOUNDS",
            glyph[PG_REGION_BOUNDS]
        );
        echo(
            "SEGMENTED_ADAPTER_COMPONENT_COUNT",
            glyph[PG_COMPONENT_COUNT]
        );
        echo(
            "SEGMENTED_ADAPTER_POINT_COUNT",
            glyph[PG_POINT_COUNT]
        );
    }
}
