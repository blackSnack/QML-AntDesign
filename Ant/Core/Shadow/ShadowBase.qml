import QtQuick 2.15

import AntQtCompat.GraphicalEffects 1.0

QtObject {
    id: root

    required property Item target
    property bool visible: true

    readonly property CompatDropShadow shadow1: CompatDropShadow {
        id: s1
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
    readonly property CompatDropShadow shadow2: CompatDropShadow {
        id: s2
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
    readonly property CompatDropShadow shadow3: CompatDropShadow {
        id: s3
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
        visible: root.visible
    }
}
