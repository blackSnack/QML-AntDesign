import QtQuick 2.15

import AntQtCompat.GraphicalEffects 1.0

Rectangle {
    id: root

    property real squareSize: 4

    layer.enabled: true
    layer.effect: CompatOpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: root.radius
        }
    }
    Canvas {
        id: canvas
        anchors.fill: parent
        z: -1

        onPaint: {
            var ctx = getContext("2d");

            // 绘制棋盘格
            // 遍历所有行列，并绘制格子
            for (let i = 0; i < height / squareSize; i++) {
                for (let j = 0; j < width / squareSize; j++) {
                    if ((i + j) % 2 === 1) {
                        ctx.fillStyle = AntColors.gray_1;;
                    } else {
                        ctx.fillStyle = AntColors.gray_4;;
                    }

                    // 计算当前格子左上角的 x、y 坐标
                    var startX = j * squareSize;
                    var startY = i * squareSize;

                    // 绘制正方形格子
                    ctx.fillRect(startX, startY, squareSize, squareSize);
                }
            }
        }
    }
}
