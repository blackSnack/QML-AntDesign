import QtQuick 2.15

import AntInput 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        spacing: 32
        Row {
            spacing: 8
            Repeater {
                model: ["Default", "Error", "Warning", "Success"]

                Column {
                    spacing: 8
                    required property string modelData
                    Repeater {
                        model: ["small", "middle", "large"]
                        AntInput {
                            required property string modelData
                            width: 100

                            placeholder: `${parent.modelData}_${modelData}`
                            state: `${parent.modelData}`
                            antStyle {
                                size: `${modelData}`
                            }
                        }
                    }
                }
            }
        }

        Row {
            spacing: 8
            Repeater {
                model: ["Default", "Error", "Warning", "Success"]

                Column {
                    spacing: 8
                    required property string modelData
                    Repeater {
                        model: [{
                                type: "small",
                                prefix: ({icon: "ClockCircleOutlined"}),
                                suffix: ({icon: "UserOutlined"})
                            },
                            {type: "middle",
                                prefix: ({icon: "ClockCircleOutlined"}),
                                suffix: ({icon: "UserOutlined"})
                            },
                            {
                                type: "large",
                                prefix: ({icon: "ClockCircleOutlined"}),
                                suffix:  ""
                            }]
                        AntInput {
                            required property var modelData
                            width: 100

                            placeholder: `${modelData.type}`
                            state: `${parent.modelData}`
                            antStyle {
                                size: `${modelData.type}`
                            }
                            prefix: modelData.prefix
                            suffix: modelData.suffix
                        }
                    }
                }
            }
        }
    }
}
