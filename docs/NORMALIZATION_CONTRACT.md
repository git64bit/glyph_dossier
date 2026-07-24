# Exact-height normalization contract

## Scope

Batch 004 normalizes uppercase `A` only.

## Required output

The normalized profile has:

```text
assembled height = target_assembled_height
bottom = Y 0
horizontal source anchor = X 0
extrusion depth = configured depth
```

The rectangular section grid is applied only after normalization.

## resize method

```text
normalization_method = "resize"
```

The source glyph is rendered center-bottom at the probe size, then
passed through:

```text
resize([0, target_height], auto=[true, false])
```

The actual rendered Y bounding dimension becomes the target height. X is
scaled proportionally.

This method does not expose the final numeric width to SCAD code.

## manual method

```text
normalization_method = "manual"
```

Required fields:

```text
manual_profile_left
manual_profile_right
manual_profile_bottom
manual_profile_top
normalization_probe_size
target_assembled_height
```

The scale is:

```text
target height / observed profile height
```

The final width is:

```text
observed profile width × scale
```

The source profile is translated so its observed horizontal center is
at X 0 and its observed bottom is at Y 0.

## textmetrics method

```text
normalization_method = "textmetrics"
```

This route requires an OpenSCAD development snapshot implementing
`textmetrics()`.

The returned `position` and `size` values establish the exact profile
bounds at the probe size. The route reports:

```text
textmetrics object
normalization scale
normalized width
normalized height
```

## Section manifest

Every grid cell has:

```text
C<column>_R<row>
zero-based index
global bounds
local print bounds
```

The manifest does not claim whether the cell contains geometry.
