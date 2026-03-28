import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "#3a3a3a"
    anchors.fill: parent

    property string spread: "Nothing"
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Your bagel is ready!"
            color: "white"
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: spread !== "Nothing" ? "Topped with: " + spread : "Plain bagel"
            color: "#ffdd44"
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Back to Home"
            width: 200
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: stackView.pop(null)
        }
    }
}