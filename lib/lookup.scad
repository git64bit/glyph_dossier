//////////////////////////////////////////////////////////////////////
// LibFile: lookup.scad
// Project: Glyph Dossier
// FileGroup: Exact Lookup
// FileSummary: Requires exactly one matching named record.
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
