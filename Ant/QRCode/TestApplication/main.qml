import QtQuick 2.15
import QtQuick.Window 2.15

import AntQRCode 1.0
import AntCore 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        Column {
            Row {
                spacing: 50
                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    state: "loading"
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    state: "expired"
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                }
            }

            Row {
                spacing: 50
                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    // state: "loading"
                    icon: "CheckCircleFilled"
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    state: "expired"
                    icon: "CheckCircleFilled"
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    icon: "CheckCircleFilled"
                }
            }

            Row {
                spacing: 50
                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    color: AntColors.blue_6
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    color: AntColors.green_6
                }

                AntQRCode {
                    errorLevel: "H"
                    value: "https://www.baidu.com"
                    color: AntColors.magenta_6
                }
            }
        }
    }
}
