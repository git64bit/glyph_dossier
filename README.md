# Glyph Dossier

Glyph Dossier develops portable, analyzable character geometry for
large sectional construction.

## Current portable set

Batch 007 completes the Liberation Sans Regular package for every
current dossier character:

```text
26 uppercase
26 lowercase
10 digits
4 punctuation marks
66 total glyphs
```

The package is stored under:

```text
glyph_sets/liberation_sans_regular/
```

Every glyph contains:

```text
exact TTF bounds
flattened region bounds
advance width
contour count
component count
counter count
point count
BOSL2 region paths
diagnostic SVG
source checksum
```

Normal portable rendering does not use `text()` and does not require an
installed operating-system font.

## Complete portable workbenches

```text
workbenches/portable_catalog.scad
workbenches/portable_uppercase_sheet.scad
workbenches/portable_lowercase_sheet.scad
workbenches/portable_digit_sheet.scad
workbenches/portable_punctuation_sheet.scad
```

The original representative sheet remains:

```text
workbenches/portable_contact_sheet.scad
```

`portable_catalog.scad` allows exact selection of any of the 66 captured
IDs.

## Immutable representative lock

The original Batch 005 proof set remains immutable:

```text
A B O S Z
a g i j m s
0 1 2 4 8
? ! : ;
```

The package contains:

```text
representative_lock.json
representative_lock.scad
```

The lock preserves:

```text
character
exact bounds
region bounds
contour count
component count
counter count
point count
generated SCAD checksum
generated SVG checksum
```

The extractor builds into a staging directory and stops before replacing
the package if any locked value or generated artifact changes.

## Rebuilding the complete package

From the repository root:

```text
python tools/extract_glyph_set.py   --font glyph_sets/liberation_sans_regular/source/LiberationSans-Regular.ttf   --spec tools/full_character_set.json   --out glyph_sets/liberation_sans_regular   --lock glyph_sets/liberation_sans_regular/representative_lock.json
```

Verify afterward:

```text
python tools/verify_glyph_set.py   glyph_sets/liberation_sans_regular
```

No system font query occurs.

## Portable A sectioning

The authoritative sectional route remains unchanged:

```text
workbenches/portable_a_normalized_profile.scad
workbenches/portable_a_section_plan.scad
workbenches/portable_a_section_layout.scad
workbenches/portable_a_section_export.scad
```

It continues to use the captured BOSL2 `U_A` record.

## Batch 007 tests

```text
tests/portable_registry_contract.scad
tests/portable_full_coverage_contract.scad
tests/portable_category_sets_contract.scad
tests/portable_representative_metadata_lock.scad
tests/portable_bosl2_contract.scad
tests/portable_render_contract.scad
```

## Deferred

```text
generic normalization for all 66 glyphs
generic sectioning
occupied-cell computation
automatic cut relocation
connectors
attachment methods
additional font families
accepted physical objects
```

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
