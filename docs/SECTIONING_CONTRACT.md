# Sectioning contract — Batch 003

## Scope

The contract applies only to uppercase `A`.

The sectioner accepts:

```text
source identity
nominal font size
extrusion depth
grid origin X and Y
cell width and height
column and row count
selected column and row
clipping epsilon
```

## Coordinates

The font profile remains in its source coordinate system:

- horizontal alignment is centered at `X = 0`;
- the text baseline is `Y = 0`;
- grid origin is the lower-left corner of cell `C1_R1`;
- columns increase toward positive X;
- rows increase toward positive Y.

Indexes in the workbench are zero based.

Human-facing section IDs are one based:

```text
column 0, row 0 → C1_R1
column 2, row 2 → C3_R3
```

## Export behavior

The selected cell is intersected with the complete extruded glyph.

The resulting section is translated so that the cell's lower-left
corner becomes local coordinate `[0, 0]`.

The output therefore remains within:

```text
0 ≤ X ≤ cell width
0 ≤ Y ≤ cell height
0 ≤ Z ≤ extrusion depth
```

An empty selected cell produces no geometry.

## Printer-bed contract

Cell width must not exceed configured bed width.

Cell height must not exceed configured bed height.

The default 200 × 200 mm cell fits the configured 220 × 220 mm bed.

## Plain interfaces

Section boundaries are exact clipping planes. There is no gap, overlap,
kerf compensation, connector, or attachment assumption.

The small epsilon extends only the clipping solid in Z to avoid
coplanar preview ambiguity. It does not alter the XY section boundary.
