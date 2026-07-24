//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Glyph Dossier
// FileGroup: Console Reporting
// FileSummary: Reports project, source, dossier, and study-set data.
//////////////////////////////////////////////////////////////////////

module report_project(project, report_level = "full") {
    echo("GLYPH_DOSSIER_PROJECT", project[PR_NAME]);
    echo("GLYPH_DOSSIER_KIND", project[PR_KIND]);
    echo("GLYPH_DOSSIER_EDITION", project[PR_EDITION]);
    echo("GLYPH_DOSSIER_BASELINE", project[PR_BASELINE]);

    if (report_level == "full") {
        echo("GLYPH_DOSSIER_SCOPE", project[PR_SCOPE]);
        echo("GLYPH_DOSSIER_STATUS", project[PR_STATUS]);
    }
}

module report_catalog_notice(project) {
    echo("GLYPH_DOSSIER_CATALOG", project[PR_STATUS]);
}

module report_source(
    source_kind,
    font_name,
    font_license,
    font_source_url,
    font_revision
) {
    echo("GLYPH_SOURCE_KIND", source_kind);
    echo(
        "GLYPH_FONT_NAME",
        font_name == "" ? "OpenSCAD default font" : font_name
    );
    echo("GLYPH_FONT_LICENSE", font_license);
    echo("GLYPH_FONT_SOURCE_URL", font_source_url);
    echo("GLYPH_FONT_REVISION", font_revision);
}

module report_glyph_dossier(dossier, report_level = "full") {
    echo("DOSSIER_ID", dossier[GD_ID]);
    echo("DOSSIER_GLYPH", dossier[GD_GLYPH]);
    echo("DOSSIER_GROUP", dossier[GD_GROUP]);
    echo("DOSSIER_ARCHETYPE", dossier[GD_ARCHETYPE]);
    echo("DOSSIER_COMPONENT_RANGE", [
        dossier[GD_COMPONENTS_MIN],
        dossier[GD_COMPONENTS_MAX]
    ]);
    echo("DOSSIER_COUNTER_RANGE", [
        dossier[GD_COUNTERS_MIN],
        dossier[GD_COUNTERS_MAX]
    ]);
    echo("DOSSIER_VERTICAL_CLASS", dossier[GD_VERTICAL_CLASS]);
    echo("DOSSIER_PRIORITY", dossier[GD_PRIORITY]);

    if (report_level == "full") {
        echo("DOSSIER_FEATURES", dossier[GD_FEATURES]);
        echo("DOSSIER_SECTION_RISKS", dossier[GD_RISKS]);
        echo("DOSSIER_FONT_VARIANTS", dossier[GD_VARIANTS]);
        echo("DOSSIER_NOTE", dossier[GD_NOTE]);
    }
}

module report_study_set(set_name, ids) {
    echo("STUDY_SET_NAME", set_name);
    echo("STUDY_SET_COUNT", len(ids));
    echo("STUDY_SET_IDS", ids);
}
