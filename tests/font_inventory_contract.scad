//////////////////////////////////////////////////////////////////////
// LibFile: font_inventory_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Version and configured font inventory reporting.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../config/defaults.scad>
include <../registries/laboratory_sources.scad>
include <../config/sources.scad>
include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/validation.scad>
include <../lib/reporting.scad>

validate_font_source_registry(FONT_SOURCES);

assert(len(version()) >= 2);
assert(version_num() > 0);
assert(len(FONT_SOURCES) == 3);

report_environment();
report_configured_font_sources(
    FONT_SOURCES,
    "full"
);
report_runtime_fontmetrics(
    FONT_SOURCES,
    false,
    20
);

echo("PASS", "font_inventory_contract");
