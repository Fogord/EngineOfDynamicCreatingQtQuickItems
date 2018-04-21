import QtQuick 2.9
import QtQuick.Controls 2.2

Item{
    id: inputItem

    objectName: "Input"

    anchors.left: parent.left
    anchors.right: parent.right

    signal changed
    signal add

    property alias textInput:  input.text
    property alias btnVisible: btn.visible
    property alias btnText:    btn.text
    property alias placeholderTextInput: input.placeholderText

    onVisibleChanged: {
        textInput = ""
    }

    TextField {
        id: input
        font.pixelSize: 16
        anchors.left: parent.left
        anchors.right: btn.left
        background: Rectangle {
            color: "lightblue"
            border.color: "#808080"
            border.width: 1
        }
        onTextChanged: {
            changed();
        }
        onAccepted: {
            add();
        }
    }

    ComponentButton{
        id: btn
        width: font.pixelSize * text.length
        anchors.right: parent.right
        onClicked: {
            add();
        }
    }
}

