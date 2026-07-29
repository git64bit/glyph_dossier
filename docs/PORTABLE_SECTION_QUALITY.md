# Portable section quality

## Scope

Batch 012 adds a screening layer over the exact clipped occupancy
records from Batch 011.

It reports conditions that may deserve review. It does not move grid
lines, reject sections, or alter exported geometry.

## Workbench

```text
workbenches/portable_section_quality.scad
```

Views:

```text
plan
review_layout
report
```

## Component metrics

Each occupied cell reports:

```text
component count
component areas
component bounds
smallest component area
minimum component bounding-box extent
minimum effective thickness estimate
```

The thickness estimate is:

```text
component area / maximum component bounding-box span
```

It is a scale-bearing screening measurement, not a mathematical minimum
wall thickness.

## Shared seam metrics

A seam is counted only when the neighboring cell is also occupied.

Each section reports shared contact length and boundary-segment count
for:

```text
left
right
bottom
top
```

Opposite sides of neighboring records are validated for equal length.

A short seam is flagged only when a positive shared seam exists and is
below the configured threshold. A section with no neighbor seam is not
automatically flagged as short.

## Counter-cut candidate

Multiple shared boundary intervals on one internal seam can occur when
a cut crosses a counter or another separated contour arrangement.

This is reported as:

```text
counter_cut_candidate
```

It is explicitly a candidate, not a definitive semantic classification.

## Vertex proximity

The minimum distance from captured normalized source vertices to
internal cut lines is reported. The calculation uses the stored
flattened contour points, not clipping-generated vertices.

## Review flags

```text
multiple_components
small_component_area
thin_component_estimate
short_shared_seam
vertex_near_cut
counter_cut_candidate
bed_overflow
```

An occupied record with one or more flags receives `review`. An occupied
record with no flags receives `clear`. Empty records remain `empty`.

## Thresholds

Thresholds are exposed in the workbench and stored in the console
report. They are operator controls, not hidden acceptance standards.

## Boundary

Batch 012 performs no automatic cut relocation. That capability remains
outside the accepted project state.
