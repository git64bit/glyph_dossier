# Segmented source adapter

## Scope

Batch 013 adds a project-authored procedural source path. It is separate
from the six imported font packages and does not change their registry.

Registered segmented source sets:

```text
PROCEDURAL_14_SEGMENT_EXTENDED_R1
PROCEDURAL_7_SEGMENT_EXTENDED_R1
```

## Three mapping states

Each source set contains all 66 dossier identities. Every identity has
exactly one state:

```text
visible
intentional_blank
unsupported
```

These states are not interchangeable.

`visible` has one or more active segment elements and can be adapted to
the portable-glyph record.

`intentional_blank` is a defined source state with no active geometry.

`unsupported` means the source adapter does not define that identity.

## Fourteen-segment extended set

The extended template contains the conventional fourteen display
elements plus two punctuation dots and one comma element.

All 66 dossier identities are visible procedural masks.

## Seven-segment extended set

The template contains seven conventional elements plus two punctuation
dots and one comma element.

Status distribution:

```text
13 visible
1 intentional blank
52 unsupported
```

Visible records are the ten digits plus question mark, colon, and
semicolon. Exclamation is the intentional blank proof state. Letters are
explicitly unsupported.

## Portable adapter

A visible mapping becomes the existing fifteen-field portable-glyph
record:

```text
segmented source set
        ↓
active element IDs
        ↓
immutable disjoint BOSL2 region
        ↓
actual active-region bounds
        ↓
portable-glyph record
```

The adapted record uses the procedural design fingerprint as its source
identity.

Because the adapter produces the accepted portable record, it can enter:

```text
exact-height normalization
automatic grid sectioning
BOSL2 occupied-cell detection
```

Blank and unsupported mappings cannot enter those geometry stages.

## Workbenches

```text
workbenches/segmented_catalog.scad
workbenches/segmented_pipeline.scad
workbenches/segmented_contact_sheet.scad
```

`segmented_catalog.scad` can display all three states.

`segmented_pipeline.scad` uses visible mappings for the portable
normalization, sectioning, and occupancy path.

When a blank or unsupported mapping is selected in a pipeline view, the
workbench reports `SEGMENTED_PIPELINE_AVAILABLE = false` and renders the
source-state frame. It does not call the portable adapter and does not
terminate compilation.

## Source packages

Canonical project-authored JSON and immutable SCAD manifests are stored
under:

```text
segment_sets/procedural_14_segment_extended/
segment_sets/procedural_7_segment_extended/
```

Each canonical design has its own SHA-256 fingerprint.

## Boundary

Batch 013 does not import DSEG, LCD, DotMatrix, or other external font
families. Those packages remain the next collection priority.
