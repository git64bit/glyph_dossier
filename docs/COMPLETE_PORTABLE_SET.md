# Complete portable character set

## Identity

```text
Set ID: LIBERATION_SANS_REGULAR_R1
Family: Liberation Sans
Style: Regular
Version: 2.1.5
License: SIL Open Font License 1.1
Flattening tolerance: 2 font units
```

## Coverage

The package contains one exact portable record for every generic dossier:

```text
U_A through U_Z
L_a through L_z
D_0 through D_9
P_question
P_exclamation
P_colon
P_semicolon
```

The manifest exposes:

```text
PORTABLE_UPPERCASE_IDS
PORTABLE_LOWERCASE_IDS
PORTABLE_DIGIT_IDS
PORTABLE_PUNCTUATION_IDS
PORTABLE_REPRESENTATIVE_IDS
PORTABLE_ALL_IDS
PORTABLE_GLYPHS
```

## Stability boundary

The first 20 records are an accepted extraction baseline. Batch 007 does
not reinterpret or regenerate them silently.

The JSON lock verifies file hashes and metadata during extraction. The
SCAD lock verifies the same metadata inside OpenSCAD.

Changes to the source font, flattening tolerance, curve-flattening
implementation, winding rules, collinear-point removal, numeric
formatting, or generated-record format will normally change a locked
artifact and stop extraction.

A deliberate future migration must create a new set revision rather than
silently replacing `LIBERATION_SANS_REGULAR_R1`.

## Contact sheets

Generated SVG sheets:

```text
contact_sheet.svg
contact_sheets/uppercase.svg
contact_sheets/lowercase.svg
contact_sheets/digits.svg
contact_sheets/punctuation.svg
contact_sheets/representative.svg
```

OpenSCAD workbenches use the generated ID arrays and BOSL2 records rather
than importing the SVG files.
