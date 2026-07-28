# Architecture

## Portable source layer

Each font family is an isolated package containing namespaced generated
records. All packages implement the same 66 dossier IDs.

## Multi-family catalog layer

```text
portable_set_id_selected
        ↓
exact portable font-set lookup
        ↓
selected set glyph array
        ↓
portable_glyph_id_selected
        ↓
exact glyph lookup
        ↓
BOSL2 region rendering
```

`portable_catalog_main.scad` includes the six set manifests and registry.
The older `portable_main.scad` remains the single-family laboratory and A
sectioning orchestrator.

## Collision control

Set manifests use namespaced constants. Record-level IDs remain generic so
shared dossier code can operate on any selected family.

## Stability

Every new package has a 66-glyph JSON lock. Extraction is staged and only
installed after an existing lock passes. Package checksums cover all stored
files except the checksum list itself.

## Deferred

Family-selectable sectioning, occupied-cell analysis, cut relocation,
connectors, and accepted physical objects remain outside Batch 008.
