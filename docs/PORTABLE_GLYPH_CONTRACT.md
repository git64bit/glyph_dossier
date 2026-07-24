# Portable glyph contract

## Source authority

A portable glyph set retains:

```text
original font file
font license
source provenance
font SHA-256
extractor and extractor version
flattening tolerance
```

The original font is the authority from which the captured outlines can
be regenerated.

## Captured glyph record

Each generated SCAD record contains:

| Field | Meaning |
|---|---|
| ID | Stable Glyph Dossier identity |
| Character | One Unicode character |
| Codepoint | Unicode scalar value |
| Glyph name | Font-internal glyph name |
| Units per em | Font coordinate scale |
| Advance width | Original horizontal advance |
| Exact bounds | Curve-aware source bounds |
| Region bounds | Flattened point-list bounds |
| Contours | Total closed paths |
| Components | Independent solid components |
| Counters | Enclosed holes |
| Points | Flattened point count |
| Tolerance | Maximum flattening error target in font units |
| Source hash | Exact original font identity |
| Region | BOSL2-compatible list of closed paths |

## Coordinate contract

Captured contours remain in original font units with Y upward.

Outer contours are normalized to clockwise winding. Counter contours
are counter-clockwise. Disconnected components remain separate paths in
the same glyph coordinate system.

Runtime normalization converts the region to:

```text
horizontal center = X 0
profile bottom = Y 0
profile height = requested target height
```

## SVG role

Each diagnostic SVG preserves the exact curve commands produced from the
font. SVG files are retained for inspection and exchange.

OpenSCAD/BOSL2 analysis uses the generated point-list region because an
imported SVG becomes opaque geometry and cannot be recovered as path
data inside OpenSCAD.
