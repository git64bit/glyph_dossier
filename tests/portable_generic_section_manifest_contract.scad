    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_section_manifest_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Deterministic object IDs and local/global bounds.
    //////////////////////////////////////////////////////////////////////

    include <BOSL2/std.scad>
include <../lib/portable_glyph_schema.scad>
include <../lib/portable_font_set_schema.scad>
include <../glyph_sets/liberation_sans_regular/manifest.scad>
include <../registries/portable_font_sets.scad>
include <../lib/sectioning.scad>
include <../lib/portable_glyph_lookup.scad>
include <../lib/portable_font_set_lookup.scad>
include <../lib/portable_generic_sectioning.scad>
include <../geometry/portable_glyph_region.scad>


    set_id = "FIRA_SANS_REGULAR_R1";
    glyph_id = "L_g";
    origin_x = -300;
    origin_y = 0;
    cell_width = 200;
    cell_height = 200;

    assert(section_id(0, 0) == "C1_R1");
    assert(section_id(2, 1) == "C3_R2");
    assert(
        portable_section_object_id(
            set_id,
            glyph_id,
            2,
            1
        )
        == "FIRA_SANS_REGULAR_R1__L_g__C3_R2"
    );
    assert(
        portable_section_global_bounds(
            origin_x,
            origin_y,
            cell_width,
            cell_height,
            2,
            1
        ) == [100, 300, 200, 400]
    );
    assert(
        portable_section_local_bounds(
            cell_width,
            cell_height
        ) == [0, 200, 0, 200]
    );
    assert(section_count(3, 3) == 9);

    echo("PASS", "portable_generic_section_manifest_contract");
