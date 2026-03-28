import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "#d61515"

    property string selectedSpread: ""
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }

    Text {
        text: "Select a Spread"
        color: "white"
        font.pixelSize: 22
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Text {
        text: selectedSpread !== "" ? "Selected: " + selectedSpread : "None selected"
        color: "white"
        font.pixelSize: 16
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80
    }

    // Spread selection row
    Button {
        id: buttonSpread1
        width: 75
        height: 25
        text: "Butter"
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.right: buttonSpread2.left
        anchors.rightMargin: 20
        onClicked: selectedSpread = "Butter"
    }

    Button {
        id: buttonSpread2
        width: 75
        height: 25
        text: "Cream Cheese"
        anchors.centerIn: parent
        onClicked: selectedSpread = "Cream Cheese"
    }

    Button {
        id: buttonSpread3
        width: 75
        height: 25
        text: "Jam"
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.left: buttonSpread2.right
        anchors.leftMargin: 20
        onClicked: selectedSpread = "Jam"
    }

    // No spread button
    Button {
        id: buttonNoSpread
        width: 150
        height: 50
        text: "No Spread"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        onClicked: {
            stackView.push("DoneScreen.qml", { stackView: stackView })
        }
    }

    // Finish button
    Button {
        id: buttonNext
        width: 150
        height: 50
        text: "Finish"
        enabled: selectedSpread !== ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        onClicked: {
            stackView.push("DoneScreen.qml", {
                spread: selectedSpread,
                stackView: stackView
            })
        }
    }
}