# Architecture

Glyph Dossier separates font capture from runtime geometry.

## Portable source layer

```text
retained source identity and license
        ↓
external extraction
        ↓
immutable SCAD contour records
        ↓
isolated font-set registry
        ↓
exact set ID + glyph ID lookup
```

Six embedded sets currently expose 396 portable profiles.

## Generic normalization layer

Batch 009 adds a shared normalization route:

```text
selected font set
        ↓
selected portable glyph
        ↓
captured BOSL2 region bounds
        ↓
exact scale from requested visible height
        ↓
center-bottom normalized region
        ↓
profile rendering and numeric report
```

The implementation is distributed across:

```text
geometry/portable_glyph_region.scad
lib/portable_normalization_validation.scad
lib/portable_normalization_reporting.scad
geometry/portable_normalized_profile_scene.scad
portable_catalog_main.scad
workbenches/portable_normalized_profile.scad
```

The generic route does not call `text()`, `resize()`, or
`textmetrics()`.

## Baseline preservation

Runtime geometry is anchored to its visible bottom, but the source
baseline remains recoverable from captured bounds. Descenders and
punctuation therefore normalize consistently without losing their
original baseline relationship.

## Fixed A sectioning layer

The earlier Liberation Sans `U_A` sectioning experiment remains a
separate accepted path. Batch 009 does not alter it.

## Next architectural boundary

Generic sectioning should consume the generic normalized region from
Batch 009. It should not depend on A-specific hazard guides.
