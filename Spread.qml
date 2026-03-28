import QtQuick 2.15
import QtQuick.Controls 2.15
<<<<<<< HEAD
import QtQuick.Layouts
=======
>>>>>>> toasterscreenfunc

Rectangle {
    id: rectangle
    color: "#d61515"
<<<<<<< HEAD


    Button {
        id: buttonHome
        width: 150
        height: 50
        text: qsTr("Return")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 62
        anchors.verticalCenterOffset: 171
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent

        onClicked:
        {
            myStackView.pop(null)
        }
    }

    Button {
        id: buttonSpread2
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: buttonHome.horizontalCenter
=======
    anchors.fill: parent

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
>>>>>>> toasterscreenfunc
    }

    Button {
        id: buttonSpread1
        width: 75
        height: 25
<<<<<<< HEAD
        text: qsTr("Button")
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.right: buttonSpread2.left
        anchors.rightMargin: 79

        anchors.verticalCenterOffset: 1
=======
        text: qsTr("Butter")
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.right: buttonSpread2.left
        anchors.rightMargin: 20
        onClicked: selectedSpread = "Butter"
    }

    Button {
        id: buttonSpread2
        width: 75
        height: 25
        text: qsTr("Cream Cheese")
        anchors.centerIn: parent
        onClicked: selectedSpread = "Cream Cheese"
>>>>>>> toasterscreenfunc
    }

    Button {
        id: buttonSpread3
        width: 75
        height: 25
<<<<<<< HEAD
        text: qsTr("Button")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: buttonSpread2.right
        anchors.leftMargin: 79
        anchors.verticalCenterOffset: 0
    }



}
=======
        text: qsTr("Jam")
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.left: buttonSpread2.right
        anchors.leftMargin: 20
        onClicked: selectedSpread = "Jam"
    }

    Button {
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

    Button {
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
>>>>>>> toasterscreenfunc
