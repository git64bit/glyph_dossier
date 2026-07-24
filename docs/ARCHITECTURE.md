# Architecture

Glyph Dossier follows the shared self-contained OpenSCAD framework.

```text
workbench
   ↓
configuration
   ↓
project + glyph + source + observation registries
   ↓
exact lookup
   ↓
validation and reporting
   ↓
font source adapter
   ↓
normalization
   ↓
diagnostic or sectional rendering
```

## Record layers

The project maintains:

1. project records;
2. generic glyph dossiers;
3. font-source records;
4. source-specific glyph observations.

## Batch 004 normalization boundary

The uppercase-A sectioning pipeline is now:

```text
uppercase-A dossier
+ exact font source
+ normalization method
+ target assembled height
        ↓
center-bottom exact-height profile
        ↓
explicit rectangular grid
        ↓
plan, layout, or selected-cell export
```

Normalization is isolated in:

```text
lib/normalization.scad
geometry/normalized_glyph.scad
geometry/normalized_profile_scene.scad
```

Section clipping remains isolated in:

```text
lib/sectioning.scad
geometry/section_grid.scad
geometry/section_scene.scad
```

## Normalization methods

### resize

The default portable route. `resize()` evaluates the actual rendered
profile and sets its Y dimension to the target height while scaling X
proportionally.

### manual

Uses explicit left, right, bottom, and top profile bounds from a known
probe size. This route provides reproducible numeric scale and width
reporting without development-snapshot functions.

### textmetrics

Uses `textmetrics()` when explicitly selected in a compatible
development snapshot. The function supplies source-profile position and
size for exact translation, scale, and width reporting.

## Font inventory boundary

The complete machine-specific font list belongs to OpenSCAD's
**Help > Font List** interface.

The repository reports its configured source list and may optionally
call `fontmetrics()` to show which family and style OpenSCAD resolved.
It does not claim to enumerate every installed system font.

## No occupied-cell claim

The section manifest lists every configured cell deterministically.
OpenSCAD does not report whether an intersection is empty. Empty cells
render no geometry.

## No connector layer

Cut faces remain plain. Connectors, spacing, mounting, and attachment
methods remain absent.
