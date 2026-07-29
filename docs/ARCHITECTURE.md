# Architecture

Glyph Dossier separates source capture, normalization, sectioning, and
section analysis.

## Portable source layer

```text
embedded font package
        ↓
exact set ID + glyph ID lookup
        ↓
captured BOSL2 region
```

## Generic normalization layer

```text
captured region bounds
        ↓
exact target-height scale
        ↓
visible-center-bottom normalized region
```

## Generic sectioning layer

```text
normalized portable region
        ↓
automatic or manual rectangular grid
        ↓
deterministic section manifest
        ↓
plan, exploded layout, or local cell export
```

## Occupancy layer

Batch 011 adds data-level Boolean analysis:

```text
normalized portable region
        +
one rectangular cell region
        ↓
BOSL2 intersection()
        ↓
clipped region
        ↓
area, ratio, components, occupied status
```

All cell records are created once for the selected workbench operation.
Occupied-only layout and export render the recorded clipped region rather
than repeating CSG clipping.

Implementation:

```text
lib/portable_section_occupancy_schema.scad
lib/portable_section_occupancy.scad
lib/portable_section_occupancy_validation.scad
lib/portable_section_occupancy_reporting.scad
geometry/portable_section_occupancy_scene.scad
```

## Fixed A route

The earlier `portable_a_*` route remains separate and unchanged.

## Next boundary

Fragment and cut-quality reporting should consume the accepted occupancy
records. It must not modify normalization, grid resolution, or clipping.
