//////////////////////////////////////////////////////////////////////
// LibFile: portable_catalog_groups.scad
// Project: Glyph Dossier
// FileGroup: Portable Catalog Routing
// FileSummary: Exact ID sets for complete and grouped contact sheets.
//////////////////////////////////////////////////////////////////////

VALID_PORTABLE_SHEET_GROUPS = [
    "representative",
    "uppercase",
    "lowercase",
    "digits",
    "punctuation",
    "all"
];

function portable_sheet_ids(group_name) =
    group_name == "uppercase"
        ? PORTABLE_UPPERCASE_IDS
    : group_name == "lowercase"
        ? PORTABLE_LOWERCASE_IDS
    : group_name == "digits"
        ? PORTABLE_DIGIT_IDS
    : group_name == "punctuation"
        ? PORTABLE_PUNCTUATION_IDS
    : group_name == "all"
        ? PORTABLE_ALL_IDS
    : PORTABLE_REPRESENTATIVE_IDS;

module validate_portable_sheet_group(group_name) {
    assert(
        in_list(
            group_name,
            VALID_PORTABLE_SHEET_GROUPS
        ),
        str(
            "Unknown portable sheet group: ",
            group_name
        )
    );
}
