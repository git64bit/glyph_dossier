# Glyph Dossier

Glyph Dossier analyzes individual English characters before designing a
large-format sectioning system.

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

Batch 002 binds the representative study set to configurable font
sources without claiming automatic font-outline measurement.

Three stable laboratory source identities are provided:

```text
SRC_1
SRC_2
SRC_3
```

Each source record contains:

```text
source ID
label
font family and style
license
source URL
revision or file hash
status
```

An empty font name uses OpenSCAD's default font.

The representative observation ledger begins with 20 pending records.
The observation workbench allows manual entry of:

```text
actual component count
actual counter count
observed form variant
left, right, bottom, and top extents
minimum stroke
minimum gap
status
notes
```

No values are fabricated. A record becomes an observation only after
the user inspects the named source and enters the values.

## Representative study set

```text
A B O S Z
a g i j m s
0 1 2 4 8
? ! : ;
```

## Batch 002 workbenches

```text
workbenches/font_source.scad
workbenches/glyph_observation.scad
workbenches/glyph_comparison.scad
workbenches/source_contact_sheet.scad
```

Existing Batch 001 workbenches remain valid:

```text
workbenches/laboratory.scad
workbenches/profile.scad
workbenches/contact_sheet.scad
workbenches/catalog.scad
```

### Recommended sequence

1. Configure `SRC_1`, `SRC_2`, and `SRC_3`.
2. Open `font_source.scad` to verify each source.
3. Open `source_contact_sheet.scad` to inspect one source across the
   representative set.
4. Open `glyph_comparison.scad` to compare the same character across the
   three source slots.
5. Open `glyph_observation.scad` and enter observed values manually.

## Tests

Open each file directly and press F5:

```text
tests/catalog_contract.scad
tests/representative_set.scad
tests/render_contract.scad
tests/source_registry_contract.scad
tests/observation_contract.scad
tests/source_render_contract.scad
```

## Deferred work

The project still does not create section cuts, connectors, attachment
methods, character spacing, mounting systems, or accepted printable
objects.

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
