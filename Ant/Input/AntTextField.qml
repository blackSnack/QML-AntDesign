import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0
import "./Component"
import "qrc:/AntCore/Utils/Utils.js" as CoreUtil

FocusScope {
    id: root

    property var antStyle: ({})
    property var addonAfter: undefined
    property var addonBefore: undefined
    property var prefix: undefined
    property var suffix: undefined
    property real leftPadding: CoreUtil.tryFetchValue(antStyle.leftPadding, 0)
    property real rightPadding: CoreUtil.tryFetchValue(antStyle.rightPadding, 0)
    property real topPadding: CoreUtil.tryFetchValue(antStyle.topPadding, 0)
    property real bottomPadding: CoreUtil.tryFetchValue(antStyle.bottomPadding, 0)
    readonly property bool hovered: mouseArea.containsMouse
    readonly property alias content: textField
    readonly property bool __isShowTextFieldBg: (addonBeforeLoader.visible || addonAfterLoader.visible)
    readonly property alias mouseArea: mouseArea
    readonly property alias background: background
    readonly property alias suffixLoader: suffixLoader

    focus: true

    AntRectangle { 
        id: background
        anchors.fill: parent
        
        border.color: __isShowTextFieldBg ? AntTheme.colorBorder : antStyle.borderColor(root)
        border.width: AntTheme.lineWidth
        color: root.hovered ? antStyle.hoverBg : antStyle.activeBg
        border.radius: CoreUtil.tryFetchValue(antStyle.radius, 0)

        AntRectangle {
            visible: __isShowTextFieldBg

            x: addonBeforeContent.visible ? outerLayout.x : innerContent.x
            y: 0
            width: (addonBeforeLoader.visible && addonAfterLoader.visible) ? outerLayout.width :
                                                                            addonBeforeLoader.visible ? innerContent.mapToItem(outerLayout, 0).x + innerContent.width :
                                                                                                        addonAfterLoader.visible ?  root.width - addonAfterContent.width
                                                                                                                                : 0
            height: parent.height
            border.color: antStyle.borderColor(root)
            border.width: AntTheme.lineWidth
            border.topLeftRadius: addonBeforeLoader.visible ? 0 : antStyle.radius
            border.bottomLeftRadius: addonBeforeLoader.visible ? 0 :  antStyle.radius
            border.topRightRadius: addonAfterLoader.visible ? 0 : antStyle.radius
            border.bottomRightRadius: addonAfterLoader.visible ? 0 : antStyle.radius
            color: "transparent"
        }

        Row {
            id: outerLayout
            anchors.fill: parent
            spacing: 0

            AntRectangle {
                id: addonBeforeContent
                width: addonBeforeLoader.visible ? addonBeforeLoader.width + root.leftPadding + root.rightPadding : 0
                height: addonBeforeLoader.height
                border.topLeftRadius: antStyle.radius
                border.bottomLeftRadius:  antStyle.radius

                Loader {
                    id: addonBeforeLoader
                    height: parent.height
                    visible: sourceComponent !== undefined && width > 0
                    sourceComponent: {
                        if (root.suffix instanceof Component) {
                            return root.addonBefore
                        }
                        if (typeof root.addonBefore === "object") {
                            return addonBeforeIconComp;
                        }
                        if (typeof root.addonBefore  === "string") {
                            return addonBeforeTextComp
                        }
                        return undefined
                    }
                }
            }

            Item {
                id: innerContent
                height: root.height
                width: outerLayout.width -
                    addonBeforeContent.width -
                    addonAfterContent.width

                Row {
                    id: innerLayout
                    spacing: 4
                    anchors {
                        fill: parent
                        leftMargin: root.leftPadding
                        rightMargin: root.rightPadding
                        topMargin: root.topPadding
                        bottomMargin: root.bottomPadding
                    }

                    Loader {
                        id: prefixLoader
                        height: parent.height
                        sourceComponent: {
                            if (typeof root.prefix === "object") {
                                return prefixIconComp;
                            }
                            if (typeof root.prefix  === "string") {
                                return prefixTextComp
                            }
                            return undefined
                        }
                    }

                    T.TextField {
                        id: textField
                        width: innerLayout.width - (prefixLoader.width + suffixLoader.width)
                            - (prefixLoader.visible > 0 ? innerLayout.spacing : 0)
                            - (suffixLoader.visible > 0 ? innerLayout.spacing : 0)
                        height: parent.height
                        color: antStyle.textColor
                        Text {
                            id: placeholder
                            anchors.fill: parent
                            text: textField.placeholderText
                            font: textField.font
                            color: AntTheme.colorTextPlaceholder
                            visible: !textField.length && !textField.preeditText
                            elide: Text.ElideRight
                            renderType: textField.renderType
                            verticalAlignment: textField.verticalAlignment
                        }
                        font: AntTheme.defaultFont
                        background: Item { }
                    }

                    Loader {
                        id: suffixLoader
                        height: parent.height
                        sourceComponent: {
                            if (root.suffix instanceof Component) {
                                return root.suffix
                            }
                            if (typeof root.suffix === "object") {
                                return suffixIconComp;
                            }
                            if (typeof root.suffix  === "string") {
                                return suffixTextComp
                            }
                            return undefined
                        }
                    }
                }
            }

            AntRectangle {
                id: addonAfterContent
                width: addonAfterLoader.visible ? addonAfterLoader.width + root.leftPadding + root.rightPadding : 0
                height: addonAfterLoader.height
                border.topRightRadius: antStyle.radius
                border.bottomRightRadius: antStyle.radius
                border.color: "transparent"
                border.width: 0
                color: antStyle.addonBg

                Loader {
                    id: addonAfterLoader
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: root.height
                    visible: sourceComponent !== undefined && width > 0
                    sourceComponent: {
                        if (root.addonAfter instanceof Component) {
                            return root.addonAfter
                        }
                        if (typeof root.addonAfter === "object") {
                            return addonAfterIconComp;
                        }
                        if (typeof root.addonAfter  === "string") {
                            return addonAfterTextComp
                        }
                        return undefined
                    }
                }
            }
        }

        Component {
            id: addonBeforeTextComp

            TextComponent {
                input: root
                text: root.addonBefore
                font: antStyle.addonBeforeFont === undefined ? textField.font : antStyle.addonBeforeFont
                color: antStyle.addonBeforeColor ?? textField.color
            }
        }

        Component {
            id: addonBeforeIconComp

            IconComponent {
                input: root
                source: root.addonBefore.icon ?? ""
            }
        }

        Component {
            id: addonAfterTextComp

            TextComponent {
                input: root
                text: root.addonAfter
                font: antStyle.addonAfterFont === undefined ? textField.font : antStyle.addonAfterFont
                color: antStyle.addonAfterColor ?? textField.color
            }
        }

        Component {
            id: addonAfterIconComp

            IconComponent {
                input: root
                source: root.addonAfter.icon ?? ""
            }
        }

        Component {
            id: prefixTextComp

            TextComponent {
                input: root
                text: root.prefix
                font: antStyle.prefixFont === undefined ? textField.font : antStyle.prefixFont
                color: CoreUtil.tryFetchValue(antStyle.prefixColor, textField.color)
            }
        }

        Component {
            id: prefixIconComp

            IconComponent {
                input: root
                source: root.prefix.icon ?? ""
            }
        }

        Component {
            id: suffixTextComp

            TextComponent {
                input: root
                text: root.suffix
                font: antStyle.suffixFont === undefined ? textField.font : antStyle.suffixFont
                color: antStyle.suffixColor ?? textField.color                
            }
        }

        Component {
            id: suffixIconComp

            IconComponent {
                input: root
                source: root.suffix.icon ?? ""
                color: antStyle.suffixColor ?? textField.color
                secondaryColor: antStyle.suffixColorSecondaryColor ?? "#D9D9D9"
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            propagateComposedEvents: true

            hoverEnabled: true

            onPressed: (event)=> event.accepted = false
        }
    }
}
