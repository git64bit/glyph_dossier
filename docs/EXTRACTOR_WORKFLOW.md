# Extractor workflow

## Input

```text
font TTF or OTF
representative_set.json
flattening tolerance
```

The font is opened by file path. It does not need to be installed.

## Output per glyph

```text
exact SVG path commands
flattened SCAD point-list region
curve-aware source bounds
flattened region bounds
advance width
component and counter counts
point count
source checksum
```

## Curve flattening

Quadratic and cubic curves are recursively subdivided until their control
points are within the configured tolerance of the endpoint chord.

Batch 005 uses:

```text
2 font units at 2048 units per em
```

The SVG retains the original curves. The SCAD region is the deterministic
polygonal derivative used by BOSL2.

## Reproducibility

`set.json` records the source checksum and all generated metrics.
`checksums.sha256` covers the font, license, provenance, SVGs, SCAD files,
manifest, and JSON metadata.

`tools/verify_glyph_set.py` checks the source hash, record count, file
presence, contour accounting, and every listed checksum.
