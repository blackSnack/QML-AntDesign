import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    required property Item target

    readonly property alias shadow1: s1
    readonly property alias shadow2: s2
    readonly property alias shadow3: s3

    parent: target.parent

    anchors.fill: target

    DropShadow {
        id: s1
        anchors.fill: parent
        source: target
    }

    DropShadow {
        id: s2
        anchors.fill: parent
        source: target
    }
    DropShadow {
        id: s3
        anchors.fill: parent
        source: target
    }
}
