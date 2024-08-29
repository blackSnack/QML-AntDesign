
pragma Singleton

import QtQuick 2.15
import AntCore 1.0

QtObject {
    readonly property var presetsColors: (new Map(
        [
            ["red",     {borderColor: AntColors.palettes.red_3, bgColor: AntColors.palettes.red_1, textColor: AntColors.red.primary}],
            ["volcano", {borderColor: AntColors.palettes.volcano_3, bgColor: AntColors.palettes.volcano_1, textColor: AntColors.volcano.primary}],
            ["gold",    {borderColor: AntColors.palettes.gold_3, bgColor: AntColors.palettes.gold_1, textColor: AntColors.gold.primary}],
            ["orange",  {borderColor: AntColors.palettes.orange_3, bgColor: AntColors.palettes.orange_1, textColor: AntColors.orange.primary}],
            ["yellow",  {borderColor: AntColors.palettes.yellow_3, bgColor: AntColors.palettes.yellow_1, textColor: AntColors.yellow.primary}],
            ["lime",    {borderColor: AntColors.palettes.lime_3, bgColor: AntColors.palettes.lime_1, textColor: AntColors.lime.primary}],
            ["green",   {borderColor: AntColors.palettes.green_3, bgColor: AntColors.palettes.green_1, textColor: AntColors.green.primary}],
            ["cyan",    {borderColor: AntColors.palettes.cyan_3, bgColor: AntColors.palettes.cyan_1, textColor: AntColors.cyan.primary}],
            ["blue",    {borderColor: AntColors.palettes.blue_3, bgColor: AntColors.palettes.blue_1, textColor: AntColors.blue.primary}],
            ["geekblue",{borderColor: AntColors.palettes.geekblue_3, bgColor: AntColors.palettes.geekblue_1, textColor: AntColors.geekblue.primary}],
            ["purple",  {borderColor: AntColors.palettes.purple_3, bgColor: AntColors.palettes.purple_1, textColor: AntColors.purple.primary}],
            ["magenta", {borderColor: AntColors.palettes.magenta_3, bgColor: AntColors.palettes.magenta_1, textColor: AntColors.magenta.primary}],
        ]
    ))

    function get(color) {
        if (presetsColors.has(color)) {
            return presetsColors.get(color)
        }
        return {borderColor: color, bgColor: color, textColor: AntTheme.colorTextLightSolid }
    }
}
