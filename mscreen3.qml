import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    anchors.fill: parent
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }

    Button {
        id: buttonBack
        width: 60
        height: 30
        text: qsTr("< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        onClicked: stackView.pop()
    }

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "✅"
            font.pixelSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "System is Up to Date"
            color: "white"
            font.pixelSize: 24
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "All components are running normally."
            color: "#cccccc"
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}