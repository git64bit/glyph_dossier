# Source-specific observation workflow

## 1. Configure source records

Open any Batch 002 workbench and fill the source slots:

```text
label
font name
license
URL
revision or file hash
```

## 2. Verify the source

Open:

```text
workbenches/font_source.scad
```

Select `SRC_1`, `SRC_2`, or `SRC_3`. The workbench renders the fixed
specimen:

```text
ABOSZ
agijms
01248
?!:;
```

## 3. Inspect one source across characters

Open:

```text
workbenches/source_contact_sheet.scad
```

This renders the 20-character representative set from one source.

## 4. Compare one character across sources

Open:

```text
workbenches/glyph_comparison.scad
```

The left-to-right source order is reported in the console.

## 5. Create an observation candidate

Open:

```text
workbenches/glyph_observation.scad
```

Choose the glyph and source. The generic dossier and pending ledger slot
are reported.

Enter the actual form variant, component count, counter count, extents,
minimum stroke, minimum gap, and note.

`-999999` means unknown.

The red rectangle represents entered bounds. The green strip represents
the entered minimum stroke. The purple parallel lines represent the
entered minimum gap. Probe coordinates are manual positioning aids and
are not stored as observation metrics.

## 6. Change status deliberately

- `pending` permits incomplete values.
- `observed` requires a complete valid record.
- `verified` uses the same completeness contract and is reserved for a
  second confirmed inspection.

The workbench echoes a complete `CANDIDATE_*` record. Batch 002 does not
automatically rewrite the registry.

## No sectioning

Observation is the only objective. Do not add cut lines or connector
logic while recording source geometry.
