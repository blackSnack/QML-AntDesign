import QtQuick 2.15
import QtQuick.Window 2.15

import AntMenu 1.0
import AntCore 1.0
import "qrc:/AntCore/Utils/Utils.js" as AntCoreUtils

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    function getItem(key, label, icon, children, type = "SubMenu") {
        return AntCoreUtils.getItem(key, label, icon, children, type)
    }

    AntMenu {
        width: parent.width
        height: parent.height
        model: [
            getItem("Key_1", "Bus", "MailOutlined", [
                        getItem("Key_1_B1", "B1", "", [],"Item"),
                        getItem("Key_1_B2", "B2", "", [
                                    getItem("Key_1_B5", "B5", "", undefined, "Item"),
                                    getItem("Key_1_B6", "B6", "", undefined, "Item"),
                                    getItem("Key_1_B61", "B61", "", [
                                                getItem("Key_1_B61_1", "B61_1", "", undefined, "Item"),
                                                getItem("Key_1_B61_2", "B61_2", "", undefined, "Item"),
                                            ], "SubMenu"),
                                ],"SubMenu"),
                        getItem("Key_1_B3", "B3", "", [],"Item"),
                        getItem("Key_1_B4", "B4", "", [],"SubMenu"),
                    ], "Group"),
            getItem("Key_2", "Bus_2", "MailOutlined", [
                        getItem("Key_2_B1", "A1", "", [],"Item"),
                        getItem("Key_2_B2", "A2", "", [
                                    getItem("Key_2_B5", "A5", "", undefined, "Item"),
                                    getItem("Key_2_B6", "A6", "", undefined, "Item")
                                ],"SubMenu"),
                        getItem("Key_2_B3", "A3", "", [],"Item"),
                        getItem("Key_2_B4", "A4", "", [],"SubMenu"),
                    ]),
        ]

        onClick: (item, key, path) => {
                    console.log("click ", item, key, path)
                 }
    }

    // AntMenuList {
    //     x: 280

    //     model: 10
    //     type: Qt.Vertical
    //     delegate: Rectangle {
    //         width: 200
    //         height: 40
    //         color: "pink"
    //         border.width: 1
    //         border.color: "red"
    //     }
    // }
}
