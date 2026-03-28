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
        text: qsTr("No Toast")
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
        text: qsTr("Normaly Toasted")
        anchors.centerIn: parent
        onClicked:
        {
            //in the future add a variable to carry along to dicate cook time for ToastingScreen
            myStackView.push("ToastingScreen.qml")
        }

    }

    Button {
        id: buttonLightly
        width: 75
        height: 25
        text: qsTr("Lightly Toasted")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.right: buttonNormal.left
        anchors.rightMargin: 100
        anchors.verticalCenterOffset: 0
        onClicked:
        {
            //in the future add a variable to carry along to dicate cook time for ToastingScreen
            myStackView.push("ToastingScreen.qml")
        }
    }

    Button {
        id: buttonToasty
        width: 75
        height: 25
        text: qsTr("Heavily Toasted")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.left: buttonNormal.right
        anchors.leftMargin: 100
        anchors.verticalCenterOffset: 0
        onClicked:
        {
            //in the future add a variable to carry along to dicate cook time for ToastingScreen
            myStackView.push("ToastingScreen.qml")
        }
    }



}
