# Architecture

Glyph Dossier now has two deliberately separated pipelines.

## Portable authoritative pipeline

```text
TTF source retained with license and checksum
        ↓
external extractor
        ↓
captured contour records
        ↓
BOSL2 region validation
        ↓
exact numeric center-bottom normalization
        ↓
rectangular section plan
        ↓
exploded layout or local section export
```

Batch 006 implements this pipeline for `U_A`.

The runtime portable route begins at:

```text
portable_main.scad
```

Its sectioning layers are:

```text
config/portable_section_defaults.scad
lib/portable_section_validation.scad
lib/portable_section_reporting.scad
geometry/portable_section_scene.scad
```

The pipeline does not call `text()`.

## Live comparison pipeline

The earlier live-font route remains under:

```text
main.scad
geometry/normalized_glyph.scad
geometry/section_scene.scad
workbenches/a_*.scad
```

It remains useful for comparing live font rendering against the captured
portable geometry. It is no longer the authoritative portable export
route.

## Shared grid mathematics

Both routes use:

```text
lib/sectioning.scad
geometry/section_grid.scad
geometry/a_hazard_map.scad
```

This keeps cell identifiers, bounds, and layout coordinates consistent.

## Portable exact bounds

The portable record contains its source-region bounds. Batch 006 derives
the scale, normalized width, and normalized bounds numerically before
rendering.

## Deferred region booleans

BOSL2 can operate on regions as data, but Batch 006 does not yet use
region intersections to compute occupied cells or relocate cuts.
