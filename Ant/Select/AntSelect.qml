import QtQuick 2.15

import AntCore 1.0
import AntInput 1.0
import AntDropdown 1.0

import "./Style"
import "qrc:/AntCore/Utils/Utils.js" as CoreUtils

Item {
    id: root

    // {label, value}[]
    property alias options: selectModel.values
    // Current selected option (considered as a immutable array)
    property var value
    property AntSelectStyle antStyle: AntSelectStyle {}
    property var selectModel: AntListModel { id: selectModel }

    // function(value, option:Option | Array<Option>)
    signal change(var value, var option)
    // function(value: string | number | LabeledValue, option: Option)
    signal select(var value, var option)


    width: input.width
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
        width: 200
        readOnly: true
        text: {
            let selectedItems = dropdown.menu.target ? dropdown.menu.target.selectedItems : null
            if (selectedItems) {
                return selectedItems.length > 0 ? selectedItems[0].text : ""
            }
            return "";
        }

        antStyle {
            size: root.antStyle.size
            textColor: dropdown.visible ? AntTheme.colorTextDisabled : AntTheme.colorText
            suffixColor: AntTheme.colorTextPlaceholder
        }

        suffix: ({icon: "DownOutlined"})
    }
    
    MouseArea {
        id: mouseArea
        
        anchors.fill: root
        
        parent: input.mouseLayer
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
