import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import AntColorPicker 1.0
import Qt5Compat.GraphicalEffects
import AntText 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        x: 100
        y: 50
        Row {
            spacing: 10
            AntColorPicker {

                defaultValue: "#1677ff"
                antStyle {
                    size: Ant.Large
                }
            }

            AntColorPicker {

                defaultValue: "#36CFC9"
                antStyle {
                    size: Ant.Middle
                }
            }

            AntColorPicker {

                defaultValue: "#389E0D"
                antStyle {
                    size: Ant.Small
                }
            }
        }

        Row {
            spacing: 10
            AntColorPicker {

                defaultValue: "#1677ff"
                antStyle {
                    size: Ant.Large
                }
                showText: true
            }

            AntColorPicker {

                defaultValue: "#36CFC9"
                defaultFormat: "hex"
                antStyle {
                    size: Ant.Middle
                }
                showText: true
            }

            AntColorPicker {
                defaultValue: "#389E0D"
                defaultFormat: "hsv"
                antStyle {
                    size: Ant.Small
                }
                showText: true
            }
        }

        Row {
            spacing: 10
            AntColorPicker {

                defaultValue: "#1677ff"
                antStyle {
                    size: Ant.Large
                }
                showText: Component {
                    AntText {
                        text: "Custom text"
                    }
                }
            }

            AntColorPicker {

                defaultValue: "#36CFC9"
                defaultFormat: "hex"
                antStyle {
                    size: Ant.Middle
                }
                showText: true
            }

            AntColorPicker {
                defaultValue: "#389E0D"
                defaultFormat: "hsv"
                antStyle {
                    size: Ant.Small
                }
                showText: true
            }
        }
    }
}
