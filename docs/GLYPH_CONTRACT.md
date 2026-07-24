# Glyph and observation contracts

## Generic glyph dossier

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

## Font source

A source record contains:

| Field | Meaning |
|---|---|
| Source ID | Stable laboratory identity |
| Kind | `font` in Batch 002 |
| Label | Human-readable source label |
| Font name | Installed family and style; empty means default |
| License | Recorded license label |
| URL | Source location |
| Revision | File hash, package revision, or release |
| Status | Active or disabled |

## Source-specific observation

An observation contains:

| Field | Meaning |
|---|---|
| Observation ID | Stable exact record name |
| Source ID | Exact source identity |
| Glyph ID | Exact generic dossier identity |
| Status | Pending, observed, or verified |
| Variant | Source-specific character form |
| Components | Actual connected-component count |
| Counters | Actual enclosed-counter count |
| Extents | Left, right, bottom, and top coordinates |
| Minimum stroke | Manually observed narrowest solid feature |
| Minimum gap | Manually observed narrowest open separation |
| Note | Source-specific observation record |

`OBS_UNKNOWN` marks a value that has not been observed. Pending records
may contain unknown values. Observed and verified records must contain a
complete, internally valid measurement set.

## Sectioning boundary

Future sectioning may consume a verified source-specific observation and
a normalized profile. It must not infer source geometry from the
character name alone.
