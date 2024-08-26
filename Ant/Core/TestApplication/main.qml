import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import AntCore 1.0

Window {
    width: 1280
    height: 768
    visible: true

    SwipeView {
        id: view
        anchors.fill: parent
        Repeater {
            model: [shader, lightColors,darkColors]
            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                sourceComponent: modelData
            }
        }
    }

    component ColorRect: Rectangle {
        property bool isDark: false
        width: 200
        height: 42
        radius: 3

        Text {
            text: modelData
            color: isDark ? (index > 4 ? "black" : "white") : (index > 4 ? "white" : "black")
            anchors {

                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Component {
        id: lightColors

        Flickable {
            contentHeight: content.height
            Flow {
                id: content
                width: view.width
                // anchors.fill: parent
                Repeater {
                    model: Object.values(AntColors.presetPalettes)
                    Column {
                        required property var modelData
                        Repeater {
                            model: modelData

                            ColorRect {
                                required property var modelData
                                required property int index
                                color: modelData
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: darkColors

        Flickable {
            contentHeight: content.height
            Flow {
                id: content
                width: view.width
                // anchors.fill: parent
                Repeater {
                    model: Object.values(AntColors.presetDarkPalettes)
                    Column {
                        required property var modelData
                        Repeater {
                            model: modelData

                            ColorRect {
                                isDark: true
                                required property var modelData
                                required property int index
                                color: modelData
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: shader
        Shader {}
    }
}
