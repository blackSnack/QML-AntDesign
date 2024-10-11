import QtQuick 2.15

import AntCore 1.0
import AntInput 1.0
import AntDropdown 1.0

import AntTag 1.0

import "./Style"
import "qrc:/AntCore/Utils/Utils.js" as CoreUtils

Item {
    id: root

    // {label, value}[]
    property alias options: selectModel.values
    // Current selected option (considered as a immutable array)
    property var value

    // Sets the current select model
    // Default "". Support `multiple` | `tags`
    property string model: "" 

    property AntSelectStyle antStyle: AntSelectStyle {}
    property var selectModel: AntListModel { id: selectModel }

    // function(value, option:Option | Array<Option>)
    signal change(var value, var option)
    // function(value: string | number | LabeledValue, option: Option)
    signal select(var value, var option)

    QtObject {
        id: d
        readonly property bool isMultiple: model === "multiple" || model === "tags" 
    }

    width: 200
    height: input.height

    AntDropdown {
        id: dropdown
        target: mouseArea
        trigger: Ant.Click
        arrow: false
        placement: Ant.LeftBottom
        control.width: root.width

        menu.wapper: ({
            items: selectModel,
            multiple: d.isMultiple,
            antStyle: ({
                itemSelectedBg: root.antStyle.optionSelectedBg, 
                itemSelectedColor: root.antStyle.optionSelectedColor,
            })
        })

        Connections {
            enabled: dropdown.menu.target
            target: dropdown.menu.target

            function onSelect(item, key, keyPath, selectedItems) {
                root.select(key, {label: item.model.label, value: item.model.key})
                root.change(key, {label: item.model.label, value: item.model.key})
                // TODO: Update to array values
                dropdown.close()
            }
        }
    }

    AntInput {
        id: input
        height: d.isMultiple ? flowLayout.height : __styleProxy.controlHeight
        implicitWidth: parent.width
        
        readOnly: true

        antStyle {
            size: root.antStyle.size
            textColor: dropdown.visible ? AntTheme.colorTextDisabled : AntTheme.colorText
            suffixColor: AntTheme.colorTextPlaceholder
        }
        // custom input content background style.
        // hover - follow input style
        // otherwise follow search input status
        contentItem.wapper: ({
            background:({
                border: ({
                    color: Qt.binding(()=>{
                        if (!d.isMultiple) {
                          return contentItem.target.__isShowTextFieldBg ? AntTheme.colorBorder : contentItem.target.antStyle.borderColor(contentItem.target)
                        }
                        if (contentItem.target.hovered) {
                            return contentItem.target.antStyle.borderColor(contentItem.target)
                        }
                        return contentItem.target.antStyle.borderColor(searchInput)
                    })
                })
            })
        })
        suffix: ({icon: "DownOutlined"})
        text: {
            // Display empty when model is multiple
            if (d.isMultiple) return ""

            let selectedItems = dropdown.menu.target ? dropdown.menu.target.selectedItems : null
            if (selectedItems) {
                return selectedItems.length > 0 ? selectedItems[0].text : ""
            }
            return "";
        }

        Row {
            id: flowLayout
            readonly property Item inputContent: input.contentItem.target ?? null

            visible: d.isMultiple
            width: parent ? parent.width : 0
            padding: 3
            Flow {
                readonly property Item inputContent: flowLayout.inputContent
                width: parent.width - (inputContent ? (inputContent.rightPadding * 2) + inputContent.suffixLoader.width : 0)
                clip: true
                spacing: 2
                Repeater {
                    model: d.isMultiple ? dropdown.menu.target.selectedItems : 0

                    AntTag {
                        required property int index
                        readonly property Item menuItem: dropdown.menu.target ? dropdown.menu.target.selectedItems[index] : null
                        closeIcon: true
                        text: menuItem ? menuItem.text : ""
                        antStyle {
                            height: input.__styleProxy.controlHeight
                        }

                        onClose: {
                            menuItem.menu.selectItem(menuItem)
                        }
                    }
                }

                TextInput {
                    id: searchInput
                    height: input.__styleProxy.controlHeight
                    width: Math.max(2, contentWidth)
                    verticalAlignment: TextInput.AlignVCenter
                    focus: input.focus
                    onFocusChanged: {
                        // keep focus
                        if (d.isMultiple && dropdown.visible && !focus) {
                            forceActiveFocus()
                        }
                    }

                    onWidthChanged: {
                        var  inputContent = input.contentItem.target ?? null
                    }
                }
            } 
        }
    }

    MouseArea {
        id: mouseArea
        
        anchors.fill: root
        
        // parent: input.mouseLayer
        propagateComposedEvents: true

        onPressed: (mouse)=>{
            dropdown.visible ? dropdown.close() : dropdown.open()
            input.forceActiveFocus()
            mouse.accepted = false
        }
    }

    onValueChanged: {
        let typeStr = typeof value
        if (typeStr === "number") {
            dropdown.currentSelectedKey = Qt.binding(()=> [options[value]["value"]]) 
        } else if (typeStr === "string") {
            dropdown.currentSelectedKey = [value]
        } else if (typeStr === "object") {
            dropdown.currentSelectedKey = [value.value]
        }
    }
}
