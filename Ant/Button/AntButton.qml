import QtQuick 2.15
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Ant 1.0
import Ant.Core 1.0
import Ant.Button.Style 1.0
import Ant.Button.Utils 1.0


Button
{
    id: root

    property int sizeType: AntButton.SizeType.Default
    property int type: AntButtonStyle.Type.Default

    property ButtonStyle style: {
        switch (type) {
        case AntButtonStyle.Type.Primary:
            return AntButtonStyle.primaryStyle
        case AntButtonStyle.Type.Dashed:
            return AntButtonStyle.dashedStyle
        case AntButtonStyle.Type.Default:
        default:
            return AntButtonStyle.defaultStyle
        }
    }

    QtObject {
        id: self
        readonly property ButtonSizeStyle sizeStyle: Utils.fetchTargetStyle(sizeType, root.style)
    }


    implicitWidth:  self.sizeStyle.compSize.width
    implicitHeight: self.sizeStyle.compSize.height

    background: AntRectangle {
        id: bg
        anchors.fill: parent
        border.width: self.sizeStyle.borderStyle.width
        border.color: Utils.bindStyleStateColor(root, self.sizeStyle.borderStyle)
        border.style: self.sizeStyle.borderStyle.lineStyle
        border.radius: self.sizeStyle.borderStyle.radius
        color: Utils.bindStyleStateColor(root, self.sizeStyle.bgStyle)

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 2
            radius: 0
            color: Qt.rgba(0, 0,0, 0.02)
        }
    }

    contentItem: Text {
        horizontalAlignment: Text.Center
        verticalAlignment: Text.AlignVCenter
        text: root.text
        color: Utils.bindStyleStateColor(root, self.sizeStyle.fontStyle)
    }
}
