import QtQuick 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntAvatar 1.0
import AntSpace 1.0
import AntButton 1.0
import AntBadge 1.0
import AntTooltip 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    AntSpace {
        direction: Qt.Horizontal
        AntSpace {
            direction: Qt.Vertical

            AntSpace {
                align: "center"
                AntAvatar { size: 64; icon: "UserOutlined" }
                AntAvatar { size: "large"; icon: "UserOutlined" }
                AntAvatar { icon: "UserOutlined" }
                AntAvatar { size: "small"; icon: "UserOutlined" }
                AntAvatar { size: 14; icon: "UserOutlined" }
            }

            AntSpace {
                align: "center"

                AntAvatar { shape: "square"; size: 64; icon: "UserOutlined" }
                AntAvatar { shape: "square"; size: "large"; icon: "UserOutlined" }
                AntAvatar { shape: "square"; icon: "UserOutlined" }
                AntAvatar { shape: "square"; size: "small"; icon: "UserOutlined" }
                AntAvatar { shape: "square"; size: 14; icon: "UserOutlined" }
            }

        }

        AntSpace {
            direction: Qt.Vertical

            AntSpace {
                align: "center"
                size: 16
                AntAvatar { icon: "UserOutlined" }
                AntAvatar { alt: "U"}
                AntAvatar { size: 40; alt: "USER" }
                AntAvatar {
                    antStyle {
                        backgroundColor: "#fde3cf"; color: "#f56a00"
                    }
                    alt: "U" }
                AntAvatar { icon: "qrc:/assets/ant.svg" }
            }

            AntSpace {
                align: "start"
                AntAvatar { id: antVatar; alt: "U"; size: "large"}
                AntSpace {
                    AntButton {
                        readonly property var data: [{text: "Lucy", bgColor: "#f56a00"}, {text: "Edward", bgColor: '#7265e6'}, {text: "Eason", bgColor: '#ffbf00'}, {text: "U", bgColor: '#00a2ae'}]
                        text: "ChangeText"
                        sizeType: AntButtonStyle.SizeType.Small

                        onClicked: {
                            var index = Math.floor(Math.random() * 4);
                            antVatar.alt = data[index].text
                            antVatar.antStyle.backgroundColor = data[index].bgColor
                        }
                    }

                    AntButton {
                        readonly property var data: [4, 3, 2, 1]
                        property int index: 0
                        text: "ChangeGap"
                        sizeType: AntButtonStyle.SizeType.Small

                        onClicked: {
                            if (index >= data.length) {
                                index = 0;
                            }
                            antVatar.gap = data[index++]
                        }
                    }
                }

               AntAvatar {shape: "square"; icon: "UserOutlined"; size: "large"; AntBadge {count: 1}}

               AntAvatar {shape: "square"; icon: "UserOutlined"; size: "large"; AntBadge {dot: true}}
            }

            AntSpace {
                direction: Qt.Vertical
                AntAvatarGroup {
                    AntAvatar {icon: "qrc:/assets/avatar_1.svg"}
                    AntAvatar {alt: "K"; antStyle {backgroundColor: '#f56a00'}}
                    AntAvatar {
                        id: tootipAvatar
                        hoverEnabled: true
                        antStyle {backgroundColor: '#87d068'} icon: "UserOutlined";

                        AntTooltip {target: tootipAvatar; title:"Ant User"; placement: Ant.Top}
                    }
                }

                AntAvatarGroup {
                    size: "large"
                    max {
                        count: 2
                        style { backgroundColor: '#f56a00'}
                    }

                    AntAvatar {icon: "qrc:/assets/avatar_1.svg"}
                    AntAvatar {icon: "qrc:/assets/avatar_2.svg" }
                    AntAvatar {icon: "qrc:/assets/avatar_3.png" }
                    AntAvatar {alt: "K"; antStyle { backgroundColor: '#f56a00'} }
                    AntAvatar {
                        id: tootipAvatar1
                        hoverEnabled: true
                        antStyle {backgroundColor: '#87d068'}
                        icon: "UserOutlined";

                        AntTooltip {target: tootipAvatar1; title:"Ant User"; placement: Ant.Top; z: 1071}
                    }
                }
            }
        }
    }
}
