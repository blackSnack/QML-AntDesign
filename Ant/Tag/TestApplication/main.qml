import QtQuick 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntTag 1.0
import AntIcon 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Row {
        AntTag {
            text: "Tag 1"
        }

        AntTag {
            text: "Tage 2"
            closeIcon: true

            onClose: {
                console.log("on close")
            }
        }

        AntTag {
            text: "Tage 2"
            closeIcon: Component {
                AntIcon {
                    source: "CloseCircleOutlined"
                    color: AntTheme.colorTextDescription
                }
            }
        }
    }

    Row {
        y: 30
        Repeater {
            model: Object.keys(AntColors.presetPrimaryColors)

            AntTag {
                required property string modelData
                text: modelData
                color: modelData 
            }
        }
    }

    Row {
        y: 60
        Repeater {
            model: ["#f50", "#2db7f5", "#87d068", "#108ee9"]

            AntTag {
                required property string modelData
                text: modelData
                color: modelData 
            }
        }
    }

    Row {
        y: 90
        AntTag {
            text: "Twitter"
            color: "#55acee" 
            icon: "TwitterOutlined"
        }

        AntTag {
            text: "Youtube"
            color: "#cd201f" 
            icon: "YoutubeOutlined"
        }

        AntTag {
            text: "Facebook"
            color: "#3b5999" 
            icon: "FacebookOutlined"
        }

        AntTag {
            text: "LinkedIn"
            color: "#55acee" 
            icon: "LinkedinOutlined"
        }
    }

    Row {
        y: 120
        AntTag {
            text: "Twitter"
            color: "#55acee" 
            icon: ({
               source: "TwitterOutlined",
               spin: true
            })
        }

        AntTag {
            text: "Youtube"
            color: "#cd201f" 
            icon: "YoutubeOutlined"
        }

        AntTag {
            text: "Facebook"
            color: "#3b5999" 
            icon: "FacebookOutlined"
        }

        AntTag {
            text: "LinkedIn"
            color: "#55acee" 
            icon: "LinkedinOutlined"
        }
    }

    Row {
        y: 150
        AntTag {
            text: "success"
            color: "success" 
            icon: ({
               source: "CheckCircleOutlined"
            })
        }

        AntTag {
            text: "processing"
            color: "processing" 
            icon: ({
               source: "SyncOutlined",
               spin: true
            })
        }

        AntTag {
            text: "error"
            color: "error" 
            icon: ({
               source: "CloseCircleOutlined"
            })
        }

        AntTag {
            text: "warning"
            color: "warning" 
            icon: "ExclamationCircleOutlined"
        }

        AntTag {
            text: "waiting"
            color: "default" 
            icon: "ClockCircleOutlined"
        }

        AntTag {
            text: "stop"
            color: "default" 
            icon: "MinusCircleOutlined"
        }
    }
}