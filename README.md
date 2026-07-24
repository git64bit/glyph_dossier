# Glyph Dossier

Glyph Dossier analyzes individual English characters before designing a
large-format sectioning system.

The project covers:

- 26 uppercase letters;
- 26 lowercase letters;
- digits 0–9;
- `?`, `!`, `:`, and `;`.

## Batch 001 objective

The first batch creates a character-level design basis. Each dossier
records:

- expected connected-component range;
- expected counter range;
- vertical extent class;
- geometric archetype;
- significant anatomical features;
- likely sectioning risks;
- font-dependent variants;
- study priority;
- a concise design note.

These are anatomical expectations, not automatically measured font
metrics.

## Representative study set

```text
A B O S Z
a g i j m s
0 1 2 4 8
? ! : ;
```

This set covers diagonals, curves, counters, narrow waists, ascenders,
descenders, repeated arches, disconnected components, and major
font-form variations.

## Workbenches

```text
workbenches/laboratory.scad
workbenches/profile.scad
workbenches/contact_sheet.scad
workbenches/catalog.scad
```

`laboratory.scad` is the main character-inspection workbench.

The font name may be left empty to use OpenSCAD’s default font or set to
an installed family and style.

## Tests

Open each file directly and press F5:

```text
tests/catalog_contract.scad
tests/representative_set.scad
tests/render_contract.scad
```

## Deferred work

Batch 001 does not create section cuts, connectors, assembly spacing,
mounting systems, or accepted printable objects.

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
