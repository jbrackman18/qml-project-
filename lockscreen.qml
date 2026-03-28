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
                    myStackView.push("maintainanceScreen.qml")
                } else {
                    errorText.text = "Incorrect password"
                    passwordField.clear()
                }
            }
        }
    }
}