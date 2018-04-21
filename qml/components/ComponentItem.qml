import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: item
    objectName: "Item"
    clip: true

    gradient: Gradient {
          GradientStop { position: 0.0; color: "lightblue" }
          GradientStop { position: 0.1; color: "lightblue" }
          GradientStop { position: 1.0; color: "white" }
      }

    anchors.left: parent.left
    anchors.right: parent.right
}
