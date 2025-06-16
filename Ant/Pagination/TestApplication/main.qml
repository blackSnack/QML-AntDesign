import QtQuick 2.15
import QtQuick.Window 2.15

import AntPagination 1.0
import AntSpace 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Test_Pagination")

    AntSpace {
        direction: Qt.Vertical
        AntPagination {
            total: 80
        }

        AntPagination {
            total: 100

            showTotal: function(total, range) {
                return `${range[0]}-${range[1]} Total: ${total}`
            }
        }

        AntPagination {
            size: "small"
            total: 100
        }

        AntPagination {
            size: "small"
            total: 100
            showQuickJumper: true
        }
    }

}
