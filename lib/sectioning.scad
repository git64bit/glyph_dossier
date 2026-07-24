//////////////////////////////////////////////////////////////////////
// LibFile: sectioning.scad
// Project: Glyph Dossier
// FileGroup: Section Mathematics
// FileSummary: Pure grid bounds, identifiers, and layout functions.
//////////////////////////////////////////////////////////////////////

function section_count(columns, rows) =
    columns * rows;

function section_plan_width(cell_width, columns) =
    cell_width * columns;

function section_plan_height(cell_height, rows) =
    cell_height * rows;

function section_x0(origin_x, cell_width, column) =
    origin_x + column * cell_width;

function section_x1(origin_x, cell_width, column) =
    section_x0(origin_x, cell_width, column) + cell_width;

function section_y0(origin_y, cell_height, row) =
    origin_y + row * cell_height;

function section_y1(origin_y, cell_height, row) =
    section_y0(origin_y, cell_height, row) + cell_height;

function section_id(column, row) =
    str("C", column + 1, "_R", row + 1);

function section_layout_x(column, cell_width, gap) =
    column * (cell_width + gap);

function section_layout_y(row, cell_height, gap) =
    row * (cell_height + gap);
