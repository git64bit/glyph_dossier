//////////////////////////////////////////////////////////////////////
// LibFile: portable_normalization_validation.scad
// Project: Glyph Dossier
// FileGroup: Portable Normalization Contracts
// FileSummary: Validates generic exact-height portable profiles.
//////////////////////////////////////////////////////////////////////

module validate_portable_normalization_profile(
    set_record,
    glyph,
    target_height,
    depth,
    bounds_line_width
) {
    tolerance = 0.000001;
    normalized_bounds = portable_normalized_bounds(
        glyph,
        target_height
    );

    assert(
        glyph[PG_SOURCE_SHA256]
            == set_record[PFS_SOURCE_SHA256],
        str(
            "Selected glyph does not belong to selected set: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        target_height > 0,
        "Portable normalized height must be positive."
    );
    assert(
        depth > 0,
        "Portable normalized extrusion depth must be positive."
    );
    assert(
        bounds_line_width > 0,
        "Portable normalized bounds line width must be positive."
    );
    assert(
        portable_glyph_width(glyph) > 0,
        str("Portable source width is invalid: ", glyph[PG_ID])
    );
    assert(
        portable_glyph_height(glyph) > 0,
        str("Portable source height is invalid: ", glyph[PG_ID])
    );
    assert(
        abs(
            portable_normalized_height(
                glyph,
                target_height
            ) - target_height
        ) < tolerance,
        str(
            "Portable normalized height mismatch: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        abs(normalized_bounds[1]) < tolerance,
        str(
            "Portable normalized bottom is not zero: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        abs(
            normalized_bounds[3]
            - target_height
        ) < tolerance,
        str(
            "Portable normalized top mismatch: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        abs(
            normalized_bounds[0]
            + normalized_bounds[2]
        ) < tolerance,
        str(
            "Portable normalized profile is not centered: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
    assert(
        portable_normalized_width(
            glyph,
            target_height
        ) > 0,
        str(
            "Portable normalized width is invalid: ",
            set_record[PFS_ID],
            " ",
            glyph[PG_ID]
        )
    );
}
