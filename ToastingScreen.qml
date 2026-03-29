import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Rectangle {
    anchors.fill: parent

    Image {
        id: background
        source: "images/Picnic.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 1
    }

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
        spacing: 35

        Text {
            text: "Toasting Bagel..."
            color: "White"
            font.pixelSize: 28
            font.bold: true
            opacity: 1
            anchors.horizontalCenter: parent.horizontalCenter
        }

        
        Item {
            width: 200
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter

            
            Rectangle {
                anchors.centerIn: parent
                width: 180
                height: 180
                radius: 90
                color: "#22ffffff"
                opacity: 0.2
                scale: 1.1
            }

            // background circle
            Canvas {
                id: bgCircle
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 85, 0, Math.PI * 2)
                    ctx.strokeStyle = "#33ffffff"
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
                    ctx.arc(width / 2, height / 2, 85,
                            -Math.PI / 2,
                            -Math.PI / 2 + progress * Math.PI * 2)

            
                    var grad = ctx.createLinearGradient(0, 0, width, height)
                    grad.addColorStop(0, "#ffdd44")
                    grad.addColorStop(1, "#ff8800")

                    ctx.strokeStyle = grad
                    ctx.lineWidth = 12
                    ctx.lineCap = "round"
                    ctx.shadowColor = "#ffaa00"
                    ctx.shadowBlur = 10
                    ctx.stroke()
                }
            }

            // time text
            Text {
                text: timeLeft + "s"
                color: "#ffdd44"
                font.pixelSize: 50
                font.bold: true
                anchors.centerIn: parent
            }
        }

        Connections {
            target: toastTimer
            function onTriggered() {
                progressCircle.requestPaint()
            }
        }

        Button {
            id: cancelButton
            width: 150
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                toastTimer.stop()
                stackView.pop()
            }

            contentItem: Text {
                text: "Cancel"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            
            background: Rectangle {
                radius: 12

                gradient: Gradient {
                    GradientStop { position: 0; color: cancelButton.pressed ? "#aa2222" : "#dd3333" }
                    GradientStop { position: 1; color: cancelButton.pressed ? "#771111" : "#aa2222" }
                }

                border.color: "#ffffff44"
                border.width: 1

                // subtle glow
                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: "#ffffff"
                    opacity: cancelButton.pressed ? 0.05 : 0.12
                }
            }
        }
    }
}
