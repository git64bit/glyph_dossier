# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Stored portable catalog

The unified repository contains six embedded portable font sets and
sixty-six glyph identities per set:

```text
6 sets × 66 glyphs = 396 portable profiles
```

Catalog identity is:

```text
portable set ID + glyph ID
```

## Generic normalization

```text
workbenches/portable_normalized_profile.scad
```

Any stored profile can be normalized to an exact visible height without
`text()`, `resize()`, `textmetrics()`, or operating-system font lookup.

## Generic sectioning

```text
workbenches/portable_section_plan.scad
workbenches/portable_section_layout.scad
workbenches/portable_section_export.scad
```

Generic sectioning supports all 396 profiles.

Grid modes:

```text
auto   derive complete centered-bottom grid from target and cell size
manual use explicit origin, columns, and rows
```

Every cell receives a deterministic object ID and local export bounds.

Batch 010 does not compute occupied cells. Empty intersections render no
geometry but remain in the manifest.

## Fixed A laboratory route

The accepted Liberation Sans `U_A` experiment remains unchanged:

```text
workbenches/portable_a_normalized_profile.scad
workbenches/portable_a_section_plan.scad
workbenches/portable_a_section_layout.scad
workbenches/portable_a_section_export.scad
```

## Batch 010 tests

```text
tests/portable_generic_section_resolution_contract.scad
tests/portable_generic_section_manifest_contract.scad
tests/portable_generic_section_render_contract.scad
tests/portable_generic_section_export_contract.scad
```

## Remaining priorities

```text
BOSL2 occupied-cell detection
fragment and cut-quality reporting
segmented-font schema and procedural adapter
additional segmented and modular families
deterministic export packages
attachment geometry
physical acceptance
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
