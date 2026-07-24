//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Glyph Dossier
// FileGroup: Console Reporting
// FileSummary: Reports projects, glyphs, sources, and observations.
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

module report_font_source(source, report_level = "full") {
    echo("FONT_SOURCE_ID", source[FS_ID]);
    echo("FONT_SOURCE_LABEL", source[FS_LABEL]);
    echo("FONT_SOURCE_KIND", source[FS_KIND]);
    echo(
        "FONT_SOURCE_NAME",
        source[FS_FONT_NAME] == ""
            ? "OpenSCAD default font"
            : source[FS_FONT_NAME]
    );
    echo("FONT_SOURCE_STATUS", source[FS_STATUS]);

    if (report_level == "full") {
        echo("FONT_SOURCE_LICENSE", source[FS_LICENSE]);
        echo("FONT_SOURCE_URL", source[FS_URL]);
        echo("FONT_SOURCE_REVISION", source[FS_REVISION]);
    }
}

// Batch 001 compatibility reporter.
module report_source(
    source_kind,
    font_name,
    font_license,
    font_source_url,
    font_revision
) {
    report_font_source(
        font_source(
            "LEGACY_SOURCE",
            source_kind,
            "Legacy source",
            font_name,
            font_license,
            font_source_url,
            font_revision,
            "active"
        ),
        "full"
    );
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

module report_glyph_observation(
    observation,
    report_level = "full",
    report_name = "OBSERVATION"
) {
    echo(str(report_name, "_ID"), observation[OB_ID]);
    echo(str(report_name, "_SOURCE_ID"), observation[OB_SOURCE_ID]);
    echo(str(report_name, "_GLYPH_ID"), observation[OB_GLYPH_ID]);
    echo(str(report_name, "_STATUS"), observation[OB_STATUS]);
    echo(str(report_name, "_VARIANT"), observation[OB_VARIANT]);
    echo(str(report_name, "_COMPONENTS"), observation[OB_COMPONENTS]);
    echo(str(report_name, "_COUNTERS"), observation[OB_COUNTERS]);

    if (report_level == "full") {
        echo(str(report_name, "_EXTENTS"), [
            observation[OB_LEFT],
            observation[OB_RIGHT],
            observation[OB_BOTTOM],
            observation[OB_TOP]
        ]);
        echo(str(report_name, "_SIZE"), [
            observation_width(observation),
            observation_height(observation)
        ]);
        echo(
            str(report_name, "_MINIMUM_STROKE"),
            observation[OB_MIN_STROKE]
        );
        echo(
            str(report_name, "_MINIMUM_GAP"),
            observation[OB_MIN_GAP]
        );
        echo(str(report_name, "_NOTE"), observation[OB_NOTE]);
    }
}

module report_study_set(set_name, ids) {
    echo("STUDY_SET_NAME", set_name);
    echo("STUDY_SET_COUNT", len(ids));
    echo("STUDY_SET_IDS", ids);
}

module report_source_order(source_ids) {
    echo("COMPARISON_SOURCE_ORDER", source_ids);
}
module report_section_plan(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    columns,
    rows,
    bed_x,
    bed_y
) {
    echo("SECTION_PLAN_ORIGIN_MM", [origin_x, origin_y]);
    echo("SECTION_CELL_MM", [cell_width, cell_height]);
    echo("SECTION_GRID", [columns, rows]);
    echo("SECTION_COUNT", section_count(columns, rows));
    echo("SECTION_PLAN_SIZE_MM", [
        section_plan_width(cell_width, columns),
        section_plan_height(cell_height, rows)
    ]);
    echo("CONFIGURED_BED_MM", [bed_x, bed_y]);
    echo(
        "SECTION_OCCUPANCY_POLICY",
        "OpenSCAD does not report occupied cells; empty intersections render nothing."
    );
}

module report_selected_section(
    origin_x,
    origin_y,
    cell_width,
    cell_height,
    column,
    row
) {
    echo("SELECTED_SECTION_ID", section_id(column, row));
    echo("SELECTED_SECTION_INDEX_ZERO_BASED", [column, row]);
    echo("SELECTED_SECTION_BOUNDS_MM", [
        section_x0(origin_x, cell_width, column),
        section_x1(origin_x, cell_width, column),
        section_y0(origin_y, cell_height, row),
        section_y1(origin_y, cell_height, row)
    ]);
}

