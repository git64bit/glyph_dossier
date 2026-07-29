//////////////////////////////////////////////////////////////////////
// LibFile: mappings_digits_punctuation.scad
// Project: Glyph Dossier
// FileGroup: Procedural Segment Mappings
// FileSummary: S7R1 digits_punctuation dossier masks.
//////////////////////////////////////////////////////////////////////

S7R1_DIGITS_PUNCTUATION_MAPPINGS = [
    segment_mapping("D_0", "0", 48, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "C", "D", "E", "F"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_1", "1", 49, "digit", SEGMENT_STATUS_VISIBLE, ["B", "C"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_2", "2", 50, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "D", "E", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_3", "3", 51, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "C", "D", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_4", "4", 52, "digit", SEGMENT_STATUS_VISIBLE, ["B", "C", "F", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_5", "5", 53, "digit", SEGMENT_STATUS_VISIBLE, ["A", "C", "D", "F", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_6", "6", 54, "digit", SEGMENT_STATUS_VISIBLE, ["A", "C", "D", "E", "F", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_7", "7", 55, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "C"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_8", "8", 56, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "C", "D", "E", "F", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("D_9", "9", 57, "digit", SEGMENT_STATUS_VISIBLE, ["A", "B", "C", "D", "F", "G"], "Project-authored seven-segment digit mask."),
    segment_mapping("P_question", "?", 63, "punctuation", SEGMENT_STATUS_VISIBLE, ["A", "B", "G", "DOT_BOTTOM"], "Project-authored seven-segment punctuation extension."),
    segment_mapping("P_exclamation", "!", 33, "punctuation", SEGMENT_STATUS_INTENTIONAL_BLANK, [], "Defined blank display state used to exercise empty-state semantics."),
    segment_mapping("P_colon", ":", 58, "punctuation", SEGMENT_STATUS_VISIBLE, ["DOT_TOP", "DOT_BOTTOM"], "Project-authored seven-segment punctuation extension."),
    segment_mapping("P_semicolon", ";", 59, "punctuation", SEGMENT_STATUS_VISIBLE, ["DOT_TOP", "COMMA"], "Project-authored seven-segment punctuation extension."),
];
