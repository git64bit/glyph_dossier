# Portable uppercase-A sectioning

## Authority

Batch 006 uses:

```text
portable set: LIBERATION_SANS_REGULAR_R1
glyph record: U_A
geometry: captured BOSL2 region
```

The portable route does not call `text()` and does not resolve a font
through the operating system.

## Exact normalization

Captured `U_A` region bounds:

```text
left = 4
bottom = 0
right = 1362
top = 1409
```

The source width is 1358 font units and the source height is 1409 font
units.

For a requested assembled height:

```text
scale = target height / 1409
normalized width = 1358 × scale
```

The normalized anchor is:

```text
horizontal center = X 0
profile bottom = Y 0
```

No `resize()`, `textmetrics()`, manual observation, or live font is
required.

## Authoritative workbenches

```text
portable_a_normalized_profile.scad
portable_a_section_plan.scad
portable_a_section_layout.scad
portable_a_section_export.scad
```

## Section coordinates

The default 600 mm profile uses:

```text
grid origin = [-300, 0]
cell = [200, 200]
grid = [3, 3]
```

The selected section is intersected with the normalized portable glyph,
then translated so the cell lower-left corner becomes local `[0, 0]`.

## Manifest

Every cell receives a deterministic one-based ID:

```text
C1_R1 through C3_R3
```

The manifest reports global grid bounds and local export bounds.

## Occupancy

Batch 006 does not compute occupied cells. BOSL2 region data makes that
possible as a later bounded step, but this batch preserves the existing
plain rectangular clipping behavior.

## Comparison route

The live `text()` workbenches remain in the repository for comparison.
They are not the source authority for portable section exports.
