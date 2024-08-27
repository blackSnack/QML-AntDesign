import QtQuick 2.15

import AntCore 1.0
import AntIconPrivate 1.0

Item {
    id: root

    enum IconType {
        FontIcon,
        ImageIcon, // svg & png
        AntSvgIcon
    }

    readonly property bool isValid: type !== -1
    property int type: {
        if (!source || source == "") {
            return -1
        }

        if (Number.isFinite(source)) {
            return AntIcon.IconType.FontIcon
        }

        if (source.indexOf(":") !== -1) {
            return AntIcon.IconType.ImageIcon
        }
        return AntIcon.IconType.AntSvgIcon
    }
    property var source: undefined
    property real rotate: 0
    property bool spin: false
    property color color: AntColors.gray_5
    property color secondaryColor: "#D9D9D9"
    property real sourceWidth: root.width
    property real sourceHeight: root.height


    implicitWidth: 16
    implicitHeight: 16
    rotation: root.rotate

    Loader {
        id: content
        anchors.centerIn: parent
        width: sourceWidth
        height: sourceHeight
        sourceComponent: {
            if (root.type === -1) {return undefined }
            return root.type === AntIcon.IconType.AntSvgIcon ? svgIconComp :
                                                               (root.type === AntIcon.IconType.ImageIcon ? imageIconComp : fontIconComp)
        }
    }

    Component {
        id: fontIconComp

        Text {
            anchors.fill: parent
            readonly property var faObj: AntFAUtils.getFAObject(root.source)
            font.family: faObj.fontFamily
            font.pixelSize: Math.max(width, height);
            font.weight: faObj.weight
            text: faObj.text
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            color: root.color
        }
    }

    Component {
        id: imageIconComp

        Image {
            anchors.fill: parent
            source: root.source
            fillMode: Image.PreserveAspectFit
        }
    }

    Component {
        id: svgIconComp

        AntSvgIcon {
            anchors.fill: parent
            source: root.source
            primaryColor: root.color
            secondaryColor: root.secondaryColor
        }
    }

    RotationAnimator {
        loops: Animation.Infinite
        target: root;
        from: 0;
        to: 360;
        duration: 1000
        running: spin
    }
}
