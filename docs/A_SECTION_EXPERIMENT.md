# Uppercase A section experiment

## Batch 004 change

The `A` is normalized to an exact assembled height before any section
cell is applied.

The default is:

```text
normalization method: resize
target height: 600 mm
profile anchor: center-bottom
grid origin: [-300, 0]
cell size: [200, 200]
grid: 3 × 3
```

## Evaluation sequence

1. Configure and identify the font source.
2. Inspect `font_inventory.scad`.
3. Inspect `a_normalized_profile.scad`.
4. Confirm the target-height reference.
5. Inspect `a_section_plan.scad`.
6. Adjust grid origin or dimensions if a cut crosses an unwanted region.
7. Inspect `a_section_layout.scad`.
8. Export occupied-looking cells through `a_section_export.scad`.
9. Slice, print, and place the plain sections together.

## Hazard guides

The apex, counter, and crossbar guides are normalized-height ratios.
They remain adjustable visual aids. They are not measured glyph
geometry and do not move the section grid.

## Success criterion

A source-specific uppercase A can be normalized to a requested physical
height, divided into bed-sized sections, exported one cell at a time,
printed, and placed together as a recognizable larger glyph.
