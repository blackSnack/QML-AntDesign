import QtQuick 2.15
import AntCore 1.0

Item {
    id: root

    // start | end |center |baseline
    property string align: "start"
    property int direction: Qt.Horizontal
    // 'small' | 'middle' | 'large' | number
    property var size: "middle"

    QtObject {
        id: self
        readonly property real padding: AntTheme.paddingXS
        readonly property real spacing: {
            if (typeof root.size == "string") {
                if (root.size == "small") {
                    return AntTheme.paddingXS
                }
                if (root.size == "large") {
                    return AntTheme.paddingLG
                }
                return AntTheme.padding
            }

            if (typeof root.size == "number") {
                return root.size
            }
            return AntTheme.padding
        }

        function getItemXEndPosition(item) {
            if (item) {
                return item.x + getItemWidth(item)
            }
        }

        function getItemYEndPosition(item) {
            if (item) {
                return item.y + getItemHeight(item)
            }
        }

        // no padding width
        function getItemContentWidth(item) {
            return item ? Math.max(item.width, item.implicitWidth) - (padding *2) : 0
        }
        // no padding height
        function getItemContentHeight(item) {
            return item ? Math.max(item.height, item.implicitHeight) - (padding *2) : 0
        }

        function getItemWidth(item) {
            return item ? Math.max(item.width, item.implicitWidth) : 0
        }

        function getItemHeight(item) {
            return item ? Math.max(item.height, item.implicitHeight) : 0
        }

        function relayoutV() {
            for (var i = 0; i < root.visibleChildren.length; i++) {
                let item = root.visibleChildren[i]

                if (direction == Qt.Vertical) {
                    let lastX = item.x
                    item.x = 0
                    if (align == "center") {
                        item.x = ((getItemContentWidth(root) - getItemWidth(item)) / 2.0) + padding
                    } else if (align == "end") {
                        item.x = getItemWidth(root) - getItemWidth(item) - padding
                    }else if (align == "baseline") {
                        if (getItemWidth(item) > (getItemContentWidth(root) / 2.0)) {
                            // nothing todo
                            item.x = lastX;
                            console.warn("Cannot to align baseline. Width not enough!")
                        } else {
                            item.x = (getItemWidth(root) / 2.0)
                        }
                    } else {
                        item.x = padding;
                    }
                }else {
                    let lastY = item.y
                    item.y = 0;
                    if (align == "center") {
                        item.y = ((getItemContentHeight(root) - getItemHeight(item)) / 2.0) + padding
                    } else if (align == "end") {
                        item.y = (getItemHeight(root) - getItemHeight(item)) - padding
                    }else if (align == "baseline") {
                        if (getItemHeight(item) > (getItemContentHeight(root) / 2.0)) {
                            // nothing todo
                            item.y = lastY
                            console.warn("Cannot to align baseline. Height not enough!")
                        } else {
                            item.y = (getItemHeight(root) / 2.0) + padding
                        }
                    } else {
                        item.y = + padding;
                    }
                }
            }
        }

        function relayoutH() {
            let preItem = null
            let totalWidth = 0;
            let totalHeight = 0
            for (var i = 0; i < root.visibleChildren.length; i++) {
                let item = root.visibleChildren[i]
                if (direction == Qt.Horizontal) {
                    item.x = 0;
                    if (i == 0) {
                        item.x += padding
                    } else {
                        if (preItem) {
                            item.x = getItemXEndPosition(preItem) + spacing
                            totalWidth += spacing
                        }
                    }
                    totalWidth += getItemWidth(item)
                    totalHeight = Math.max(totalHeight, getItemHeight(item))
                } else {
                    item.y = 0
                    if (i == 0) {
                        item.y += padding
                    } else {
                        if (preItem) {
                            item.y = getItemYEndPosition(preItem) + spacing
                            totalHeight += spacing
                        }
                    }
                    totalWidth = Math.max(totalWidth, getItemWidth(item))
                    totalHeight += getItemHeight(item)
                }
                
                preItem = item
                item.widthChanged.connect(self.relayout)
                item.heightChanged.connect(self.relayout)
            }
            root.implicitWidth = totalWidth + (padding * 2)
            root.implicitHeight = totalHeight + (padding * 2)
        }

        function relayout() {
            if (visible) {
                relayoutH()
                relayoutV()
            }
        }

        onSpacingChanged: relayout()
        onPaddingChanged: relayout()
    }

    onVisibleChildrenChanged: {
        if (visible) {
            self.relayout()
        }
    }

    onVisibleChanged: {
        self.relayout()
    }

    onAlignChanged: {
        self.relayout()
    }
}
