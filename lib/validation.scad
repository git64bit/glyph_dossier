//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Glyph Dossier
// FileGroup: Contract Validation
// FileSummary: Validates projects, glyphs, sources, and observations.
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

VALID_SOURCE_STATUSES = [
    "active",
    "disabled"
];

VALID_OBSERVATION_STATUSES = [
    "pending",
    "observed",
    "verified"
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

module validate_font_source(source) {
    assert(
        len(source) == 8,
        str("Font source must contain 8 fields; found ", len(source))
    );
    assert(len(source[FS_ID]) > 0, "Font source ID is empty.");
    assert(
        source[FS_KIND] == "font",
        str("Unsupported source kind: ", source[FS_KIND])
    );
    assert(len(source[FS_LABEL]) > 0,
        str("Source label is empty: ", source[FS_ID]));
    assert(
        value_in_list(VALID_SOURCE_STATUSES, source[FS_STATUS]),
        str("Unknown source status: ", source[FS_STATUS])
    );
}

module validate_font_source_registry(sources) {
    assert(
        len(sources) == 3,
        str("Expected 3 laboratory sources; found ", len(sources))
    );

    for (source = sources) {
        validate_font_source(source);
        assert(
            exact_name_count(sources, source[FS_ID]) == 1,
            str("Duplicate source ID: ", source[FS_ID])
        );
    }
}

module validate_glyph_observation(observation) {
    assert(
        len(observation) == 14,
        str(
            "Glyph observation must contain 14 fields; found ",
            len(observation)
        )
    );
    assert(len(observation[OB_ID]) > 0,
        "Observation ID is empty.");
    assert(len(observation[OB_SOURCE_ID]) > 0,
        str("Observation source is empty: ", observation[OB_ID]));
    assert(len(observation[OB_GLYPH_ID]) > 0,
        str("Observation glyph is empty: ", observation[OB_ID]));
    assert(
        value_in_list(
            VALID_OBSERVATION_STATUSES,
            observation[OB_STATUS]
        ),
        str(
            "Unknown observation status ",
            observation[OB_STATUS],
            " in ",
            observation[OB_ID]
        )
    );
    assert(len(observation[OB_VARIANT]) > 0,
        str("Observation variant is empty: ", observation[OB_ID]));
    assert(len(observation[OB_NOTE]) > 0,
        str("Observation note is empty: ", observation[OB_ID]));

    if (observation[OB_STATUS] != "pending") {
        assert(
            observation_value_known(observation[OB_COMPONENTS])
            && observation[OB_COMPONENTS] >= 1,
            str("Observed component count is invalid: ", observation[OB_ID])
        );
        assert(
            observation_value_known(observation[OB_COUNTERS])
            && observation[OB_COUNTERS] >= 0,
            str("Observed counter count is invalid: ", observation[OB_ID])
        );
        assert(
            observation_has_bounds(observation),
            str("Observed extents are incomplete: ", observation[OB_ID])
        );
        assert(
            observation[OB_LEFT] < observation[OB_RIGHT],
            str("Observed horizontal extents are invalid: ", observation[OB_ID])
        );
        assert(
            observation[OB_BOTTOM] < observation[OB_TOP],
            str("Observed vertical extents are invalid: ", observation[OB_ID])
        );
        assert(
            observation_value_known(observation[OB_MIN_STROKE])
            && observation[OB_MIN_STROKE] > 0,
            str("Observed minimum stroke is invalid: ", observation[OB_ID])
        );
        assert(
            observation_value_known(observation[OB_MIN_GAP])
            && observation[OB_MIN_GAP] >= 0,
            str("Observed minimum gap is invalid: ", observation[OB_ID])
        );
    }
}

module validate_observation_registry(
    observations,
    sources,
    glyphs
) {
    assert(
        len(observations) == 20,
        str(
            "Expected 20 representative observations; found ",
            len(observations)
        )
    );

    for (observation = observations) {
        validate_glyph_observation(observation);
        assert(
            exact_name_count(observations, observation[OB_ID]) == 1,
            str("Duplicate observation ID: ", observation[OB_ID])
        );
        assert(
            exact_name_count(
                sources,
                observation[OB_SOURCE_ID]
            ) == 1,
            str(
                "Observation has unknown source: ",
                observation[OB_ID]
            )
        );
        assert(
            exact_name_count(
                glyphs,
                observation[OB_GLYPH_ID]
            ) == 1,
            str(
                "Observation has unknown glyph: ",
                observation[OB_ID]
            )
        );
        assert(
            exact_observation_count(
                observations,
                observation[OB_SOURCE_ID],
                observation[OB_GLYPH_ID]
            ) == 1,
            str(
                "Duplicate source-glyph observation: ",
                observation[OB_SOURCE_ID],
                " ",
                observation[OB_GLYPH_ID]
            )
        );
    }
}

module validate_normalization(
    dossier,
    method,
    target_height,
    probe_size,
    manual_left,
    manual_right,
    manual_bottom,
    manual_top
) {
    assert(
        dossier[GD_ID] == "U_A",
        str(
            "Batch 004 normalizes uppercase A only; selected ",
            dossier[GD_ID]
        )
    );
    assert(
        value_in_list(
            VALID_NORMALIZATION_METHODS,
            method
        ),
        str("Unknown normalization method: ", method)
    );
    assert(
        target_height > 0,
        "Target assembled height must be positive."
    );
    assert(
        probe_size > 0,
        "Normalization probe size must be positive."
    );

    if (method == "manual")
        assert(
            profile_bounds_valid(
                manual_left,
                manual_right,
                manual_bottom,
                manual_top
            ),
            "Manual normalization requires valid left, right, bottom, and top bounds."
        );

    if (method == "textmetrics")
        assert(
            version_num() >= 20240000,
            str(
                "textmetrics normalization requires a compatible development snapshot; version_num() is ",
                version_num()
            )
        );
}

module validate_a_section_plan(
    dossier,
    cell_width,
    cell_height,
    columns,
    rows,
    selected_column,
    selected_row,
    epsilon,
    bed_x,
    bed_y,
    apex_y_ratio,
    counter_bottom_ratio,
    counter_top_ratio,
    crossbar_y_ratio,
    counter_half_width_ratio
) {
    assert(
        dossier[GD_ID] == "U_A",
        str(
            "Batch 003 sections uppercase A only; selected ",
            dossier[GD_ID]
        )
    );
    assert(cell_width > 0, "Section cell width must be positive.");
    assert(cell_height > 0, "Section cell height must be positive.");
    assert(
        columns >= 1 && floor(columns) == columns,
        "Section column count must be a positive integer."
    );
    assert(
        rows >= 1 && floor(rows) == rows,
        "Section row count must be a positive integer."
    );
    assert(
        selected_column >= 0
        && selected_column < columns
        && floor(selected_column) == selected_column,
        "Selected section column is outside the grid."
    );
    assert(
        selected_row >= 0
        && selected_row < rows
        && floor(selected_row) == selected_row,
        "Selected section row is outside the grid."
    );
    assert(
        epsilon > 0 && epsilon <= 1,
        "Section clipping epsilon must be greater than 0 and at most 1 mm."
    );
    assert(
        cell_width <= bed_x,
        str(
            "Section cell width ",
            cell_width,
            " exceeds configured bed width ",
            bed_x
        )
    );
    assert(
        cell_height <= bed_y,
        str(
            "Section cell height ",
            cell_height,
            " exceeds configured bed height ",
            bed_y
        )
    );
    assert(
        apex_y_ratio > 0 && apex_y_ratio <= 1,
        "A apex guide ratio must be in (0, 1]."
    );
    assert(
        counter_bottom_ratio >= 0
        && counter_bottom_ratio < counter_top_ratio,
        "A counter guide ratios are invalid."
    );
    assert(
        counter_top_ratio <= apex_y_ratio,
        "A counter top guide must remain below the apex guide."
    );
    assert(
        crossbar_y_ratio >= counter_bottom_ratio
        && crossbar_y_ratio <= counter_top_ratio,
        "A crossbar guide must remain inside the counter guide range."
    );
    assert(
        counter_half_width_ratio > 0
        && counter_half_width_ratio < 0.5,
        "A counter half-width ratio must be in (0, 0.5)."
    );
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
