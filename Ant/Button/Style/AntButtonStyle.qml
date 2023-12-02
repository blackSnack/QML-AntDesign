pragma Singleton

import QtQuick 2.15

QtObject {
    property ButtonStyle primaryStyle: Primary {}

    property ButtonStyle defaultStyle: Default {}

    property ButtonStyle dashedStyle: Dashed {}

    enum Type {
        Primary,
        Default,
        Dashed
    }

    enum SizeType {
        Default,
        Large,
        Small
    }
}
