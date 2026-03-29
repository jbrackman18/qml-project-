import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#d61515"
    anchors.fill: parent
    property string selectedDuration: "NONE"
    property int toastSeconds: 0
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }
    Image {
        id: background
        source: "images/Picnic.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.4
    }
    Text {
        text: "Select Toast Level"
        color: "white"
        font.pixelSize: 22
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Text {
        text: "Selected: " + selectedDuration
        color: "white"
        font.pixelSize: 16
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80
    }

    Button {
        id: buttonLightly
        width: 100
        height: 35
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.right: buttonNormal.left
        anchors.rightMargin: 20
        onClicked: {
            selectedDuration = "LIGHT"
            toastSeconds = 15
        }
        contentItem: Text {
            text: "15 SECONDS"
            color: "white"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonLightly.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 2
            radius: 8
        }
    }

    Button {
        id: buttonNormal
        width: 100
        height: 35
        anchors.centerIn: parent
        onClicked: {
            selectedDuration = "NORMAL"
            toastSeconds = 30
        }
        contentItem: Text {
            text: "30 SECONDS"
            color: "white"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonNormal.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 2
            radius: 8
        }
    }

    Button {
        id: buttonToasty
        width: 100
        height: 35
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.left: buttonNormal.right
        anchors.leftMargin: 20
        onClicked: {
            selectedDuration = "TOASTY"
            toastSeconds = 45
        }
        contentItem: Text {
            text: "45 SECONDS"
            color: "white"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonToasty.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 2
            radius: 8
        }
    }

    Button {
        id: buttonNoToast
        width: 150
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        onClicked: {
            stackView.push("Spread.qml")
        }
        contentItem: Text {
            text: "NO TOAST"
            color: "white"
            font.pixelSize: 14
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonNoToast.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 2
            radius: 10
        }
    }

    Button {
        id: buttonNext
        width: 150
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        enabled: toastSeconds > 0
        onClicked: {
            stackView.push("ToastingScreen.qml", {
                toastSeconds: toastSeconds,
                stackView: stackView
            })
        }
        contentItem: Text {
            text: "Start Toasting"
            color: buttonNext.enabled ? "white" : "#88ffffff"
            font.pixelSize: 14
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonNext.pressed ? "#44ffffff" : "transparent"
            border.color: buttonNext.enabled ? "white" : "#88ffffff"
            border.width: 2
            radius: 10
        }
    }
    Button {
        id: buttonBack
        width: 70
        height: 30
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        onClicked: stackView.pop()
        contentItem: Text {
            text: "< Back"
            color: "white"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: buttonBack.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 1
            radius: 6
        }
    }
}