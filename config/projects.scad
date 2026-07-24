//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Glyph Dossier
// FileGroup: Registry Routing
// FileSummary: Exposes the active project registry.
//////////////////////////////////////////////////////////////////////

PROJECTS = wb_workbench_name == "catalog"
    ? CATALOG_PROJECTS
    : LABORATORY_PROJECTS;
