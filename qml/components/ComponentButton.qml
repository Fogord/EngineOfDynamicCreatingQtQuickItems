import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    id: button
    height: 30
    font.pixelSize: 16

    property var algorithm: ({})

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: button.down ? "lightblue" : "lightskyblue"
    }
}





