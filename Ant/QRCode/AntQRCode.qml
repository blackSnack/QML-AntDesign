import QtQuick 2.15
import QtQuick.Controls 2.15

import AntQRCode 1.0
import AntButton 1.0
import AntIcon 1.0
import AntCore 1.0
import AntSpin 1.0
import AntMask 1.0
import AntText 1.0

Control {
    id: root

    property color color: AntTheme.colorText
    property color bgColor: AntTheme.colorBgContainer
    property int size: 160
    property int iconSize: size / 4
    property string icon: ""
    property string value: ""
    property string errorLevel: "L" // [L, M, Q, H]
    property bool bordered: true
    property int radius: AntTheme.borderRadius

    signal onRefresh()

    implicitWidth: size
    implicitHeight: size
    padding: AntTheme.paddingSM
    state: {
        if (qrcodegen.loading) {
            return "loading"
        }
        if (qrcodegen.error) {
            return "expired"
        }
        return "actived"
    } // [actived | loading | expired]

    background: Rectangle {
        color: bgColor
        radius: root.radius
        border {
            width: bordered ? 1 : 0
            color: AntTheme.colorSplit
        }
    }

    contentItem: Item {
        width: root.implicitWidth - leftPadding - rightPadding
        height: root.implicitHeight - topPadding - bottomPadding
        AntSvgIcon {
            id: qrcode
            anchors.centerIn: parent
            // Keep aspect ratio
            width: Math.min(parent.width, parent.height)
            height: width
            primaryColor: root.color
            secondaryColor: bgColor
            sourceData: qrcodegen.qrCode

            AntIcon {
                width: iconSize
                height: iconSize
                source: root.icon
                anchors.centerIn: parent
            }
        }
    }

    AntQRCodeGen {
        id: qrcodegen
        data: root.value
        ecc: d.errorLevel[errorLevel] ? d.errorLevel[errorLevel] : AntQRCodeGen.EccLow
    }

    AntSpin {
        spinning: root.state === "loading"
    }

    AntMask {
        visible: root.state === "expired"

        Column {
            anchors.centerIn: parent
            AntText {
                text: qsTr("QR code expired")
            }

            AntButton {
                iconSource: "ReloadOutlined"
                text: qsTr("Refresh")
                type: AntButtonStyle.Type.Link

                onClicked: {
                    onRefresh()
                }
            }
        }
    }


    QtObject {
        id: d

        readonly property var errorLevel: ({
                                               L: AntQRCodeGen.EccLow,
                                               M: AntQRCodeGen.EccMedium,
                                               Q: AntQRCodeGen.EccQuartile,
                                               H: AntQRCodeGen.EccHigh,
                                           })
    }
}


