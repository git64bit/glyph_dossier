//////////////////////////////////////////////////////////////////////
// LibFile: lookup.scad
// Project: Glyph Dossier
// FileGroup: Exact Lookup
// FileSummary: Requires exact records and source-glyph observations.
//////////////////////////////////////////////////////////////////////

function named_matches(records, name) = [
    for (record = records)
        if (record_name(record) == name)
            record
];

function named_record(records, name, record_kind = "record") =
    let(matches = named_matches(records, name))
    assert(
        len(matches) == 1,
        str(
            "Expected exactly one ",
            record_kind,
            " named ",
            name,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function exact_name_count(records, name) =
    len(named_matches(records, name));

function observation_matches(
    records,
    source_id,
    glyph_id
) = [
    for (record = records)
        if (
            record[OB_SOURCE_ID] == source_id
            && record[OB_GLYPH_ID] == glyph_id
        )
            record
];

function exact_observation_count(
    records,
    source_id,
    glyph_id
) =
    len(observation_matches(records, source_id, glyph_id));

function source_glyph_observation(
    records,
    source_id,
    glyph_id
) =
    let(matches = observation_matches(records, source_id, glyph_id))
    assert(
        len(matches) == 1,
        str(
            "Expected one observation for source ",
            source_id,
            " and glyph ",
            glyph_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];
