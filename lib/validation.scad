//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Glyph Dossier
// FileGroup: Contract Validation
// FileSummary: Validates projects, dossiers, registries, and study sets.
//////////////////////////////////////////////////////////////////////

VALID_GROUPS = [
    "uppercase",
    "lowercase",
    "digit",
    "punctuation"
];

VALID_PRIORITIES = [
    "primary",
    "secondary",
    "coverage"
];

VALID_VERTICAL_CLASSES = [
    "cap",
    "x_height",
    "ascender",
    "descender",
    "x_height_dot",
    "descender_dot",
    "digit_height",
    "cap_punctuation",
    "x_punctuation",
    "descender_punctuation"
];

function count_group(records, group_name) =
    len([
        for (record = records)
            if (record[GD_GROUP] == group_name)
                record
    ]);

module validate_project(project) {
    assert(
        len(project) == 6,
        str("Project record must contain 6 fields; found ", len(project))
    );
    assert(
        project[PR_KIND] == "laboratory"
        || project[PR_KIND] == "catalog_notice",
        str("Unsupported project kind: ", project[PR_KIND])
    );
    assert(len(project[PR_NAME]) > 0, "Project name must not be empty.");
}

module validate_glyph_dossier(dossier) {
    assert(
        len(dossier) == 14,
        str(
            "Glyph dossier must contain 14 fields; found ",
            len(dossier)
        )
    );
    assert(len(dossier[GD_ID]) > 0, "Glyph dossier ID is empty.");
    assert(len(dossier[GD_GLYPH]) == 1,
        str("Glyph must contain one character: ", dossier[GD_ID]));
    assert(value_in_list(VALID_GROUPS, dossier[GD_GROUP]),
        str("Unknown glyph group: ", dossier[GD_GROUP]));
    assert(len(dossier[GD_ARCHETYPE]) > 0,
        str("Archetype is empty: ", dossier[GD_ID]));
    assert(dossier[GD_COMPONENTS_MIN] >= 1,
        str("Component minimum is invalid: ", dossier[GD_ID]));
    assert(
        dossier[GD_COMPONENTS_MAX] >= dossier[GD_COMPONENTS_MIN],
        str("Component range is invalid: ", dossier[GD_ID])
    );
    assert(dossier[GD_COUNTERS_MIN] >= 0,
        str("Counter minimum is invalid: ", dossier[GD_ID]));
    assert(
        dossier[GD_COUNTERS_MAX] >= dossier[GD_COUNTERS_MIN],
        str("Counter range is invalid: ", dossier[GD_ID])
    );
    assert(
        value_in_list(
            VALID_VERTICAL_CLASSES,
            dossier[GD_VERTICAL_CLASS]
        ),
        str(
            "Unknown vertical class ",
            dossier[GD_VERTICAL_CLASS],
            " in ",
            dossier[GD_ID]
        )
    );
    assert(len(dossier[GD_FEATURES]) > 0,
        str("Feature list is empty: ", dossier[GD_ID]));
    assert(len(dossier[GD_RISKS]) > 0,
        str("Risk list is empty: ", dossier[GD_ID]));
    assert(
        value_in_list(VALID_PRIORITIES, dossier[GD_PRIORITY]),
        str("Unknown priority: ", dossier[GD_PRIORITY])
    );
    assert(len(dossier[GD_NOTE]) > 0,
        str("Design note is empty: ", dossier[GD_ID]));
}

module validate_glyph_registry(records) {
    assert(len(records) == 66,
        str("Expected 66 glyph dossiers; found ", len(records)));
    assert(count_group(records, "uppercase") == 26,
        "Uppercase registry must contain 26 dossiers.");
    assert(count_group(records, "lowercase") == 26,
        "Lowercase registry must contain 26 dossiers.");
    assert(count_group(records, "digit") == 10,
        "Digit registry must contain 10 dossiers.");
    assert(count_group(records, "punctuation") == 4,
        "Punctuation registry must contain 4 dossiers.");

    for (record = records) {
        validate_glyph_dossier(record);
        assert(
            exact_name_count(records, record[GD_ID]) == 1,
            str("Duplicate dossier ID: ", record[GD_ID])
        );
    }
}

module validate_id_set(ids, records, set_name) {
    assert(len(ids) > 0, str(set_name, " is empty."));

    for (id = ids)
        assert(
            exact_name_count(records, id) == 1,
            str(
                "Expected one dossier for ",
                id,
                " in ",
                set_name
            )
        );

    for (id = ids)
        assert(
            len([for (candidate = ids) if (candidate == id) candidate])
                == 1,
            str("Duplicate ID in ", set_name, ": ", id)
        );
}
