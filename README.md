# Glyph Dossier

Glyph Dossier analyzes individual English characters and develops a
controlled path toward sectional large-format printing.

## Batch 005: portable glyph source proof

The project now contains one complete font-independent capture package:

```text
glyph_sets/liberation_sans_regular/
```

The source is **Liberation Sans Regular 2.1.5**, licensed under the SIL
Open Font License 1.1.

The package contains:

```text
original TTF
license and provenance
20 representative glyphs
exact SVG path output per glyph
flattened point-list region per glyph
generated SCAD record per glyph
JSON set metadata
SVG contact sheet
SHA-256 checksums
```

Normal use of the captured package does not call `text()` and does not
require the font to be installed by Windows, Linux, or macOS.

## BOSL2

Portable workbenches begin with:

```scad
include <BOSL2/std.scad>
```

BOSL2 is expected in the normal OpenSCAD user-library path. It is not
copied into this repository.

The captured point lists are treated as BOSL2 regions and checked with:

```text
is_region()
is_valid_region()
region_parts()
region_area()
```

## Representative capture set

```text
A B O S Z
a g i j m s
0 1 2 4 8
? ! : ;
```

This remains a 20-glyph proof. The full 66-glyph package is not yet
claimed.

## Portable workbenches

```text
workbenches/portable_glyph.scad
workbenches/portable_contact_sheet.scad
workbenches/portable_region_diagnostics.scad
workbenches/portable_vs_live.scad
```

`portable_vs_live.scad` is diagnostic only. Its left-hand object uses
live `text()`; the right-hand object uses the captured region.

## Regeneration

From the repository root:

```text
python -m venv .venv
.venv/bin/pip install -r tools/requirements.txt
.venv/bin/python tools/extract_glyph_set.py \
  --font glyph_sets/liberation_sans_regular/source/LiberationSans-Regular.ttf \
  --spec tools/representative_set.json \
  --out glyph_sets/liberation_sans_regular
```

On Windows, use `.venv\Scripts\python.exe` instead.

Verify the generated package:

```text
python tools/verify_glyph_set.py glyph_sets/liberation_sans_regular
```

## Batch 005 tests

Open each file directly and press F5:

```text
tests/portable_registry_contract.scad
tests/portable_bosl2_contract.scad
tests/portable_render_contract.scad
```

The previous tests remain valid and unchanged.

## Deliberately unchanged

Batch 005 does not connect captured regions to the sectioning pipeline.
It does not add connectors, spacing, mounting, or print procedures.

## Workflow

Discuss → bounded batch → delta ZIP → user test → user commit → supplied
commit SHA → reconciliation before the next batch.
