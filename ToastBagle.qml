import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#d61515"


    Button {
        id: buttonNoToast
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
            myStackView.push("Spread.qml")
        }
    }

    Button {
        id: buttonNormal
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.centerIn: parent

    }

    Button {
        id: buttonLightly
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.right: buttonNormal.left
        anchors.rightMargin: 100

        anchors.verticalCenterOffset: 0
    }

    Button {
        id: buttonToasty
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.left: buttonNormal.right
        anchors.leftMargin: 100
        anchors.verticalCenterOffset: 0
    }



}
