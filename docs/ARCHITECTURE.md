# Architecture

Glyph Dossier separates source capture, normalization, sectioning,
occupancy, and quality screening.

## Data path

```text
embedded font set
        ↓
exact set ID + glyph ID lookup
        ↓
normalized BOSL2 region
        ↓
automatic or manual rectangular grid
        ↓
exact clipped occupancy records
        ↓
immutable quality records
```

## Quality layer

Batch 012 reads accepted occupancy records and derives:

```text
component metrics
shared seam metrics
flattened source-vertex cut proximity
fragment bounds
configured-bed fit
review flags
```

Implementation:

```text
lib/portable_section_quality_schema.scad
lib/portable_section_quality_math.scad
lib/portable_section_quality_vertices.scad
lib/portable_section_quality.scad
lib/portable_section_quality_validation.scad
lib/portable_section_quality_reporting.scad
geometry/portable_section_quality_scene.scad
```

The quality layer is diagnostic. It does not mutate normalized geometry,
grids, occupancy records, or section exports.

## Fixed route

The earlier `portable_a_*` section experiment remains separate and
unchanged.

## Next boundary

The next planned source layer is a segmented-display schema and
procedural segment adapter.
