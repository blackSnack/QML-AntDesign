import QtQuick 2.15
import QtQuick.Controls 2.15

import AntButton 1.0
import AntCore 1.0
import AntSelect 1.0
import "./Style"

Control {
    id: root

    ///< Align	start | center | end
    property string align: "end"
    ///< Current page number
    property int current: defaultCurrent
    ///< Default initial page number
    property int defaultCurrent: 1
    ///< Default number of data items per page
    property int defaultPageSize: 10
    ///< Disable pagination	boolean
    property bool disabled: false
    ///< Whether to hide pager on single page
    property bool hideOnSinglePage: false
    ///< To customize item's inner	(page, type: 'page' | 'prev' | 'next', originalElement)
    property Component itemRender: null
    ///< Number of data items per page	number
    property int pageSize: defaultPageSize
    ///< Specify the sizeChanger options
    property var pageSizeOptions: [10, 20, 50, 100]
    ///< If size is not specified, Pagination would resize according to the width of the window
    property bool responsive: false
    ///< Show less page items
    property bool showLessItems: false
    ///< Determine whether you can jump to pages directly	boolean | { goButton: Component }	false
    property var showQuickJumper: false
    ///< Determine whether to show pageSize select, it will be true when total > 50	boolean | SelectProps
    property var showSizeChanger: total > 50
    ///< Show page item's title	boolean
    property bool showTitle: true
    ///< To display the total number and range	function(total, range)	-
    property var showTotal: (total, range) => {}
    ///< Whether to use simple mode	boolean
    property bool simple: false
    ///< Specify the size of Pagination, can be set to small	default | small
    property string size: "default"
    ///< Total number of data items	number
    property int total: 0

    ///< Called when the page number or pageSize is changed, and it takes the resulting page number and pageSize as its arguments
    signal change(var page, var pageSize)
    ///< Called when pageSize is changed
    signal showSizeChange(var current, var size)

    property AntPaginationStyle antStyle: AntPaginationStyle {}

    QtObject {
        id: self

        readonly property real itemSize: root.size === "small" ? antStyle.itemSizeSM : antStyle.itemSize
        readonly property real itemSpacing: root.size === "small" ? 0 : AntTheme.marginXS
        readonly property int totalPage: Math.ceil(total / pageSize)
        readonly property int step: 5
        readonly property bool enableMoreBtn: totalPage > step + 2
        readonly property int boudingOffset: Math.floor(step/2)
        readonly property int moreIndexModelLength:  10
        readonly property int startIndex: 1
        property int dynamicIndex: 0
        readonly property var model: {
            // 1 2 3 4 5 ... 10
            // 1 ... 3 4 5 6 7... 10
            if (enableMoreBtn) {
                return Array.from({length: moreIndexModelLength}, (_, i) => {return {index: i, comp: dynamicComp}})
            } else {
                return Array.from({length: totalPage}, (_, i) => {return {index: i, comp: indexBtnComp}})
            }
        }

        readonly property DefaultStyle defaultStyle: DefaultStyle {
            fontStateColor.normal: AntTheme.colorPrimary
        }

        readonly property LinkStyle moreBtnStyle: LinkStyle {
            fontStateColor.normal: AntTheme.colorTextPlaceholder
        }
    }
    implicitWidth: contentLoader.width
    implicitHeight: contentLoader.height

    Loader {
        id: contentLoader
        sourceComponent: Row {
            spacing: self.itemSpacing
            AntButton {
                type: AntButtonStyle.Type.Text
                implicitWidth: self.itemSize
                implicitHeight: self.itemSize
                enabled: (current > 1)
                iconOnly: true
                iconSource: "LeftOutlined"
                ButtonGroup.group: buttonGroup

                onClicked: current--
                onDoubleClicked: current--
            }

            Row {
                spacing: self.itemSpacing
                Repeater {
                    model: self.model

                    delegate: Loader {
                        readonly property int index: modelData.index
                        sourceComponent: modelData.comp
                    }
                }
            }

            AntButton {
                type: AntButtonStyle.Type.Text
                implicitWidth: self.itemSize
                implicitHeight: self.itemSize
                enabled: (current < self.totalPage)
                iconOnly: true
                iconSource: "RightOutlined"

                onClicked: current++
                onDoubleClicked: current++
            }
            AntSelect {
                antStyle {
                    size: Ant.Middle
                }
                width: 120
                value: 1
                visible: root.showSizeChanger
                options: (root.pageSizeOptions || []).map((item, index)=>({
                                                                              label: `${item}/page`,
                                                                              value: String(item)
                                                                          }))
                onChange: (value, option)=>{
                              root.pageSize = Number(value)
                              if (root.current > self.totalPage) {
                                  root.current = self.totalPage
                              }

                              showSizeChange(root.current, root.pageSize)
                          }
            }
        }
    }

    onCurrentChanged: {
        change(root.current, root.pageSize)
    }

    Component {
        id: indexBtnComp

        AntButton {
            readonly property int currentIndex: index + 1
            implicitWidth: self.itemSize
            implicitHeight: self.itemSize
            checkable: true
            checked: currentIndex == current
            style: checked ? self.defaultStyle : AntButtonStyle.textStyle
            text: index + 1
            ButtonGroup.group: buttonGroup

            onCheckedChanged: {
                if (checked) {
                    root.current = currentIndex
                }
            }
        }
    }

    Component {
        id: leftMoreBtnComp

        AntButton {
            implicitWidth: self.itemSize
            implicitHeight: self.itemSize
            iconOnly: true
            iconSource: hovered ? "DoubleLeftOutlined" : "EllipsisOutlined"
            style: self.moreBtnStyle
            onClicked: {
                root.current -= self.step
            }
        }
    }

    Component {
        id: rightMoreBtnComp

        AntButton {
            implicitWidth: self.itemSize
            implicitHeight: self.itemSize
            iconOnly: true
            iconSource: hovered ? "DoubleRightOutlined" : "EllipsisOutlined"
            style: self.moreBtnStyle
            onClicked: {
                root.current += self.step
            }
        }
    }

    Component {
        id: dynamicComp

        Loader {
            readonly property int index: parent.index
            readonly property int currentIndex: index + 1
            readonly property int displayRightMoreBtn: (currentIndex == self.totalPage - 1)&&
                                                       ((self.totalPage - root.current) >= (self.step - 1))
            readonly property int displayLeftMoreBtn: (currentIndex == 2) &&
                                                      (root.current >= self.step)
            sourceComponent: {
                if (displayLeftMoreBtn) {
                    return leftMoreBtnComp
                }

                if (displayRightMoreBtn) {
                    return rightMoreBtnComp
                }
                return dynamicBtnComp
            }
        }
    }

    Component {
        id: dynamicBtnComp

        AntButton {
            readonly property int currentIndex: parent.currentIndex
            readonly property int offset: self.step - currentIndex
            readonly property int realIndex: {
                if (currentIndex > self.boudingOffset && Math.abs(currentIndex - self.dynamicIndex) <= self.boudingOffset && currentIndex != self.dynamicIndex) {
                    return self.dynamicIndex - (self.dynamicIndex - currentIndex)
                }
                return currentIndex;
            }
            implicitWidth: visible ? self.itemSize : 0
            implicitHeight: visible ? self.itemSize : 0
            checkable: true
            visible: {
                if (currentIndex >= self.totalPage && currentIndex != self.moreIndexModelLength) {
                    return false
                }
                if (self.dynamicIndex < self.step && currentIndex <= self.step) {
                    return true
                }
                let rightDistance = (self.totalPage - self.dynamicIndex)
                if ((rightDistance < self.boudingOffset) && currentIndex > (self.dynamicIndex - (self.step  - rightDistance))) {
                    return true;
                }
                return (currentIndex != self.startIndex && currentIndex != self.moreIndexModelLength ) ? Math.abs(self.dynamicIndex - currentIndex) <= self.boudingOffset : true
            }
            checked: {
                return realIndex == current
            }
            style: checked ? self.defaultStyle : AntButtonStyle.textStyle
            text: {
                if (currentIndex == self.startIndex) {
                    return currentIndex;
                }


                if (currentIndex == self.moreIndexModelLength) {
                    return self.totalPage;
                }
                return realIndex
            }
            ButtonGroup.group: buttonGroup

            onCheckedChanged: {
                if (checked) {
                    root.current = realIndex
                    self.dynamicIndex = currentIndex
                }
            }
        }
    }

    ButtonGroup { id: buttonGroup }
}
