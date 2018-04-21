import QtQuick 2.9
import QtQuick.Controls 2.2

ListView {
    id: view

    anchors.left: parent.left
    anchors.right: parent.right

    contentWidth: root.width - margin
    flickableDirection: Flickable.VerticalFlick

    leftMargin: margin/2
    rightMargin: margin/2
    spacing: margin/2

    signal rowsIsInserted
    signal rowsIsRemoved
    signal itemChange
    signal itemRemove
    signal showSearchFild
    signal hiddenSearchFild

    property var algorithm: ({})

    property int currentIndexItemList: -1

    property alias  listModel        : listModel
    property int    margin           : 4
    property string iconChangeSource : ""
    property string iconRemoveSource : ""
    property string borderColor      : "#808080"

    ListModel {
        id: listModel
        dynamicRoles: true
        property string name: "listModel"
        onRowsInserted: {
            rowsIsInserted();
        }
        onRowsRemoved: {
            rowsIsRemoved();
        }
    }

    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

    model: listModel
    focus: true

    onAtYBeginningChanged: {
        if(atYBeginning && !atYEnd) {
            showSearchFild();
        }
    }

    onAtYEndChanged: {
        if(!atYBeginning && atYEnd) {
            hiddenSearchFild();
        }
    }

//    signal myselect(int playmode)

    onCurrentItemChanged: {
        currentIndexItemList = view.currentIndex
    }


    delegate:
        Flickable {
            id: flickItem
            width: parent.width
            height: 30


            onVisibleChanged: {
                if (!visible){
                    hiddenSearchFild();
                    remove.width = change.width = content.x = 0
                }
            }

            flickableDirection: Flickable.HorizontalFlick

            Item {
                id: row
                width: parent.width
                height: parent.height

                Item{
                    id: content
                    width: parent.width
                    height: parent.height

                    Label {
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 16
                        text: (model.index + 1) + ". " + model.name
                        color: flickItem.ListView.isCurrentItem ? "black" : "grey"
                    }

                    Rectangle{
                        id: borderBottom
                        color: borderColor
                        width: parent.width
                        anchors.bottom: parent.bottom
                        height: 1
                    }
                }

                Rectangle{
                    id: change
                    height: content.height
                    anchors.left: parent.left
                    color: "lightskyblue"

                    Image {
                        id: iconChange
                        width: parent.width/2
                        height: parent.height/2
                        anchors.centerIn: parent
                        source: iconChangeSource
                    }

                    Rectangle{
                        id: changeRightBorder
                        height: row.height
                        width: 1
                        color: borderColor
                        anchors.right: change.right
                        visible: change.width
                    }

                    MouseArea{
                        anchors.fill: change
                        onClicked: function() {
                            view.currentIndex = model.index
                            hiddenSearchFild();
                            itemChange()
                        }
                    }
                }

                Rectangle{
                    id: remove
                    height: content.height
                    anchors.right: parent.right
                    color: "salmon"

                    Image {
                        id: iconRemove
                        width: parent.width/2
                        height: parent.height/2
                        anchors.centerIn: parent
                        source: iconRemoveSource
                    }

                    Rectangle{
                        id: removeLeftBorder
                        height: row.height
                        width: 1
                        color: borderColor
                        anchors.left: remove.left
                        visible: remove.width
                    }

                    MouseArea{
                        anchors.fill: remove
                        onClicked: function() {
                            view.currentIndex = model.index
                            hiddenSearchFild();
                            itemRemove();
                        }
                    }
                }

                MouseArea {
                    anchors.fill: content
                    onClicked: {
                        view.currentIndex = model.index
                        remove.width = change.width = content.x = 0
                        hiddenSearchFild();
                    }
                }
            }

            onAtXBeginningChanged: {
                if(atXBeginning && !atXEnd) {
                    remove.width = content.x = 0;
                    change.width = row.height;
                    content.x    = row.height;
                }
            }

            onAtXEndChanged: {
                if(!atXBeginning && atXEnd) {
                    change.width = content.x = 0;
                    remove.width = row.height;
                    content.x    = -row.height;
                }
            }
    }
}





