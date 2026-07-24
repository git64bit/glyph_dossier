//////////////////////////////////////////////////////////////////////
// LibFile: portable_glyph_lookup.scad
// Project: Glyph Dossier
// FileGroup: Portable Exact Lookup
// FileSummary: Requires one exact generated glyph record.
//////////////////////////////////////////////////////////////////////

function portable_glyph_matches(records, glyph_id) = [
    for (record = records)
        if (record[PG_ID] == glyph_id)
            record
];

function portable_glyph_by_id(records, glyph_id) =
    let(matches = portable_glyph_matches(records, glyph_id))
    assert(
        len(matches) == 1,
        str(
            "Expected one portable glyph named ",
            glyph_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function portable_glyph_id_count(records, glyph_id) =
    len(portable_glyph_matches(records, glyph_id));
