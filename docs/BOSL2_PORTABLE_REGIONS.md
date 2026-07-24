# BOSL2 portable regions

Batch 005 uses the installed BOSL2 library through:

```scad
include <BOSL2/std.scad>
```

No BOSL2 files are vendored into Glyph Dossier.

## Operations used

```text
is_region(region)
is_valid_region(region)
region_parts(region)
region_area(region)
region(region)
```

`region_parts()` provides the connected-component count for characters
such as `i`, `j`, `?`, `!`, `:`, and `;`.

The extractor records counters separately from independent components.
For example:

```text
A  → 1 component, 1 counter
i  → 2 components, 0 counters
8  → 1 component, 2 counters
:  → 2 components, 0 counters
```

## Why the region is captured externally

OpenSCAD geometry does not expose its original outline data after
`text()` or `import()` creates geometry. The external extractor reads the
font file directly and emits the paths as OpenSCAD data before BOSL2 is
asked to analyze or render them.
