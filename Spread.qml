import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    color: "#d61515"

    property string selectedSpread: ""
    property var stackView

    Image {
        id: background
        source: "images/picnicbackground.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

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
    Row {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 50
            spacing: 40
        Button {
            id: buttonSpread1
            width: parent.parent.width * .2
            height: parent.parent.height * .2
            background: Image {
                source: "images/butter.png"
                fillMode: Image.PreserveAspectFit
            }
            anchors.verticalCenter: buttonSpread2.verticalCenter
            anchors.right: buttonSpread2.left
            anchors.rightMargin: 20
            onClicked: selectedSpread = "Butter"
        }

        Button {
            id: buttonSpread2
            width: parent.parent.width * .2
            height: parent.parent.height * .2
            background: Image {
                source: "images/cc.png"
                fillMode: Image.PreserveAspectFit
            }
            anchors.centerIn: parent
            onClicked: selectedSpread = "Cream Cheese"
        }

        Button {
            id: buttonSpread3
            width: parent.parent.width * .2
            height: parent.parent.height * .2
            background: Image {
                source: "images/jam.png"
                fillMode: Image.PreserveAspectFit
            }
            anchors.verticalCenter: buttonSpread2.verticalCenter
            anchors.left: buttonSpread2.right
            anchors.leftMargin: 20
            onClicked: selectedSpread = "Jam"
        }
    }

    RoundButton {
        id: buttonNoSpread
        width: 150
        height: 50
        text: qsTr("No Spread")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        onClicked: {
            stackView.push("DoneScreen.qml", { stackView: stackView })
        }
    }

    RoundButton {
        id: buttonNext
        width: 150
        height: 50
        text: qsTr("Finish")
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

