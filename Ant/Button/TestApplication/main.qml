import QtQuick 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntIcon 1.0
import AntButton 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property int itemSize: 3
    Flickable {
        anchors.fill: parent
        contentHeight: 9999
        contentWidth: parent.width
        Rectangle {
            anchors.fill: parent
            color: "#EDEDED"

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 50
                Row {
                    spacing: 20
                    Text {
                        id: fa
                        readonly property int faType: AntFA.FA_water
                        readonly property var faObj: AntFAUtils.getFAObject(faType)
                        width: 50
                        height: 50
                        font.family: faObj.fontFamily
                        font.pixelSize: Math.max(fa.width,fa.height);
                        font.weight: faObj.weight
                        text: faObj.text
                        horizontalAlignment: Text.AlignHCenter;
                        verticalAlignment:   Text.AlignVCenter;
                        color: "blue"
                    }

                    AntIcon {
                        width: 32
                        height: 32
                        source: AntFA.FA_water
                        color: "red"
                        rotate: 30
                    }

                    AntIcon {
                        source: AntFA.FA_spinner
                        color: "gray"
                        spin: true
                    }

                    AntIcon {
                        source: "LoadingOutlined"
                        color: "gray"
                        spin: true
                    }

                    AntIcon {
                        color: AntColors.blue_5
                        secondaryColor: AntColors.blue_7
                        source: "FileMarkdownTwoTone"
                    }

                    AntIcon {
                        color: AntColors.blue_5
                        secondaryColor: AntColors.blue_7
                        source: "HighlightOutlined"
                    }

                    AntIcon {
                        color: AntColors.blue_5
                        secondaryColor: AntColors.blue_7
                        source: "AudioFilled"
                    }
                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                iconOnly: true
                                iconSource: "DownloadOutlined"
                                sizeType: index % 3
                                type: 0
                                text: `Button_${index}`
                                loading: true
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                                loading: true
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }
                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 0
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }

                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index % 3
                                type: 0
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }
                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 0
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }
                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 0
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }
                }

                Row {
                    spacing: 20
                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 0
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 1
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 2
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 3
                                text: `Button_${index}`
                            }
                        }
                    }

                    Column {
                        spacing: 20
                        Repeater {
                            model: itemSize
                            AntButton {
                                required property int index
                                danger: true
                                ghost: true
                                shape: AntButtonStyle.Shape.Round
                                sizeType: index
                                type: 4
                                text: `Button_${index}`
                            }
                        }
                    }
                }

            }
        }
    }
}
