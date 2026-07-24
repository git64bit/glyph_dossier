# Font provenance

No font files are included in this repository.

The laboratory workbench accepts:

- installed font family and style name;
- license label;
- source URL;
- source revision or hash.

Leaving the font name empty uses OpenSCAD’s default font for exploratory
rendering. Such a result is not reproducible enough for catalog
promotion.

A future accepted source-specific glyph object must embed or reference:

```text
font family and style
license
source URL
source revision or file hash
glyph dossier ID
project revision
observed geometry record
```

License text and source identification may later be rendered into the
rear face of a large physical glyph. That geometry is outside Batch 001.
