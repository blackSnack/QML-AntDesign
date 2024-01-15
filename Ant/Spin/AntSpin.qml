import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import AntMask 1.0

Popup {
    id: root

    property Component indicator: d.defaultIndicator
    property bool spinning: false
    property string size: "small" // [small | default | large]
    property int dotSize: 20
    property int dotSizeLG: 32
    property int dotSizeSM: 14
    property bool fullscreen: false
    property string tip: ""
    property int delay: 0

    parent: fullscreen ? Overlay.overlay : undefined
    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    padding: 0
    closePolicy: Popup.NoAutoClose
    visible: spinning
    z: AntTheme.zIndexPopupBase

    contentItem: Item {
        Column {
            spacing: AntTheme.marginXS
            anchors.centerIn: parent
            Loader {
                id: loader
                sourceComponent: indicator
            }

            Text {
                x: (loader.width - width) / 2
                visible: tip !== ""
                text: tip
                font: AntTheme.defaultFont
                color: AntTheme.colorPrimary
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    background: AntMask {
        radius: root.parent.radius ?? 0
    }

    RotationAnimator {
        loops: Animation.Infinite
        target: loader;
        from: 0;
        to: 360;
        duration: 1000
        running: spinning
    }

    Timer {
        id: delayTimer
        interval: delay
        repeat: false

        onTriggered: {
            root.visible = !root.visible
        }
    }

    onSpinningChanged: {
        if (delay > 0) {
            spinning ? delayTimer.start() : delayTimer.stop()
        }else {
            root.visible = spinning
        }
    }

    QtObject {
        id: d
        readonly property real cycleSize: d.contentSize / 2.5
        readonly property real cycleSpacing: cycleSize / 2
        readonly property int contentSize: {
            if (root.size === "small") {
                return root.dotSizeSM
            } else if (root.size === "default") {
                return root.dotSize
            }else if (root.size === "large") {
                return root.dotSizeLG
            }
            return root.dotSize
        }
        readonly property Component defaultIndicator: Component {
            Column {
                anchors.centerIn: parent
                spacing: d.cycleSpacing
                Row {
                    spacing: d.cycleSpacing
                    Rectangle {
                        width: d.cycleSize
                        height: d.cycleSize
                        color: AntTheme.colorPrimary
                        opacity: 0.5
                        radius: width/2
                    }

                    Rectangle {
                        width: d.cycleSize
                        height: d.cycleSize
                        color: AntTheme.colorPrimary
                        opacity: 0.3
                        radius: width/2
                    }
                }

                Row {
                    spacing: d.cycleSpacing
                    Rectangle {
                        width: d.cycleSize
                        height: d.cycleSize
                        color: AntTheme.colorPrimary
                        radius: width/2
                    }

                    Rectangle {
                        width: d.cycleSize
                        height: d.cycleSize
                        color: AntTheme.colorPrimary
                        opacity: 0.6
                        radius: width/2
                    }
                }
            }
        }
    }
}
