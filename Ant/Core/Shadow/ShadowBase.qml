import QtQuick 2.15
import Qt5Compat.GraphicalEffects

QtObject {
    id: root

    required property Item target
    property bool visible: true

    readonly property DropShadow shadow1: DropShadow {
        id: s1
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
    readonly property DropShadow shadow2: DropShadow {
        id: s2
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
    readonly property DropShadow shadow3: DropShadow {
        id: s3
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
}
