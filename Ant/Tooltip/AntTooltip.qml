import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: root

    property alias title: content.text
    clip: false
    z: 1000
    implicitWidth : implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    horizontalPadding: 16
    verticalPadding: 16

    contentItem: Text {
        id: content
        verticalAlignment: Text.AlignVCenter
    }

    background:  Canvas {
        clip: false
        id: background
        onPaint: {
            var ctx = getContext("2d");
//            ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
//            ctx.fillRect(0, 0, width, height);
            ctx.fillStyle = Qt.rgba(0, 1, 0, 1);
            ctx.fillRect(-20, -20, 20, 20);
        }
    }

}

