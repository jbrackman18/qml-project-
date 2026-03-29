import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    color: "#1e1e1e"
    anchors.fill: parent
    property string correctPassword: "1234"
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }

    // back button outside Column so it anchors to the screen corner
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

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Enter Password"
            color: "white"
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            id: passwordField
            width: 200
            placeholderText: "Password"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: errorText
            text: ""
            color: "red"
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Submit"
            width: 200
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if (passwordField.text === correctPassword) {
                    stackView.push("qrc:/qt/qml/EagleHacks2026/maintainanceScreen.qml", { stackView: stackView })
                } else {
                    errorText.text = "Incorrect password"
                    passwordField.clear()
                }
            }
        }
    }
}