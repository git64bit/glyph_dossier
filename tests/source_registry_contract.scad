//////////////////////////////////////////////////////////////////////
// LibFile: source_registry_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Three exact configurable source identities.
//////////////////////////////////////////////////////////////////////

include <../lib/schema.scad>
include <../config/defaults.scad>
include <../registries/laboratory_sources.scad>
include <../config/sources.scad>
include <../config/workbenches.scad>
include <../lib/lookup.scad>
include <../lib/validation.scad>

validate_font_source_registry(FONT_SOURCES);

assert(len(FONT_SOURCES) == 3);
assert(exact_name_count(FONT_SOURCES, "SRC_1") == 1);
assert(exact_name_count(FONT_SOURCES, "SRC_2") == 1);
assert(exact_name_count(FONT_SOURCES, "SRC_3") == 1);
assert(named_record(FONT_SOURCES, "SRC_1")[FS_KIND] == "font");
assert(named_record(FONT_SOURCES, "SRC_1")[FS_STATUS] == "active");

echo("PASS", "source_registry_contract");
