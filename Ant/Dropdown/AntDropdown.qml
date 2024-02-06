import QtQuick 2.15

import AntCore 1.0
import AntPopover 1.0
import AntMenu 1.0

AntPopover {
    id: popover

    property var menu: []

    target: root
    control.leftPadding: 0
    control.rightPadding: 0
    content: AntMenu {
        width: popover.control.width
        model: menu
    }
}


