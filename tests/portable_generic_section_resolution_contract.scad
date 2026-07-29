    //////////////////////////////////////////////////////////////////////
    // LibFile: portable_generic_section_resolution_contract.scad
    // Project: Glyph Dossier
    // FileGroup: Contract Tests
    // FileSummary: Automatic grid resolution covers all 396 profiles.
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


    target_height = 600;
    cell_width = 200;
    cell_height = 200;
    profile_count = sum([
        for (set_record = PORTABLE_FONT_SETS)
            len(set_record[PFS_GLYPHS])
    ]);

    assert(profile_count == 396);

    for (set_record = PORTABLE_FONT_SETS)
        for (glyph = set_record[PFS_GLYPHS]) {
            columns = portable_resolved_section_columns(
                glyph,
                target_height,
                cell_width,
                3,
                "auto"
            );
            rows = portable_resolved_section_rows(
                target_height,
                cell_height,
                3,
                "auto"
            );
            origin_x = portable_resolved_section_origin_x(
                glyph,
                target_height,
                cell_width,
                -300,
                3,
                "auto"
            );
            origin_y = portable_resolved_section_origin_y(
                -40,
                "auto"
            );

            assert(columns >= 1);
            assert(rows == 3);
            assert(origin_y == 0);
            assert(
                origin_x
                    == -section_plan_width(
                        cell_width,
                        columns
                    ) / 2
            );
            assert(
                portable_generic_grid_covers_glyph(
                    glyph,
                    target_height,
                    origin_x,
                    origin_y,
                    cell_width,
                    cell_height,
                    columns,
                    rows
                ),
                str(
                    "Auto grid failed: ",
                    set_record[PFS_ID],
                    " ",
                    glyph[PG_ID]
                )
            );
        }

    wide_m = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "ALPHA_SLAB_ONE_REGULAR_R1",
        "L_m"
    );
    assert(
        portable_auto_section_columns(
            wide_m,
            target_height,
            cell_width
        ) == 6
    );

    narrow_l = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "MONTSERRAT_REGULAR_R1",
        "L_l"
    );
    assert(
        portable_auto_section_columns(
            narrow_l,
            target_height,
            cell_width
        ) == 1
    );

    assert(
        portable_resolved_section_columns(
            wide_m,
            target_height,
            cell_width,
            4,
            "manual"
        ) == 4
    );
    assert(
        portable_resolved_section_rows(
            target_height,
            cell_height,
            5,
            "manual"
        ) == 5
    );
    assert(
        portable_resolved_section_origin_x(
            wide_m,
            target_height,
            cell_width,
            -425,
            4,
            "manual"
        ) == -425
    );
    assert(
        portable_resolved_section_origin_y(
            -50,
            "manual"
        ) == -50
    );

    alpha_l_c = portable_glyph_by_set_and_id(
        PORTABLE_FONT_SETS,
        "ALPHA_SLAB_ONE_REGULAR_R1",
        "L_c"
    );
    alpha_l_c_columns = portable_auto_section_columns(
        alpha_l_c,
        target_height,
        cell_width
    );
    alpha_l_c_origin_x =
        -section_plan_width(
            cell_width,
            alpha_l_c_columns
        ) / 2;

    assert(
        portable_generic_grid_covers_glyph(
            alpha_l_c,
            target_height,
            alpha_l_c_origin_x,
            0,
            cell_width,
            cell_height,
            alpha_l_c_columns,
            3
        ),
        "Regression: ALPHA_SLAB_ONE_REGULAR_R1 L_c"
    );

    echo(
        "PORTABLE_GENERIC_SECTION_PROFILE_COUNT",
        profile_count
    );
    echo("PASS", "portable_generic_section_resolution_contract");
