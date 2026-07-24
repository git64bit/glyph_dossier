# Extractor workflow

## Inputs

```text
source/LiberationSans-Regular.ttf
tools/full_character_set.json
representative_lock.json
```

The source font is read directly with fontTools. It does not need to be
installed.

## Transactional extraction

The extractor performs these steps:

1. Read all 66 requested Unicode code points from the TTF.
2. Preserve the original SVG path commands.
3. Flatten curves at the recorded tolerance.
4. Normalize contour winding for BOSL2 regions.
5. Generate SCAD and SVG files in a temporary staging directory.
6. Compare all original 20 records against the immutable lock.
7. Stop without replacing the installed package if any lock fails.
8. Replace generated files only after the lock passes.
9. Rebuild the complete manifest, metadata, contact sheets, and
   checksums.

## Command

```text
python tools/extract_glyph_set.py   --font glyph_sets/liberation_sans_regular/source/LiberationSans-Regular.ttf   --spec tools/full_character_set.json   --out glyph_sets/liberation_sans_regular   --lock glyph_sets/liberation_sans_regular/representative_lock.json
```

## Verification

```text
python tools/verify_glyph_set.py   glyph_sets/liberation_sans_regular
```

Verification checks:

```text
66 glyph identities
26/26/10/4 group counts
20 locked representative records
source checksum
all generated checksums
all category contact sheets
manifest category arrays
```
