# Generic portable sectioning

## Scope

Batch 010 applies rectangular sectioning to every stored portable
profile:

```text
6 font sets × 66 glyphs = 396 selectable profiles
```

## Workbenches

```text
workbenches/portable_section_plan.scad
workbenches/portable_section_layout.scad
workbenches/portable_section_export.scad
```

Each workbench selects:

```text
portable_set_id_selected
portable_glyph_id_selected
portable_target_height
portable_extrusion_depth
```

## Automatic grid

In `auto` mode:

```text
columns = ceil(normalized visible width / cell width)
rows    = ceil(target visible height / cell height)
origin X = -(columns × cell width) / 2
origin Y = 0
```

The resulting plan is centered on the normalized glyph and covers its
visible bounds.

Automatic mode does not move cuts based on glyph anatomy. It only
resolves the smallest complete rectangular grid for the configured cell
dimensions.

## Manual grid

In `manual` mode the operator supplies:

```text
origin X
origin Y
columns
rows
```

Manual plans may intentionally crop a glyph. Coverage is reported but
not required.

## Manifest

Every configured cell receives:

```text
section ID
set-and-glyph object ID
zero-based column and row
normalized global bounds
local export bounds
```

Example:

```text
FIRA_SANS_REGULAR_R1__L_g__C3_R2
```

## Local export

The selected cell is intersected with the exact-height normalized glyph,
then translated so the cell lower-left corner becomes local `[0, 0]`.

## Occupancy boundary

Batch 010 does not determine whether a cell is occupied. Every configured
cell appears in the manifest. An empty intersection renders no geometry.

Occupied-cell detection is the next project priority.
