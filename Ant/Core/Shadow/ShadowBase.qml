import QtQuick 2.15
import Qt5Compat.GraphicalEffects

QtObject {
    required property Item target

    readonly property DropShadow shadow1: DropShadow {
        id: s1
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
    }
    readonly property DropShadow shadow2: DropShadow {
        id: s2
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
    }
    readonly property DropShadow shadow3: DropShadow {
        id: s3
        parent: target.parent
        width: target.width
        height: target.height
        source: target
        z: -1070
    }
}
