import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0
import "qrc:/AntCore/Utils/Utils.js" as Utils

T.CheckBox {
    id: root

    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding

    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: AntTheme.controlInteractiveSize
        height: AntTheme.controlInteractiveSize
        border.color: Utils.getControlColor(root, d.borderStyle)
        border.width: AntTheme.lineWidth
        radius: AntTheme.borderRadiusSM
        color: Utils.getControlColor(root, d.bgStyle)

        AntIcon {
            visible: root.checkState === Qt.Checked
            anchors.centerIn: parent
            width: 12
            height: 8
            source: "qrc:/AntCheckbox/icon/checked.svg"
        }

        Rectangle {
            visible: root.checkState === Qt.PartiallyChecked
            anchors.centerIn: parent
            width: AntTheme.controlInteractiveSize / 2
            height: AntTheme.controlInteractiveSize / 2
            color: AntTheme.colorPrimary
        }
    }

    contentItem: AntText {
        leftPadding: indicator.width + AntTheme.marginXS
        text: root.text
    }

    QtObject {
        id: d

        readonly property var borderStyle: new Utils.ControlColorStyle(AntTheme.colorBorder, AntTheme.colorBorder, AntTheme.colorPrimary, AntTheme.colorPrimary, AntTheme.colorPrimary, AntTheme.colorPrimary)
        readonly property var bgStyle: new Utils.ControlColorStyle(AntTheme.colorBgContainer, AntTheme.colorBgContainerDisabled, AntTheme.colorBgContainer, AntTheme.colorPrimary, AntTheme.colorBgContainer, AntTheme.colorBgContainer)
    }
}
