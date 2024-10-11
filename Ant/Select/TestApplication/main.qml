import QtQuick 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntSelect 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        spacing: 8

        AntSelect { 
            options:[
                {label: "jack", value: "jack"},
                {label: "lucy", value: "lucy"},
                {label: "Yiminghe", value: "Yiminghe"},
                {label: "disabled", value: "disabled", disabled: false},
            ]
            value: "jack"
            model: "tags"
        }

        AntSelect { 
            antStyle {
                size: Ant.Small
            }
            value: 1
            options:[
                {label: "jack", value: "jack"},
                {label: "lucy", value: "lucy"},
                {label: "Yiminghe", value: "Yiminghe"},
                {label: "disabled", value: "disabled", disabled: false},
            ]
        }

        AntSelect { 
            antStyle {
                size: Ant.Large
            }
            options:[
                {label: "jack", value: "jack"},
                {label: "lucy", value: "lucy"},
                {label: "Yiminghe", value: "Yiminghe"},
                {label: "disabled", value: "disabled", disabled: false},
            ]
            value: ({label: "Yiminghe", value: "Yiminghe"})
        }
    }
}