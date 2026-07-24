# Font inventory

## Complete machine list

OpenSCAD exposes the complete machine-specific font list at:

```text
Help > Font List
```

The pane provides the logical family, style, and font-file location.
Use the exact family and style string in a source record.

## Console inventory

`workbenches/font_inventory.scad` reports:

```text
OPENSCAD_VERSION
OPENSCAD_VERSION_NUM
OPENSCAD_COMPLETE_FONT_LIST_UI
OPENSCAD_BUNDLED_PORTABLE_FONTS
CONFIGURED_FONT_SOURCE_IDS
CONFIGURED_FONT_STRINGS
```

It then reports the complete provenance fields for `SRC_1`, `SRC_2`,
and `SRC_3`.

## Optional runtime resolution

Set:

```text
runtime_fontmetrics_enabled = true
```

only in a development snapshot that implements `fontmetrics()`.

The console will then show OpenSCAD's resolved family and style for each
configured source. This is useful because font matching may substitute a
different installed font when the requested name is unavailable.

## Portable included families

OpenSCAD includes:

```text
Liberation Mono
Liberation Sans
Liberation Serif
```

These names are reported as the portable bundled set. They are not a
complete list of fonts installed on the machine.
