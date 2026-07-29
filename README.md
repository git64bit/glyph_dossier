# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Imported portable catalog

```text
6 embedded font sets
66 glyph identities per set
396 selectable portable profiles
```

Imported packages remain unified under `glyph_sets/`.

## Generic pipeline

The accepted portable pipeline provides:

```text
exact-height normalization
automatic and manual rectangular sectioning
BOSL2 occupied-cell detection
fragment and cut-quality screening
```

## Procedural segmented sources

Batch 013 adds two project-authored adapters:

```text
PROCEDURAL_14_SEGMENT_EXTENDED_R1
PROCEDURAL_7_SEGMENT_EXTENDED_R1
```

Workbenches:

```text
workbenches/segmented_catalog.scad
workbenches/segmented_pipeline.scad
workbenches/segmented_contact_sheet.scad
```

The segmented schema distinguishes:

```text
visible
intentional_blank
unsupported
```

Visible masks convert to the existing portable-glyph record and can
enter normalization, sectioning, and occupied-cell detection.

Blank and unsupported mappings remain selectable catalog states. In a
pipeline view they report that portable geometry is unavailable and
render the source-state frame without raising an assertion.

The segmented sets remain separate from the six imported font families.

## Batch 013 tests

```text
tests/segmented_schema_contract.scad
tests/segmented_status_contract.scad
tests/segmented_adapter_contract.scad
tests/segmented_pipeline_contract.scad
tests/segmented_render_contract.scad
```

## Fixed A laboratory route

The accepted Liberation Sans `portable_a_*` experiment remains
unchanged.

## Remaining priorities

```text
additional segmented and modular families
deterministic export packages
attachment geometry
physical acceptance
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
