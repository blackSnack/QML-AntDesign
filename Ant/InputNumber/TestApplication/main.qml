import QtQuick 2.15

import AntCore 1.0
import AntInputNumber 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        spacing: 16
        AntInputNumber {
            width: 200
            precision: 1
            step: 0.1
            max: 10
        }

        AntInputNumber {
            width: 200
            precision: 2
            max: 10
            step: 1
        }

        AntInputNumber {
            width: 200
            precision: 4
            step: 0.1
            formatter: (value)=>{
                           return `${Number(value).toLocaleString(Qt.locale(), 'f', precision)}%`
                       }
            parser: (text)=> {return Number.parseFloat(text)}
        }

        AntInputNumber {
            width: 200
            precision: 3
            antStyle {
                size: Ant.Small
            }
        }

        AntInputNumber {
            width: 200
            precision: 0
            antStyle {
                size: Ant.Large
            }
        }

        AntInputNumber {
            width: 200
            precision: 0
            enabled: false
        }
    }
}
