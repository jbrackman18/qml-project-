import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    anchors.fill: parent

    property string selectedMaintenance: ""
    Text {
        text: "Maintenance"
        color: "white"
        font.pixelSize: 22
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
    }
    Button {
        id: buttonMaintenance1
        width: 75
        height: 25
        text: qsTr("Settings 1")
        anchors.verticalCenter: buttonMaintenance2.verticalCenter
        anchors.right: buttonMaintenance2.left
        anchors.rightMargin: 20
        onClicked: selectedMaintenance = "Settings 1"
    }
    Button {
        id: buttonMaintenance2
        width: 75
        height: 25
        text: qsTr("Settings 2")
        anchors.centerIn: parent
        onClicked: selectedSpread = "Settings 2"
        }
    Button {
        id: buttonMaintenance3
        width: 75
        height: 25
        text: qsTr("Settings 3")
        anchors.verticalCenter: buttonMaintenance2.verticalCenter
        anchors.left: buttonMaintenance2.right
        anchors.leftMargin: 20
        onClicked: selectedSpread = "Settings 3"
    }
}