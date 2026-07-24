# Glyph Dossier

Glyph Dossier analyzes individual English characters and develops a
controlled path toward sectional large-format printing.

The project covers:

- 26 uppercase letters;
- 26 lowercase letters;
- digits 0–9;
- `?`, `!`, `:`, and `;`.

## Batch 001: character anatomy

Every character has a generic dossier describing expected components,
counters, vertical class, archetype, significant features, font
variations, and sectioning risks.

## Batch 002: source-specific observation

Three configurable font sources and a pending observation ledger support
manual source-specific inspection without fabricated measurements.

## Batch 003: first sectional experiment

Batch 003 sections uppercase `A` only.

The experiment deliberately uses plain rectangular clipping cells. The
grid is explicit and manually controlled:

```text
grid origin
cell width and height
column and row count
selected column and row
```

No connector or attachment geometry is included.

Three views are provided:

```text
workbenches/a_section_plan.scad
workbenches/a_section_layout.scad
workbenches/a_section_export.scad
```

### Section plan

Shows the complete source-specific `A`, the clipping grid, and optional
nominal hazard guides for:

- the apex;
- the counter region;
- the crossbar region.

The hazard guides are adjustable visual aids. They are not measured font
geometry and do not move cuts automatically.

### Section layout

Clips every grid cell and places the resulting sections in an exploded
layout. Empty cells simply render no geometry.

### Section export

Clips one selected row and column, then translates that section into
local positive cell coordinates for STL export.

## Batch 003 default experiment

```text
nominal font size: 600 mm
grid: 3 columns × 3 rows
cell: 200 × 200 mm
grid origin: X = -300 mm, Y = -20 mm
```

The cell dimensions fit within a 220 × 220 mm configured printer bed.

These values are laboratory defaults, not claims about the exact
physical cap height of the selected font.

## Complete test order

Open each file directly and press F5:

```text
tests/catalog_contract.scad
tests/representative_set.scad
tests/render_contract.scad
tests/source_registry_contract.scad
tests/observation_contract.scad
tests/source_render_contract.scad
tests/section_math_contract.scad
tests/a_section_render_contract.scad
```

## Still deferred

```text
connectors
attachment methods
inter-character spacing
mounting
automatic font-outline measurement
automatic cut optimization
accepted physical objects
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
