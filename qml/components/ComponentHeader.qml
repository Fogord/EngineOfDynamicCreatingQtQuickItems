import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: componentRow

    objectName: "Header"

    anchors.left: parent.left
    anchors.right: parent.right

    signal pressedBack
    signal showPopup
    signal pressedAdd

    property var algorithm: ({})

    property alias text:        label.text
    property alias textBackBtn: back.text
    property alias textMenuBtn: menu.text

    property alias visibleBackBtn: back.visible
    property alias visibleAddBtn:  add.visible
    property alias visibleText:    label.visible
    property alias visibleMenuBtn: menu.visible

    ComponentButton {
        id: back
        height: parent.height
        text: "<"
        width: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        onClicked: {
            pressedBack()
        }
    }

    ComponentButton {
        id: add
        height: parent.height
        text: "+"
        width: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        onClicked: {
            pressedAdd()
        }
    }

    ComponentLabel {
        id: label
        text: "Todo list"
        verticalAlignment: Text.AlignVCenter
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.right: menu.left
        anchors.left: back.right
    }

    ComponentButton {
        id: menu
        text: "≡"
        height: parent.height
        width: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        onClicked: {
            showPopup()
        }
    }
}
