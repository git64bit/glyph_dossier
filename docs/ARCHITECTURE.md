# Architecture

Glyph Dossier follows the shared self-contained OpenSCAD framework.

```text
workbench
   ↓
config/defaults.scad
   ↓
project registry + glyph registries
   ↓
exact lookup
   ↓
validation
   ↓
reporting
   ↓
source adapter
   ↓
diagnostic rendering
```

## Registry separation

The project maintains two distinct record types:

1. **Project records** identify the laboratory or accepted-object
   catalog.
2. **Glyph dossier records** describe character anatomy and design risk.

The character registry is split into uppercase, lowercase, digits, and
punctuation, then composed into `ALL_GLYPHS`.

## Source adapter boundary

`geometry/glyph_profile.scad` is the only Batch 001 font-rendering
adapter.

Later adapters may provide:

- procedural segment characters;
- stencil geometry;
- SVG or polygon profiles;
- custom project-native glyphs.

Analysis, validation, and future sectioning should operate on the common
glyph contract rather than directly on a font call.

## No automatic metric claim

Batch 001 does not depend on automatic font-outline measurement. The
guide frame is nominal and user-adjustable. Character records describe
expected anatomy and font variation; later source-specific observation
will record actual geometry.
