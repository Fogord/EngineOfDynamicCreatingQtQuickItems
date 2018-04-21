import QtQuick 2.9
import QtQuick.Controls 2.2
import QtBluetooth 5.2

import "../js/main.js" as Js

ApplicationWindow{
    id: root

    objectName: "Root"

    width: 320
    height: 548
    visible: true

    //needs for obsever
    property var algorithm: ({})

    Component.onCompleted: {
        //start programm here
        Js.app.start();
    }
}

