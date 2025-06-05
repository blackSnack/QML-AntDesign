import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import AntSpace 1.0
import AntButton 1.0
import AntCore 1.0
import AntSlider 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ButtonGroup {
        id: spacingBtnGroup
    }
    Column {
        spacing: 24

        Row {

            Repeater {

                model: ["start", "end", "center", "baseline"]
                AntButton {
                    text: modelData
                    onClicked: {
                        layout.align = text
                        hlayout.align = text
                    }
                }
            }
        }

        Column {
            Row {
                Repeater {
                    model: ["small", "middle", "large", "custom"]
                    AntButton {
                        text: modelData
                        ButtonGroup.group: spacingBtnGroup
                        checkable: true
                        onCheckedChanged: {
                            if (modelData == "custom") {
                                customSlider.visible = checked
                            } else {
                                if (checked) {
                                    layout.size = modelData
                                    hlayout.size = modelData
                                }
                            }
                        }
                    }
                }
            }

            AntSlider {
                id: customSlider
                visible:false
                width: parent.width

                onValueChanged: {
                    layout.size = value
                    hlayout.size = value
                }
            }
        }

        Rectangle {
            width: childrenRect.width
            height: childrenRect.height

            border.color: AntColors.blue.primary
            AntSpace {
                id: layout
                objectName: "RootSpace"
                AntSpace {
                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Large
                    }

                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Small
                    }

                    AntButton {

                    }
                }

                AntSpace {
                    align: "end"
                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Large
                    }

                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Small
                    }

                    AntButton {

                    }
                }

                AntSpace {
                    objectName: "center"
                    align: "center"
                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Large
                    }

                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Small
                    }

                    AntButton {

                    }
                }

                AntSpace {
                    objectName: "center"
                    align: "baseline"
                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Large
                    }

                    AntButton {
                        sizeType: AntButtonStyle.SizeType.Small
                    }

                    AntButton {

                    }
                }

                Rectangle {
                    height: 100
                    width: 1
                    color: "green"
                }
            }
        }

        Rectangle {
            width: childrenRect.width
            height: childrenRect.height

            border.color: AntColors.blue.primary
            AntSpace {
                id: hlayout
                direction: Qt.Vertical
                AntButton {
                    sizeType: AntButtonStyle.SizeType.Large
                }

                AntButton {
                    sizeType: AntButtonStyle.SizeType.Small
                }

                AntButton {

                }

                Rectangle {
                    height: 1
                    width: 100
                    color: "green"
                }
            }
        }
    }
}
