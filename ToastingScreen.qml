import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "#b01010"

    property int toastSeconds: 30
    property int timeLeft: 0
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
        timeLeft = toastSeconds
        toastTimer.start()
    }

    Timer {
        id: toastTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            if (timeLeft > 0) {
                timeLeft--
            } else {
                toastTimer.stop()
                stackView.push("Spread.qml", { stackView: stackView })
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Toasting bagel..."
            color: "white"
            font.pixelSize: 22
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: timeLeft + "s"
            color: "#ffdd44"
            font.pixelSize: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ProgressBar {
            width: 200
            from: 0
            to: toastSeconds
            value: toastSeconds - timeLeft
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Cancel"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                toastTimer.stop()
                stackView.pop()
            }
        }
    }
}