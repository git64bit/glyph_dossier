# Architecture

Glyph Dossier separates source capture, normalization, and sectioning.

## Portable source layer

```text
embedded source package
        ↓
exact set ID + glyph ID lookup
        ↓
captured BOSL2 region
```

## Generic normalization layer

```text
captured region bounds
        ↓
exact target-height scale
        ↓
visible-center-bottom normalized region
```

## Generic sectioning layer

Batch 010 adds:

```text
normalized portable region
        ↓
automatic or manual rectangular grid
        ↓
full section manifest
        ↓
plan, exploded layout, or local cell export
```

Implementation:

```text
config/portable_generic_section_defaults.scad
lib/portable_generic_sectioning.scad
lib/portable_generic_section_validation.scad
lib/portable_generic_section_reporting.scad
geometry/portable_generic_section_scene.scad
portable_section_main.scad
```

Automatic mode derives the smallest complete centered-bottom grid from
normalized visible bounds and configured cell dimensions.

Manual mode preserves direct operator control.

## Fixed A sectioning layer

The earlier `portable_a_*` route remains byte-identical and separate.
Its A-specific hazard guides are not used by generic sectioning.

## Next boundary

BOSL2 occupied-cell detection should classify each resolved grid cell
without changing the accepted clipping and local-coordinate contract.
