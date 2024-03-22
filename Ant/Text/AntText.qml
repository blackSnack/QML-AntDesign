import QtQuick 2.15

import AntCore 1.0
import "./Style"

Text {
    id: root

    property AntTextStyle antStyle: AntTextStyle {}
    verticalAlignment: Text.AlignVCenter
    color: AntTheme.colorText
    font: antStyle.font
}
