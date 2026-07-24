//////////////////////////////////////////////////////////////////////
// LibFile: portable_component_color_contract.scad
// Project: Glyph Dossier
// FileGroup: Contract Tests
// FileSummary: Numeric component colors without Boolean arithmetic.
//////////////////////////////////////////////////////////////////////

include <../geometry/portable_glyph_scenes.scad>

assert(portable_component_color(0) == [0.25, 0.80, 0.25]);
assert(portable_component_color(1) == [0.25, 0.25, 0.80]);
assert(portable_component_color(2) == [0.80, 0.25, 0.25]);
assert(portable_component_color(3) == [0.25, 0.80, 0.25]);

for (index = [0 : 8])
    for (channel = portable_component_color(index))
        assert(
            is_num(channel),
            str(
                "Component color channel is not numeric at index ",
                index
            )
        );

echo("PASS", "portable_component_color_contract");
