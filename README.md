# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Stored portable catalog

The repository contains six isolated portable font sets:

```text
LIBERATION_SANS_REGULAR_R1
MONTSERRAT_REGULAR_R1
ALPHA_SLAB_ONE_REGULAR_R1
FIRA_SANS_REGULAR_R1
MIAMA_NUEVA_MEDIUM_R1
PLAYFAIR_DISPLAY_REGULAR_R1
```

Each contains the same 66 dossier identities:

```text
6 sets × 66 glyphs = 396 portable profiles
```

Catalog identity is:

```text
portable set ID + glyph ID
```

## Generic exact-height normalization

Open:

```text
workbenches/portable_normalized_profile.scad
```

Select any stored family and glyph, then set the requested visible
height and extrusion depth.

The normalization authority is the captured BOSL2 region bounds:

```text
visible horizontal center = X 0
visible bottom = Y 0
visible height = requested height
```

The console reports exact source bounds, scale, normalized width,
normalized bounds, normalized source-baseline position, normalized
advance width, components, counters, and source checksum.

This route does not call:

```text
text()
resize()
textmetrics()
```

It does not consult the operating-system font inventory.

## Multi-family catalog

```text
workbenches/portable_catalog.scad
```

It supports direct set-and-glyph selection, normal 2D or 3D rendering,
component diagnostics, and contact sheets.

## Family comparison

```text
workbenches/portable_family_comparison.scad
```

This renders one selected glyph from all six stored packages.

## Family-selectable sheets

```text
workbenches/portable_contact_sheet.scad
workbenches/portable_uppercase_sheet.scad
workbenches/portable_lowercase_sheet.scad
workbenches/portable_digit_sheet.scad
workbenches/portable_punctuation_sheet.scad
```

## Portable A sectioning

The accepted sectioning experiment remains deliberately fixed to the
captured Liberation Sans `U_A`:

```text
workbenches/portable_a_normalized_profile.scad
workbenches/portable_a_section_plan.scad
workbenches/portable_a_section_layout.scad
workbenches/portable_a_section_export.scad
```

Batch 009 does not change that route.

## Batch 009 tests

```text
tests/portable_generic_normalization_contract.scad
tests/portable_descender_normalization_contract.scad
tests/portable_punctuation_normalization_contract.scad
tests/portable_multi_family_normalization_contract.scad
tests/portable_generic_normalized_render_contract.scad
```

## Deferred priorities

```text
generic section plan, layout, and export
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
