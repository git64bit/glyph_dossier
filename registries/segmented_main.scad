//////////////////////////////////////////////////////////////////////
// LibFile: segmented_main.scad
// Project: Glyph Dossier
// FileGroup: Segmented Source Orchestrator
// FileSummary: State rendering and portable pipeline proof.
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>

include <lib/portable_glyph_schema.scad>
include <lib/portable_glyph_lookup.scad>
include <lib/portable_glyph_validation.scad>
include <lib/sectioning.scad>
include <lib/portable_generic_sectioning.scad>
include <lib/portable_section_occupancy_schema.scad>
include <lib/portable_section_occupancy.scad>

include <lib/segmented_source_schema.scad>
include <lib/segmented_source_lookup.scad>
include <lib/segmented_source_adapter.scad>
include <lib/segmented_source_validation.scad>
include <lib/segmented_source_reporting.scad>
include <registries/segmented_source_sets.scad>
include <config/segmented_defaults.scad>

include <geometry/portable_glyph_region.scad>
include <geometry/section_grid.scad>
include <geometry/portable_normalized_profile_scene.scad>
include <geometry/portable_generic_section_scene.scad>
include <geometry/portable_section_occupancy_scene.scad>
include <geometry/segmented_source_scene.scad>

function segmented_mode_needs_visible_mapping(mode) =
    in_list(
        mode,
        [
            "normalized_profile",
            "section_plan",
            "occupancy_plan"
        ]
    );

module run_segmented_workbench() {
    validate_segmented_controls();

    source_set = segmented_source_set_by_id(
        SEGMENTED_SOURCE_SETS,
        sg_set_id
    );
    mapping = segment_mapping_by_id(
        source_set[SSS_MAPPINGS],
        sg_glyph_id
    );
    needs_visible =
        segmented_mode_needs_visible_mapping(
            sg_render_mode
        );

    validate_segmented_source_set(source_set);
    report_segmented_source_set(source_set);
    report_segmented_mapping(
        source_set,
        mapping
    );


    pipeline_available =
        !needs_visible
        || segmented_mapping_is_visible(mapping);

    echo(
        "SEGMENTED_PIPELINE_AVAILABLE",
        pipeline_available
    );

    if (needs_visible && !pipeline_available) {
        echo(
            "SEGMENTED_PIPELINE_UNAVAILABLE_STATUS",
            mapping[SM_STATUS]
        );
        echo(
            "SEGMENTED_PIPELINE_UNAVAILABLE_REASON",
            str(
                "No portable geometry exists for ",
                source_set[SSS_ID],
                " ",
                mapping[SM_GLYPH_ID],
                ". Source state rendered instead."
            )
        );

        segmented_source_state_3d(
            source_set,
            mapping,
            sg_depth,
            sg_show_inactive,
            true,
            sg_frame_line_width
        );
    } else if (sg_render_mode == "source_state")
        segmented_source_state_3d(
            source_set,
            mapping,
            sg_depth,
            sg_show_inactive,
            sg_show_frame,
            sg_frame_line_width
        );
    else if (sg_render_mode == "contact_sheet")
        segmented_contact_sheet(
            source_set,
            sg_contact_columns,
            sg_contact_cell_width,
            sg_contact_cell_height,
            sg_depth,
            sg_frame_line_width,
            sg_contact_show_unsupported
        );
    else if (needs_visible) {
        glyph = segmented_portable_glyph(
            source_set,
            mapping
        );
        columns =
            portable_auto_section_columns(
                glyph,
                sg_target_height,
                sg_cell_width
            );
        rows =
            portable_auto_section_rows(
                sg_target_height,
                sg_cell_height
            );
        origin_x =
            -section_plan_width(
                sg_cell_width,
                columns
            ) / 2;

        validate_portable_glyph(glyph);

        if (
            sg_render_mode
                == "normalized_profile"
        )
            portable_generic_normalized_profile(
                glyph,
                sg_target_height,
                sg_depth,
                true,
                sg_frame_line_width
            );
        else if (
            sg_render_mode
                == "section_plan"
        )
            portable_generic_section_plan(
                glyph,
                sg_target_height,
                sg_depth,
                origin_x,
                0,
                sg_cell_width,
                sg_cell_height,
                columns,
                rows,
                true,
                true,
                sg_grid_line_width,
                sg_frame_line_width
            );
        else {
            occupancy_records =
                portable_section_occupancy_records(
                    source_set[SSS_ID],
                    glyph,
                    sg_target_height,
                    origin_x,
                    0,
                    sg_cell_width,
                    sg_cell_height,
                    columns,
                    rows,
                    sg_occupancy_area_epsilon,
                    sg_boolean_epsilon
                );

            echo(
                "SEGMENTED_OCCUPIED_SECTION_IDS",
                portable_occupied_section_ids(
                    occupancy_records
                )
            );
            echo(
                "SEGMENTED_OCCUPIED_SECTION_COUNT",
                portable_occupied_section_count(
                    occupancy_records
                )
            );

            portable_section_occupancy_plan(
                glyph,
                sg_target_height,
                sg_depth,
                occupancy_records,
                origin_x,
                0,
                sg_cell_width,
                sg_cell_height,
                columns,
                rows,
                sg_grid_line_width,
                sg_overlay_depth,
                true
            );
        }
    }
}

run_segmented_workbench();
