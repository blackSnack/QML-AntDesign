import QtQuick 2.15

import AntCore 1.0

Rectangle {
    id: root

    anchors.fill: parent
    radius: root.parent.radius ?? 0
    color: AntColors.gray_4_A88
}
