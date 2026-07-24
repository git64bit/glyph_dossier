# Font provenance

No font files are included in this repository.

Batch 002 introduces three configurable source records:

```text
SRC_1
SRC_2
SRC_3
```

For each source, record:

```text
installed family and style
license
source URL
revision, package version, or file hash
```

Leaving a font name empty uses OpenSCAD's default font. That is useful
for exploratory rendering but is not reproducible enough for later
object acceptance unless the actual resolved font is identified.

## Source identity versus font name

The source ID is stable. The font name is metadata attached to that ID.
This permits observation records to refer to an exact source slot while
the laboratory configuration is being established.

Before an observation is promoted beyond pending status, the source
metadata should identify the actual font used.

## Later physical provenance

A future accepted source-specific glyph object must preserve:

```text
font source ID
font family and style
license
source URL
source revision or file hash
glyph dossier ID
observation ID
project revision
geometry-affecting values
```

License text and source identification may later be rendered into the
rear face of a large physical glyph. That geometry remains deferred.
