# Uppercase A section experiment

## Why A is first

Uppercase `A` combines:

- two long diagonal strokes;
- an acute apex;
- an enclosed counter;
- a horizontal crossbar;
- narrow internal transitions.

It exposes more sectioning failures than a simple rectilinear glyph.

## Default plan

```text
nominal font size: 600 mm
extrusion depth: 6 mm
grid origin: [-300, -20]
cell size: [200, 200]
grid: 3 × 3
```

The nominal font size is passed directly to OpenSCAD `text()`. It is not
a claim that the physical cap height is exactly 600 mm.

## Hazard guides

The plan may show three nominal design regions:

1. apex line;
2. counter rectangle;
3. crossbar line.

Their ratios are manually adjustable. They do not measure the selected
font and do not automatically reposition the clipping grid.

The purpose is to make conflicts visible. A grid line crossing one of
these regions can be corrected by changing the grid origin, cell
dimensions, or grid count.

## Evaluation sequence

1. Select and identify a source.
2. Inspect the full plan.
3. Adjust the grid until the cut pattern is acceptable.
4. Inspect the exploded layout.
5. Export several occupied cells.
6. Slice and print the sections.
7. Place the plain cut faces together and inspect the reconstructed A.

Attachment methods remain outside this experiment.

## Success criterion

Batch 003 succeeds when a source-specific uppercase A can be rendered,
divided into bed-sized cells, exported one cell at a time, printed, and
placed together as a recognizable larger glyph.
