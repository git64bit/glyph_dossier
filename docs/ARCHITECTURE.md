# Architecture

Glyph Dossier now has two source classes feeding one portable geometry
contract.

## Imported font source path

```text
retained font source
        ↓
extracted immutable contours
        ↓
portable-glyph record
```

## Procedural segmented source path

```text
segmented source set
        ↓
template element geometry
        ↓
per-identity active mask and state
        ↓
visible-mask adapter
        ↓
portable-glyph record
```

Blank and unsupported states stop before geometry adaptation.

## Shared downstream path

```text
portable-glyph record
        ↓
exact-height normalization
        ↓
rectangular sectioning
        ↓
occupied-cell detection
        ↓
quality screening
```

Batch 013 proves the segmented adapter through occupied-cell detection.
It does not add segmented sets to the imported font registry.

## Immutable procedural identity

Each segmented set has:

```text
canonical design JSON
immutable SCAD manifest
SHA-256 design fingerprint
exact template and mapping IDs
```

## Next boundary

External segmented and modular font packages can now be represented
without confusing blank states with missing glyphs.
