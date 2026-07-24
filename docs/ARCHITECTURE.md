# Architecture

Glyph Dossier follows the shared self-contained OpenSCAD framework.

```text
workbench
   ↓
config/defaults.scad
   ↓
project + glyph + source + observation registries
   ↓
exact lookup
   ↓
validation and reporting
   ↓
font source adapter
   ↓
diagnostic or section rendering
```

## Record layers

The project maintains four record types:

1. project records;
2. generic glyph dossiers;
3. font-source records;
4. source-specific glyph observations.

## Batch 003 sectioning boundary

The first sectioning experiment is intentionally separate from the
character and source registries.

```text
uppercase-A dossier
+ exact font source
+ explicit rectangular grid
        ↓
whole-profile intersection per grid cell
        ↓
plan, exploded layout, or one local export
```

`lib/sectioning.scad` contains only pure grid mathematics.

`geometry/section_grid.scad` creates clipping cells and preview lines.

`geometry/a_hazard_map.scad` contains nominal, adjustable A-specific
analysis guides.

`geometry/section_scene.scad` creates plan, layout, and export views.

## No geometry introspection claim

OpenSCAD does not report whether a clipping cell contains glyph
geometry. The layout loops over every configured cell. Empty
intersections render nothing.

The section inventory is therefore deterministic by grid index, but
occupied-cell detection remains deferred.

## No connector layer

The clipped faces remain plain. Batch 003 introduces no connector,
spacing, mounting, or attachment abstraction.
