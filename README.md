# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for large
sectional construction.

## Multi-family portable catalog

Batch 008 stores six isolated portable families:

```text
LIBERATION_SANS_REGULAR_R1
MONTSERRAT_REGULAR_R1
ALPHA_SLAB_ONE_REGULAR_R1
FIRA_SANS_REGULAR_R1
MIAMA_NUEVA_MEDIUM_R1
PLAYFAIR_DISPLAY_REGULAR_R1
```

Each family contains the same 66 dossier identities. Catalog identity is:

```text
portable set ID + glyph ID
```

For example, `U_A` may exist in every set without a registry collision.

## Main catalog

Open:

```text
workbenches/portable_catalog.scad
```

Select:

```text
portable_set_id_selected
portable_glyph_id_selected
```

The normal catalog route does not call `text()` and does not use the
operating-system font inventory.

## Family comparison

```text
workbenches/portable_family_comparison.scad
```

This renders the same selected glyph from all six stored contour packages.
The console reports the family order and normalized width.

## Family-selectable sheets

```text
workbenches/portable_contact_sheet.scad
workbenches/portable_uppercase_sheet.scad
workbenches/portable_lowercase_sheet.scad
workbenches/portable_digit_sheet.scad
workbenches/portable_punctuation_sheet.scad
```

## New package contents

Each new package stores:

```text
66 namespaced SCAD glyph records
66 diagnostic SVG files
category SVG contact sheets
set.json
manifest.scad
package_lock.json
checksums.sha256
license and provenance
source filename and expected source SHA-256
```

Source font binaries are not part of the package. Reproduction uses an
external source file matching the recorded checksum.

## Extracting again

```text
python tools/extract_namespaced_font_set.py \
  --font /path/to/source-font.otf \
  --font-spec tools/font_specs/montserrat_regular.json \
  --glyph-spec tools/full_character_set.json \
  --out glyph_sets/montserrat_regular \
  --lock glyph_sets/montserrat_regular/package_lock.json
```

A changed source, contour, bound, point count, SCAD record, or diagnostic
SVG stops replacement.

## Tests

```text
tests/portable_font_set_registry_contract.scad
tests/portable_font_set_isolation_contract.scad
tests/portable_catalog_selection_contract.scad
tests/portable_multi_family_render_contract.scad
```

The existing Liberation Sans `portable_a_*` workbenches remain A-only and
unchanged.
