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
validation
   ↓
reporting
   ↓
font source adapter
   ↓
diagnostic rendering and manual observation
```

## Record layers

The project now maintains four distinct records:

1. **Project records** identify the laboratory or accepted-object
   catalog.
2. **Glyph dossiers** describe source-independent character anatomy.
3. **Font sources** preserve stable identities and provenance fields.
4. **Glyph observations** bind one source identity to one glyph dossier.

## Stable source identity

`SRC_1`, `SRC_2`, and `SRC_3` are stable laboratory IDs. The installed
font name may change without changing the registry architecture.

A source record stores the font name, license, URL, revision, and
status. Empty font names intentionally invoke OpenSCAD's default font.

## Observation boundary

OpenSCAD `text()` produces geometry but does not return outline metrics.
Batch 002 therefore separates rendering from observation:

```text
source + glyph dossier
        ↓
rendered profile
        ↓
manual guides and entered values
        ↓
observation candidate
        ↓
later registry acceptance
```

Pending ledger records contain no invented measurements.

## Source adapter boundary

`geometry/glyph_profile.scad` remains the central font adapter. New
geometry modules consume source records rather than directly selecting
fonts.

Later source kinds may provide procedural segment characters, stencil
geometry, SVG or polygon profiles, and custom project-native glyphs.

## Sectioning remains absent

No module in Batch 002 creates section boundaries, connectors, spacing,
or mounting geometry.
