import QtQuick 2.15

import AntCore 1.0
import AntInput 1.0
import AntIcon 1.0

import "./Style"
import "./Utils/Utils.js" as Utils

AntInput {
    id: root

    property real step: 1.0
    property real value: 0.0
    property real min: Number.MIN_SAFE_INTEGER
    property real max: Number.MAX_SAFE_INTEGER
    // 数值精度，配置 formatter 时会以 formatter 为准
    property int precision: 0
    property var formatter: function(value) {
        return Number(value).toLocaleString(Qt.locale(), 'f', precision)
    }
    property var parser: function(text) {
        return Number.fromLocaleString(Qt.locale(), text)
    }

    // current value, info {offset: number, type: 'up' | 'down'}
    property var onStep: function (value, info) {}

    function decrease() {
        value -= step
        if (formatter) root.text = formatter(value)

        onStep(root.value, {offset: step, type: "down"})
    }

    function increase() {
        root.value += step
        if (formatter) root.text = formatter(value)
        onStep(root.value, {offset: step, type: "up"})
    }
    QtObject {
        id: d

        readonly property real value: parser(root.text)
        readonly property bool handleUpEnabled: {
            return root.enabled && max > d.value
        }
        readonly property bool handleDownEnabled: {
            return root.enabled && min < d.value
        }
        function updateDisplayText() {
            root.text = formatter ? formatter(root.value) : root.value
        }
    }

    antStyle: AntInputNumberStyle {}
    __styleProxy: new Utils.AntInputNumberStyleProxy(root, antStyle)
    text: formatter ? formatter(value) : value

    validator: DoubleValidator {
        bottom: min
        top: max
        decimals: precision
    }

    onActiveFocusChanged: {
        if(value === "") return
        if (!activeFocus) {
            if (!acceptableInput) {
                let v = parser(root.text)
                if (v < validator.bottom) {return value = validator.bottom}
                if (v > validator.top) return value = validator.top
            }
        }
    }

    onValueChanged: {
        d.updateDisplayText()
    }

    onTextChanged: {
        value = parser(text)
    }

    Item {
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: AntTheme.lineWidth
        }
        visible: __styleProxy.handleVisible
        width: __styleProxy.handleWidth
        Item {
            id: upHandleArea
            anchors.right: parent.right
            anchors.top: parent.top
            objectName: "Up"
            height: upHandle.containsMouse ? parent.height * 0.6 : downHandle.containsMouse ? parent.height * 0.4 :  parent.height * 0.5
            width: parent.width
            enabled: d.handleUpEnabled

            AntIcon {
                anchors.centerIn: parent
                width: __styleProxy.handleFontSize
                height: __styleProxy.handleFontSize
                source: "UpOutlined"
                color: upHandle.containsMouse ? __styleProxy.handleHoverColor : __styleProxy.handleColor
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.top: upHandleArea.bottom
            width: parent.width
            height: AntTheme.lineWidth
            color: __styleProxy.handleBorderColor
        }

        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: AntTheme.lineWidth
            height: parent.height
            color: __styleProxy.handleBorderColor
        }

        Item {
            id: downHandleArea
            objectName: "Down"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: downHandle.containsMouse ? parent.height * 0.6 : upHandle.containsMouse ? parent.height * 0.4 :  parent.height * 0.5
            width: parent.width
            enabled: d.handleDownEnabled

            AntIcon {
                anchors.centerIn: parent
                width: __styleProxy.handleFontSize
                height: __styleProxy.handleFontSize
                source: "DownOutlined"
                color: downHandle.containsMouse ? __styleProxy.handleHoverColor : __styleProxy.handleColor
            }
        }
    }

    HandleMouseArea {
        id: upHandle
        target: upHandleArea
        handler: increase
    }

    HandleMouseArea {
        id: downHandle
        target: downHandleArea
        handler: decrease
    }

    component HandleMouseArea: MouseArea {
        id: handleMouseArea
        required property Item target
        property point position: Qt.point(0, 0)
        property var handler: null

        x: position.x
        y: position.y
        parent: root.mouseLayer
        width: target.width
        height: target.height
        hoverEnabled: enabled
        enabled: target.enabled
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor

        function updatePosition() {
            position = target.mapToItem(root.mouseLayer, 0, 0)     
        }

        function trigger() {
            if (handler) {
                handler()
            }
        }

        onPressed: {
            if (!root.activedFocus) {
                root.forceActiveFocus()
            }
            trigger()
        }

        onPressAndHold: {
            timer.running = true
        }

        onReleased: {
            timer.running = false
        }

        onEnabledChanged: {
            if (!enabled) {
                timer.running = false
            }
        }

        Timer {
            id: timer

            interval: 90
            repeat: true
            onTriggered: parent.trigger()
        }

        Connections {
            target: handleMouseArea.target
            function onXChanged() {
                updatePosition()
            }

            function onYChanged() {
                updatePosition()
            }

            function onVisibleChanged() {
                if (handleMouseArea.target.visible) {
                    updatePosition()
                }
            }
        }
    }
}
