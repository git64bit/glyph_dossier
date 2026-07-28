# Multi-family portable catalog

## Identity

A glyph is no longer identified by `U_A` alone. The exact catalog key is:

```text
set ID + glyph ID
```

The set registry stores metadata and one isolated 66-record glyph array per
family. Identical glyph IDs are valid across families because lookup enters
one set before searching its glyph array.

## Stored families

```text
Liberation Sans Regular — neutral sans baseline
Montserrat Regular — geometric sans
Alpha Slab One Regular — heavy slab display
Fira Sans Regular — humanist sans
Miama Nueva Medium — script stress case
Playfair Display Regular — display serif
```

## Namespacing

Generated constants use package prefixes such as:

```text
MSR1_PG_U_A
ASOR1_PG_U_A
FSR1_PG_U_A
MNMR1_PG_U_A
PDR1_PG_U_A
```

This prevents OpenSCAD variable collisions while retaining the shared
record-level ID `U_A`.

## Source authority

Every new package records the expected source filename and exact SHA-256.
The binary is supplied externally when regeneration is required. The
portable package itself consists of captured contour data, license,
provenance, diagnostic SVG, manifest, checksums, and an immutable lock.

## Sectioning boundary

Batch 008 does not make A sectioning family-selectable. The established
portable A experiment remains bound to Liberation Sans Regular R1. Generic
multi-family normalization and sectioning remain later work.
