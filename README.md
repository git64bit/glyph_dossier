# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Portable catalog

```text
6 embedded font sets
66 glyph identities per set
396 selectable portable profiles
```

## Generic normalization and sectioning

```text
workbenches/portable_normalized_profile.scad
workbenches/portable_section_plan.scad
workbenches/portable_section_layout.scad
workbenches/portable_section_export.scad
```

Automatic and manual rectangular grids support every stored profile.

## Occupied-cell detection

```text
workbenches/portable_section_occupancy.scad
workbenches/portable_occupied_section_layout.scad
workbenches/portable_occupied_section_export.scad
```

BOSL2 clipped regions provide exact occupied area, component count, and
occupied-only export identity.

## Fragment and cut-quality reporting

```text
workbenches/portable_section_quality.scad
```

The quality workbench reports:

```text
small and disconnected components
component span and effective-thickness estimates
shared seam lengths and interval counts
flattened source-vertex proximity to cuts
counter-cut candidates
actual fragment bed fit
```

Views include a quality plan, review-only exploded layout, and
report-only mode.

Thresholds are visible operator controls. The quality layer does not
move cuts or alter section geometry.

## Fixed A laboratory route

The accepted Liberation Sans `U_A` experiment remains unchanged.

## Batch 012 tests

```text
tests/portable_quality_math_contract.scad
tests/portable_quality_threshold_contract.scad
tests/portable_quality_manifest_contract.scad
tests/portable_quality_render_contract.scad
```

## Remaining priorities

```text
segmented-font schema and procedural adapter
additional segmented and modular families
deterministic export packages
attachment geometry
physical acceptance
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
