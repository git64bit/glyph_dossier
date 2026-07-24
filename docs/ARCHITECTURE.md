# Architecture

Glyph Dossier separates source capture from runtime geometry.

## Complete portable pipeline

```text
retained TTF + license + provenance
        ↓
transactional external extractor
        ↓
immutable representative lock
        ↓
66 captured contour records
        ↓
BOSL2 regions
        ↓
catalog, normalization, and later sectioning
```

## Package authority

The source package is:

```text
glyph_sets/liberation_sans_regular/
```

`manifest.scad` is the OpenSCAD registry authority. It exposes complete,
category, and representative ID arrays plus the 66 glyph records.

`set.json` is the machine-readable extraction record.

`checksums.sha256` protects every file in the package except itself.

## Stability contract

The original 20 records define revision `R1`. The extractor writes to a
temporary staging directory, validates the lock, and only then replaces
the generated package.

This prevents a library update, platform change, extractor edit, or
curve-flattening change from silently replacing previously accepted
portable geometry.

## Runtime catalog

`portable_main.scad` routes contact sheets through generated category ID
arrays. `portable_catalog.scad` selects any exact portable ID.

## Sectioning boundary

Batch 007 does not generalize sectioning. Portable `U_A` remains the only
authoritative sectional glyph. The next batch may generalize exact-bound
normalization to every captured glyph without yet making sectioning
generic.
