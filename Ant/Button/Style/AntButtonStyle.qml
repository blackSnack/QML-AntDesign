pragma Singleton

import QtQuick 2.15

QtObject {
    property ButtonStyle primaryStyle: PrimaryStyle {}

    property ButtonStyle defaultStyle: DefaultStyle {}

    property ButtonStyle dashedStyle: DashedStyle {}

    property ButtonStyle textStyle: TextStyle {}

    property ButtonStyle linkStyle: LinkStyle {}

    enum Type {
        Primary,
        Default,
        Dashed,
        Text,
        Link
    }

    enum SizeType {
        Default,
        Large,
        Small
    }

    enum Shape {
        Default,
        Round
    }
}
