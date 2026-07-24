//////////////////////////////////////////////////////////////////////
// LibFile: section_math_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Grid bounds, IDs, counts, and layout mathematics.
//////////////////////////////////////////////////////////////////////

include <../lib/sectioning.scad>

origin_x = -300;
origin_y = -20;
cell_width = 200;
cell_height = 200;
columns = 3;
rows = 3;

assert(section_count(columns, rows) == 9);
assert(section_plan_width(cell_width, columns) == 600);
assert(section_plan_height(cell_height, rows) == 600);

assert(section_x0(origin_x, cell_width, 0) == -300);
assert(section_x1(origin_x, cell_width, 0) == -100);
assert(section_x0(origin_x, cell_width, 2) == 100);
assert(section_x1(origin_x, cell_width, 2) == 300);

assert(section_y0(origin_y, cell_height, 0) == -20);
assert(section_y1(origin_y, cell_height, 0) == 180);
assert(section_y0(origin_y, cell_height, 2) == 380);
assert(section_y1(origin_y, cell_height, 2) == 580);

assert(section_id(0, 0) == "C1_R1");
assert(section_id(2, 2) == "C3_R3");
assert(section_layout_x(2, 200, 20) == 440);
assert(section_layout_y(2, 200, 20) == 440);

echo("PASS", "section_math_contract");
