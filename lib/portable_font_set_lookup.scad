//////////////////////////////////////////////////////////////////////
// LibFile: portable_font_set_lookup.scad
// Project: Glyph Dossier
// FileGroup: Portable Font Set Lookup
// FileSummary: Exact set lookup followed by exact glyph lookup.
//////////////////////////////////////////////////////////////////////

function portable_font_set_matches(records, set_id) = [
    for (record = records)
        if (record[PFS_ID] == set_id)
            record
];

function portable_font_set_by_id(records, set_id) =
    let(matches = portable_font_set_matches(records, set_id))
    assert(
        len(matches) == 1,
        str(
            "Expected one portable font set named ",
            set_id,
            "; found ",
            len(matches)
        )
    )
    matches[0];

function portable_font_set_id_count(records, set_id) =
    len(portable_font_set_matches(records, set_id));

function portable_glyph_by_set_and_id(records, set_id, glyph_id) =
    let(set_record = portable_font_set_by_id(records, set_id))
    portable_glyph_by_id(set_record[PFS_GLYPHS], glyph_id);
