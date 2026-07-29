# Portable section occupancy

## Purpose

Batch 011 determines which resolved rectangular cells contain actual
portable glyph area.

Occupancy is calculated from BOSL2 point-list regions before rendering.
It does not inspect OpenSCAD CSG output and does not sample pixels.

## Workbenches

```text
workbenches/portable_section_occupancy.scad
workbenches/portable_occupied_section_layout.scad
workbenches/portable_occupied_section_export.scad
```

## Occupancy record

Every configured grid cell receives an immutable indexed record with:

```text
column and row
section ID
set-and-glyph object ID
global bounds
local bounds
clipped area
cell-area ratio
clipped component count
occupied Boolean
occupied or empty status
clipped BOSL2 region
```

Records are row-major and retain every configured cell.

## Geometry operation

For each cell:

```text
clipped region =
    intersection(
        exact-height normalized glyph region,
        rectangular cell region
    )
```

Area is computed with `region_area()`. Connected clipped components are
counted with `region_parts()`.

## Status

```text
occupied  clipped area > occupancy area epsilon
empty     clipped area <= occupancy area epsilon
```

The default area epsilon is:

```text
0.000001 mm²
```

Zero-area or boundary-only contact is intentionally treated as empty.

## Occupied ordinal

Occupied records preserve row-major order. The occupied-only export
workbench selects an occupied ordinal rather than a raw grid cell.

Ordinal zero is the first occupied record. The console reports the
occupied section IDs and object IDs before export.

## Area partition report

For a complete automatic grid, the sum of all clipped cell areas should
equal the normalized glyph area within Boolean arithmetic tolerance.
Batch 011 reports the delta but does not use it to classify cut quality.

## Deferred

Occupancy does not decide whether an occupied fragment is desirable.
The following remain in the next priority:

```text
small-island detection
thin-fragment detection
multiple-fragment warnings
seam-contact analysis
cuts near vertices or counters
automatic cut relocation
```
