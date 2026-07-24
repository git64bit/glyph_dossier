# Architecture

Glyph Dossier now has two deliberately separate source routes.

## Live font laboratory

```text
installed font name
→ OpenSCAD text()
→ observation and early section experiments
```

This route remains useful for exploration but depends on font resolution.

## Portable captured source

```text
font file stored in repository
→ external outline extractor
→ SVG curve archive
→ flattened point-list records
→ BOSL2 region validation and rendering
```

The portable route is independent of the operating system's font list.

## Batch 005 boundary

Portable capture is isolated in:

```text
glyph_sets/
tools/extract_glyph_set.py
tools/verify_glyph_set.py
lib/portable_glyph_*.scad
geometry/portable_glyph_*.scad
portable_main.scad
workbenches/portable_*.scad
```

The existing exact-height and sectioning pipeline is unchanged. A later
batch may replace its live-font source adapter with verified captured
regions after this proof is accepted.

## BOSL2 boundary

The repository references `BOSL2/std.scad` from the user's OpenSCAD
library path. Generated glyph records are ordinary OpenSCAD arrays;
BOSL2 validates and renders them as regions.
