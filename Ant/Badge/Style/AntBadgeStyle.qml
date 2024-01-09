pragma Singleton

import QtQuick 2.15

import AntCore 1.0

QtObject {
    enum Status {
        Success,
        Processing,
        Default,
        Error,
        Warning
    }

    readonly property var colors: ({
                                        pink: AntColors.magenta_6,
                                        red: AntColors.red_5,
                                        yeallow: AntColors.yellow_6,
                                        orange: AntColors.orange_6,
                                        cyan: AntColors.cyan_6,
                                        green: AntColors.green_6,
                                        blue: AntColors.blue_6,
                                        purple: AntColors.purple_6,
                                        geekblue: AntColors.geekblue_6,
                                        magenta: AntColors.magenta_6,
                                        volcano: AntColors.volcano_6,
                                        gold: AntColors.gold_6,
                                        lime: AntColors.lime_6
                                  })
    readonly property var statusColors: [
        AntTheme.colorSuccess,
        AntTheme.colorPrimary,
        AntTheme.colorTextPlaceholder,
        AntTheme.colorError,
        AntTheme.colorWarning,
    ]
}
