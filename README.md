# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

The project currently contains:

- generic dossiers for 66 characters;
- a source-observation framework;
- a captured 20-character portable proof set;
- an exact-height portable uppercase-A sectioning route.

## Development history

### Batch 001 — character anatomy

Generic dossiers were created for uppercase, lowercase, digits, and
selected punctuation.

### Batch 002 — source-specific observation

Three source slots and a manual observation ledger were added.

### Batch 003 — first sectional A experiment

A live OpenSCAD `text()` glyph was clipped with a rectangular grid.

### Batch 004 — exact-height live-font normalization

The live `text()` route gained exact-height normalization methods.

### Batch 005 — portable captured glyph set

Liberation Sans Regular was extracted directly from its TTF file into
portable contour records. BOSL2 validates and renders those records.

### Batch 006 — portable A sectioning

The portable `U_A` record is now the authoritative source for:

```text
exact-height normalization
normalized width and bounds
section-plan preview
exploded section layout
one-cell section export
section manifest
```

The portable pipeline contains no `text()` call and requires no
installed font.

## Authoritative portable A workbenches

```text
workbenches/portable_a_normalized_profile.scad
workbenches/portable_a_section_plan.scad
workbenches/portable_a_section_layout.scad
workbenches/portable_a_section_export.scad
```

The default experiment is:

```text
portable set: LIBERATION_SANS_REGULAR_R1
glyph: U_A
target height: 600 mm
extrusion depth: 6 mm
normalized anchor: center-bottom
grid origin: [-300, 0]
cell size: [200, 200]
grid: 3 × 3
configured bed: [220, 220]
```

For the captured Liberation Sans `A`, the source region bounds are:

```text
[4, 0, 1362, 1409] font units
```

At 600 mm assembled height, the portable route reports the exact
normalization scale and resulting width from those captured bounds.

## Portable section manifest

Every configured cell reports:

```text
section ID
zero-based column and row
global bounds
local export bounds
```

The selected export is translated so the cell's lower-left corner is
local `[0, 0]`.

Batch 006 does not classify occupied and empty cells. The manifest is a
deterministic grid inventory; an empty intersection renders no geometry.

## Comparison-only live-font route

These workbenches remain for comparison and regression testing:

```text
workbenches/a_normalized_profile.scad
workbenches/a_section_plan.scad
workbenches/a_section_layout.scad
workbenches/a_section_export.scad
workbenches/portable_vs_live.scad
```

They are no longer the authoritative portable object route.

## Portable proof-set workbenches

```text
workbenches/portable_glyph.scad
workbenches/portable_contact_sheet.scad
workbenches/portable_region_diagnostics.scad
workbenches/portable_vs_live.scad
```

## Batch 006 tests

Open each directly and press F5:

```text
tests/portable_normalization_contract.scad
tests/portable_a_section_render_contract.scad
tests/portable_a_export_contract.scad
```

Then rerun:

```text
tests/portable_registry_contract.scad
tests/portable_bosl2_contract.scad
tests/portable_component_color_contract.scad
tests/portable_render_contract.scad
```

## Still deferred

```text
occupied-cell computation
automatic cut relocation
connectors
attachment methods
inter-character spacing
mounting
portable sectioning of glyphs other than U_A
expansion from 20 to 66 captured characters
accepted physical objects
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
