//////////////////////////////////////////////////////////////////////
// LibFile: punctuation_glyphs.scad
// Project: Glyph Dossier
// FileGroup: Character Registry
// FileSummary: Character-level dossiers for question, exclamation, colon, and semicolon.
//////////////////////////////////////////////////////////////////////

PUNCTUATION_GLYPHS = [
    glyph_dossier(
        "P_question",
        "?",
        "punctuation",
        "curved_mark_dot",
        2,
        2,
        0,
        0,
        "cap_punctuation",
        ["upper_curve", "narrow_transition", "terminal", "separate_dot"],
        ["dot_loss", "component_assignment", "curve_cut", "narrow_transition"],
        ["curve_shape", "dot_shape", "terminal_angle"],
        "primary",
        "Primary punctuation test combining a complex main mark and separate dot."
    ),
    glyph_dossier(
        "P_exclamation",
        "!",
        "punctuation",
        "stem_dot",
        2,
        2,
        0,
        0,
        "cap_punctuation",
        ["main_stem", "separate_dot"],
        ["dot_loss", "stem_fragment", "component_assignment"],
        ["tapered_stem", "rectangular_stem", "dot_shape"],
        "primary",
        "Primary two-component punctuation control glyph."
    ),
    glyph_dossier(
        "P_colon",
        ":",
        "punctuation",
        "paired_dots",
        2,
        2,
        0,
        0,
        "x_punctuation",
        ["upper_dot", "lower_dot"],
        ["component_loss", "component_assignment", "small_part"],
        ["round_dots", "square_dots"],
        "primary",
        "Primary test consisting entirely of disconnected small components."
    ),
    glyph_dossier(
        "P_semicolon",
        ";",
        "punctuation",
        "dot_descending_mark",
        2,
        2,
        0,
        0,
        "descender_punctuation",
        ["upper_dot", "lower_comma_tail"],
        ["component_loss", "tail_fragment", "component_assignment"],
        ["tail_angle", "dot_shape"],
        "primary",
        "Tests disconnected punctuation with a descending curved component."
    )
];
