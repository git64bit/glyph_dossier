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

Uppercase `A` was clipped through an explicit rectangular grid without
connectors or attachment assumptions.

## Batch 004: exact-height normalization

The source-specific `A` is now normalized before sectioning.

The default method is:

```text
resize
```

It uses OpenSCAD `resize()` to fit the actual rendered profile to the
configured assembled height while preserving its aspect ratio.

Additional methods are available:

```text
manual
textmetrics
```

`manual` uses explicit profile bounds entered at a known probe size.

`textmetrics` uses the development-snapshot `textmetrics()` function.
It should be selected only in an OpenSCAD build that provides that
function.

All methods establish a center-bottom profile anchor:

```text
X = 0 at the horizontal profile center
Y = 0 at the profile bottom
```

The section grid is applied after normalization.

## Font inventory

Open:

```text
workbenches/font_inventory.scad
```

The console reports:

```text
OpenSCAD version
OpenSCAD version number
Help > Font List
configured source IDs and exact font strings
license, URL, and revision fields
bundled portable font families
```

The complete machine-specific list remains OpenSCAD's **Help > Font
List** pane. A SCAD file does not enumerate every installed font.

The workbench has an optional `runtime_fontmetrics_enabled` switch. When
enabled in a compatible development snapshot, it echoes `fontmetrics()`
for each configured source, including the family and style that
OpenSCAD actually resolved.

## Normalized A workbenches

```text
workbenches/a_normalized_profile.scad
workbenches/a_section_plan.scad
workbenches/a_section_layout.scad
workbenches/a_section_export.scad
```

The three sectioning workbenches now operate on normalized geometry.

### Default normalized experiment

```text
target assembled height: 600 mm
profile anchor: center-bottom
grid: 3 columns × 3 rows
cell: 200 × 200 mm
grid origin: X = -300 mm, Y = 0 mm
configured bed: 220 × 220 mm
```

### Section manifest

Every sectioning workbench reports all configured cells:

```text
section ID
zero-based column and row
global bounds
local print bounds
```

OpenSCAD does not report whether a cell intersection is empty. Empty
cells simply render no geometry.

## Tests

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
tests/font_inventory_contract.scad
tests/normalization_math_contract.scad
tests/normalized_a_render_contract.scad
```

## Still deferred

```text
connectors
attachment methods
inter-character spacing
mounting
automatic cut optimization
other sectional glyphs
accepted physical objects
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
