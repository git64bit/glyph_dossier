//////////////////////////////////////////////////////////////////////
// LibFile: workbenches.scad
// Project: Glyph Dossier
// FileGroup: Workbench Contracts
// FileSummary: Declares supported workbenches and render modes.
//////////////////////////////////////////////////////////////////////

VALID_WORKBENCHES = [
    "development",
    "laboratory",
    "profile",
    "contact_sheet",
    "catalog"
];

VALID_RENDER_MODES = [
    "dossier",
    "profile_2d",
    "profile_3d",
    "contact_sheet",
    "report_only"
];

VALID_SOURCE_KINDS = [
    "font"
];

function value_in_list(values, value) =
    len([for (candidate = values) if (candidate == value) candidate]) > 0;

module validate_workbench_selection(
    workbench_name,
    render_mode,
    source_kind
) {
    assert(
        value_in_list(VALID_WORKBENCHES, workbench_name),
        str("Unknown workbench: ", workbench_name)
    );
    assert(
        value_in_list(VALID_RENDER_MODES, render_mode),
        str("Unknown render mode: ", render_mode)
    );
    assert(
        value_in_list(VALID_SOURCE_KINDS, source_kind),
        str("Unsupported Batch 001 source kind: ", source_kind)
    );
}
