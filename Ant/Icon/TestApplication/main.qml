import QtQuick 2.15
import QtQuick.Window 2.15
import AntIcon 1.0

Window {
    width: 1280
    height: 768
    visible: true

    AntIcon {
        width: 100
        height: 100
        source: "LoadingOutlined"
        color: "gray"
        spin: true
    }
}
