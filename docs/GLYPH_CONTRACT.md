# Glyph dossier contract

Each character dossier contains:

| Field | Meaning |
|---|---|
| ID | Stable exact lookup name |
| Glyph | One rendered character |
| Group | Uppercase, lowercase, digit, or punctuation |
| Archetype | Shared structural family |
| Components | Expected connected-component range |
| Counters | Expected enclosed-counter range |
| Vertical class | Cap, x-height, ascender, descender, or punctuation extent |
| Features | Anatomical elements that define the character |
| Risks | Regions likely to challenge later sectioning |
| Variants | Font-dependent forms that must be observed |
| Priority | Primary, secondary, or coverage study level |
| Note | Character-specific design purpose |

## Two-layer analysis

### Character-level dossier

This is the Batch 001 record. It describes what must be examined across
fonts.

### Source-specific observed dossier

This is deferred. It will bind a character to a particular font,
revision, license, source URL, rendered profile, and observed geometry.

The distinction prevents a generic statement such as “lowercase g” from
silently assuming either the one-storey or two-storey form.

## Sectioning boundary

Future sectioning may consume an observed normalized profile. It must
not infer section rules directly from the character name or raw
`text()` call.
