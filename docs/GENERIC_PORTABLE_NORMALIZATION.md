# Generic portable normalization

## Scope

Batch 009 normalizes every stored portable glyph using captured region
bounds. The available matrix is:

```text
6 font sets × 66 glyph identities = 396 profiles
```

## Workbench

```text
workbenches/portable_normalized_profile.scad
```

Select:

```text
portable_set_id_selected
portable_glyph_id_selected
portable_target_height
portable_extrusion_depth
portable_show_normalized_bounds
```

## Geometry contract

Let the captured region bounds be:

```text
[left, bottom, right, top]
```

Then:

```text
source width  = right - left
source height = top - bottom
scale         = requested height / source height
```

Every source point is transformed by:

```text
X = (source X - source horizontal center) × scale
Y = (source Y - source bottom) × scale
```

Therefore:

```text
visible horizontal center = X 0
visible bottom            = Y 0
visible top               = requested height
visible width             = source width × scale
```

No live font operation participates in this route.

## Baseline relationship

Visible-bottom anchoring does not discard the source baseline.

The original font baseline is Y 0 in source units. Its normalized
position is:

```text
normalized baseline Y = -source bottom × scale
```

A descender produces a positive normalized baseline Y. A glyph whose
visible outline lies completely above the source baseline may produce
a negative normalized baseline Y.

The console reports this value together with normalized advance width.

## Disconnected components

Components and counters remain in their captured relative positions.
The complete BOSL2 region is translated and scaled as one immutable
profile.

## Boundaries

Batch 009 does not generalize sectioning. The existing portable
Liberation Sans `U_A` section experiment remains unchanged.
