# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Portable catalog

The unified repository contains:

```text
6 embedded font sets
66 glyph identities per set
396 selectable portable profiles
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
live font lookup.

## Generic sectioning

```text
workbenches/portable_section_plan.scad
workbenches/portable_section_layout.scad
workbenches/portable_section_export.scad
```

Automatic and manual rectangular grids support all 396 profiles.

## Occupied-cell detection

```text
workbenches/portable_section_occupancy.scad
workbenches/portable_occupied_section_layout.scad
workbenches/portable_occupied_section_export.scad
```

Each cell is intersected with the exact normalized BOSL2 glyph region.
The resulting clipped region supplies area, cell-area ratio, connected
component count, status, and deterministic identity.

Occupied-only export selects a row-major occupied ordinal, so empty cells
no longer need to be inspected or exported.

Zero-area or boundary-only contact is treated as empty.

## Fixed A laboratory route

The accepted Liberation Sans `U_A` experiment remains unchanged:

```text
workbenches/portable_a_normalized_profile.scad
workbenches/portable_a_section_plan.scad
workbenches/portable_a_section_layout.scad
workbenches/portable_a_section_export.scad
```

## Batch 011 tests

```text
tests/portable_occupancy_boolean_contract.scad
tests/portable_occupancy_manifest_contract.scad
tests/portable_occupancy_partition_contract.scad
tests/portable_occupancy_render_contract.scad
```

## Remaining priorities

```text
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
