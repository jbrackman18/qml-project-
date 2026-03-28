import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#d61515"


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
    }

    Button {
        id: buttonSpread1
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.verticalCenter: buttonSpread2.verticalCenter
        anchors.right: buttonSpread2.left
        anchors.rightMargin: 79

        anchors.verticalCenterOffset: 1
    }

    Button {
        id: buttonSpread3
        width: 75
        height: 25
        text: qsTr("Button")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: buttonSpread2.right
        anchors.leftMargin: 79
        anchors.verticalCenterOffset: 0
    }



}
