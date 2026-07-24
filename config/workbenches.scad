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
    "font_source",
    "font_inventory",
    "glyph_observation",
    "glyph_comparison",
    "source_contact_sheet",
    "a_normalized_profile",
    "a_section_plan",
    "a_section_layout",
    "a_section_export",
    "catalog"
];

VALID_RENDER_MODES = [
    "dossier",
    "profile_2d",
    "profile_3d",
    "contact_sheet",
    "source_sample",
    "font_inventory",
    "observation",
    "comparison",
    "source_contact_sheet",
    "a_normalized_profile",
    "a_section_plan",
    "a_section_layout",
    "a_section_export",
    "report_only"
];

VALID_SOURCE_KINDS = [
    "font"
];

VALID_PROBE_ORIENTATIONS = [
    "horizontal",
    "vertical"
];

VALID_NORMALIZATION_METHODS = [
    "resize",
    "manual",
    "textmetrics"
];

function value_in_list(values, value) =
    len([for (candidate = values) if (candidate == value) candidate]) > 0;

module validate_workbench_selection(
    workbench_name,
    render_mode,
    source_kind,
    stroke_probe_orientation = "vertical",
    gap_probe_orientation = "horizontal"
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
        str("Unsupported source kind: ", source_kind)
    );
    assert(
        value_in_list(
            VALID_PROBE_ORIENTATIONS,
            stroke_probe_orientation
        ),
        str(
            "Unknown stroke probe orientation: ",
            stroke_probe_orientation
        )
    );
    assert(
        value_in_list(
            VALID_PROBE_ORIENTATIONS,
            gap_probe_orientation
        ),
        str(
            "Unknown gap probe orientation: ",
            gap_probe_orientation
        )
    );
}
