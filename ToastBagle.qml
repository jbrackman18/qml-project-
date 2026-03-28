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
=======
    anchors.fill: parent

    property string selectedDuration: "NONE"
    property int toastSeconds: 0
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
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
        width: 75
        height: 25
        text: qsTr("15 SECONDS")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.right: buttonNormal.left
        anchors.rightMargin: 20
        onClicked: {
            selectedDuration = "LIGHT"
            toastSeconds = 15
>>>>>>> toasterscreenfunc
        }
    }

    Button {
        id: buttonNormal
        width: 75
        height: 25
<<<<<<< HEAD
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
=======
        text: qsTr("30 SECONDS")
        anchors.centerIn: parent
        onClicked: {
            selectedDuration = "NORMAL"
            toastSeconds = 30
>>>>>>> toasterscreenfunc
        }
    }

    Button {
        id: buttonToasty
        width: 75
        height: 25
<<<<<<< HEAD
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
=======
        text: qsTr("45 SECONDS")
        anchors.verticalCenter: buttonNormal.verticalCenter
        anchors.left: buttonNormal.right
        anchors.leftMargin: 20
        onClicked: {
            selectedDuration = "TOASTY"
            toastSeconds = 45
        }
    }

    Button {
        id: buttonNoToast
        width: 150
        height: 50
        text: qsTr("NO TOAST")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        onClicked: {
            stackView.push("Spread.qml")
        }
    }

    Button {
        id: buttonNext
        width: 150
        height: 50
        text: qsTr("Start Toasting")
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
    }
}
>>>>>>> toasterscreenfunc
