//////////////////////////////////////////////////////////////////////
// LibFile: portable_section_quality.scad
// Project: Glyph Dossier
// FileGroup: Portable Section Quality
// FileSummary: Builds immutable screening records from occupancy.
//////////////////////////////////////////////////////////////////////

function portable_quality_flags(
    occupied,
    multiple_components,
    small_component,
    thin_component,
    short_seam,
    vertex_near_cut,
    counter_cut_candidate,
    bed_fit
) =
    !occupied
    ? []
    : concat(
        multiple_components
        ? [PORTABLE_QUALITY_FLAG_MULTIPLE]
        : [],
        small_component
        ? [PORTABLE_QUALITY_FLAG_SMALL]
        : [],
        thin_component
        ? [PORTABLE_QUALITY_FLAG_THIN]
        : [],
        short_seam
        ? [PORTABLE_QUALITY_FLAG_SHORT_SEAM]
        : [],
        vertex_near_cut
        ? [PORTABLE_QUALITY_FLAG_VERTEX]
        : [],
        counter_cut_candidate
        ? [PORTABLE_QUALITY_FLAG_COUNTER]
        : [],
        !bed_fit
        ? [PORTABLE_QUALITY_FLAG_BED]
        : []
    );

function portable_section_quality_record(
    occupancy_records,
    record,
    glyph,
    target_height,
    columns,
    rows,
    small_component_area,
    thin_component_estimate,
    vertex_cut_distance,
    short_seam_length,
    counter_segment_count,
    boundary_tolerance,
    bed_x,
    bed_y
) =
    let(
        occupied = record[PSO_OCCUPIED],
        component_areas =
            portable_component_areas(record),
        component_bounds =
            portable_component_bounds(record),
        smallest_component_area =
            portable_min_or_undef(component_areas),
        min_component_extent =
            portable_min_or_undef(
                portable_component_min_extents(
                    record
                )
            ),
        min_thickness_estimate =
            portable_min_or_undef(
                portable_component_thickness_estimates(
                    record
                )
            ),
        multiple_components =
            record[PSO_COMPONENT_COUNT] > 1,
        small_component =
            occupied
            && !is_undef(smallest_component_area)
            && smallest_component_area
                < small_component_area,
        thin_component =
            occupied
            && !is_undef(min_thickness_estimate)
            && min_thickness_estimate
                < thin_component_estimate,
        seam_lengths =
            portable_quality_seam_lengths(
                occupancy_records,
                record,
                columns,
                rows,
                boundary_tolerance
            ),
        seam_segments =
            portable_quality_seam_segments(
                occupancy_records,
                record,
                columns,
                rows,
                boundary_tolerance
            ),
        shortest_seam =
            portable_positive_min_or_undef(
                seam_lengths,
                boundary_tolerance
            ),
        short_seam =
            occupied
            && !is_undef(shortest_seam)
            && shortest_seam < short_seam_length,
        max_seam_segments =
            portable_max_or_zero(seam_segments),
        counter_cut_candidate =
            occupied
            && max_seam_segments
                >= counter_segment_count,
        min_vertex_distance =
            occupied
            ? portable_min_vertex_cut_distance(
                glyph,
                target_height,
                record,
                columns,
                rows,
                vertex_cut_distance
            )
            : undef,
        vertex_near_cut =
            occupied
            && !is_undef(min_vertex_distance)
            && min_vertex_distance
                <= vertex_cut_distance,
        fragment_bounds =
            portable_region_bounds_or_undef(
                record[PSO_REGION]
            ),
        fragment_size =
            portable_bounds_size_or_zero(
                fragment_bounds
            ),
        bed_fit =
            !occupied
            || (
                fragment_size[0] <= bed_x
                && fragment_size[1] <= bed_y
            ),
        flags = portable_quality_flags(
            occupied,
            multiple_components,
            small_component,
            thin_component,
            short_seam,
            vertex_near_cut,
            counter_cut_candidate,
            bed_fit
        ),
        review = occupied && len(flags) > 0,
        status =
            !occupied
            ? PORTABLE_QUALITY_EMPTY
            : review
            ? PORTABLE_QUALITY_REVIEW
            : PORTABLE_QUALITY_CLEAR
    )
    [
        record[PSO_COLUMN],
        record[PSO_ROW],
        record[PSO_SECTION_ID],
        record[PSO_OBJECT_ID],
        occupied,
        status,
        flags,
        record[PSO_AREA],
        record[PSO_CELL_AREA_RATIO],
        record[PSO_COMPONENT_COUNT],
        component_areas,
        component_bounds,
        smallest_component_area,
        min_component_extent,
        min_thickness_estimate,
        multiple_components,
        small_component,
        thin_component,
        seam_lengths,
        seam_segments,
        sum(seam_lengths),
        shortest_seam,
        short_seam,
        max_seam_segments,
        counter_cut_candidate,
        min_vertex_distance,
        vertex_near_cut,
        fragment_bounds,
        fragment_size,
        bed_fit,
        review,
        record[PSO_REGION]
    ];

function portable_section_quality_records(
    occupancy_records,
    glyph,
    target_height,
    columns,
    rows,
    small_component_area,
    thin_component_estimate,
    vertex_cut_distance,
    short_seam_length,
    counter_segment_count,
    boundary_tolerance,
    bed_x,
    bed_y
) = [
    for (record = occupancy_records)
        portable_section_quality_record(
            occupancy_records,
            record,
            glyph,
            target_height,
            columns,
            rows,
            small_component_area,
            thin_component_estimate,
            vertex_cut_distance,
            short_seam_length,
            counter_segment_count,
            boundary_tolerance,
            bed_x,
            bed_y
        )
];

function portable_quality_review_records(records) = [
    for (record = records)
        if (record[PSQ_REVIEW])
            record
];

function portable_quality_clear_records(records) = [
    for (record = records)
        if (
            record[PSQ_OCCUPIED]
            && !record[PSQ_REVIEW]
        )
            record
];

function portable_quality_empty_records(records) = [
    for (record = records)
        if (!record[PSQ_OCCUPIED])
            record
];

function portable_quality_review_count(records) =
    len(portable_quality_review_records(records));

function portable_quality_clear_count(records) =
    len(portable_quality_clear_records(records));

function portable_quality_empty_count(records) =
    len(portable_quality_empty_records(records));

function portable_quality_review_object_ids(
    records
) = [
    for (record = records)
        if (record[PSQ_REVIEW])
            record[PSQ_OBJECT_ID]
];

function portable_quality_records_with_flag(
    records,
    flag
) = [
    for (record = records)
        if (in_list(flag, record[PSQ_FLAGS]))
            record
];

function portable_quality_flag_count(
    records,
    flag
) =
    len(
        portable_quality_records_with_flag(
            records,
            flag
        )
    );

function portable_quality_total_shared_seam(
    records
) =
    sum([
        for (record = records)
            record[PSQ_TOTAL_SEAM_LENGTH]
    ]) / 2;
