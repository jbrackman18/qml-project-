import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Rectangle {
    color: "#b01010"
    anchors.fill: parent
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
        running: false
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
        spacing: 30

        Text {
            text: "Toasting Bagel..."
            color: "white"
            font.pixelSize: 26
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // circular timer
        Item {
            width: 180
            height: 180
            anchors.horizontalCenter: parent.horizontalCenter

            // background circle
            Canvas {
                id: bgCircle
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 80, 0, Math.PI * 2)
                    ctx.strokeStyle = "#44ffffff"
                    ctx.lineWidth = 10
                    ctx.stroke()
                }
            }

            // progress arc
            Canvas {
                id: progressCircle
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    var progress = toastSeconds > 0 ? timeLeft / toastSeconds : 0
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 80,
                            -Math.PI / 2,
                            -Math.PI / 2 + progress * Math.PI * 2)
                    ctx.strokeStyle = "#ffdd44"
                    ctx.lineWidth = 10
                    ctx.lineCap = "round"
                    ctx.stroke()
                }
            }

            // time text in center
            Text {
                text: timeLeft + "s"
                color: "#ffdd44"
                font.pixelSize: 48
                font.bold: true
                anchors.centerIn: parent
            }
        }

        // update arc every second
        Connections {
            target: toastTimer
            function onTriggered() {
                progressCircle.requestPaint()
            }
        }

        Button {
            id: cancelButton
            width: 140
            height: 45
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                toastTimer.stop()
                stackView.pop()
            }
            contentItem: Text {
                text: "Cancel"
                color: "white"
                font.pixelSize: 14
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                color: cancelButton.pressed ? "#44ffffff" : "transparent"
                border.color: "white"
                border.width: 2
                radius: 10
            }
        }
    }
}