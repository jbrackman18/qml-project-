import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    anchors.fill: parent
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
    }

    Button {
        id: buttonBack
        width: 60
        height: 30
        text: qsTr("< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        onClicked: stackView.pop()
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Toaster Temperature"
            color: "white"
            font.pixelSize: 22
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // temperature gauge
        Item {
            width: 200
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter

            // background circle
            Canvas {
                id: bgArc
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 80, Math.PI * 0.75, Math.PI * 2.25)
                    ctx.strokeStyle = "#44ffffff"
                    ctx.lineWidth = 14
                    ctx.stroke()
                }
            }

            // temperature fill arc
            Canvas {
                id: tempArc
                anchors.fill: parent
                property real temperature: 72  // 0 to 100
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    var progress = temperature / 100
                    var startAngle = Math.PI * 0.75
                    var endAngle = startAngle + progress * Math.PI * 1.5
                    // color shifts green -> yellow -> red with temperature
                    var r = Math.min(255, Math.floor(progress * 2 * 255))
                    var g = Math.min(255, Math.floor((1 - progress) * 2 * 255))
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 80, startAngle, endAngle)
                    ctx.strokeStyle = "rgb(" + r + "," + g + ",0)"
                    ctx.lineWidth = 14
                    ctx.lineCap = "round"
                    ctx.stroke()
                }
            }

            // temperature number
            Text {
                text: tempArc.temperature + "°C"
                color: "white"
                font.pixelSize: 36
                font.bold: true
                anchors.centerIn: parent
            }

            // min/max labels
            Text {
                text: "0°"
                color: "#aaaaaa"
                font.pixelSize: 12
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
            }

            Text {
                text: "100°"
                color: "#aaaaaa"
                font.pixelSize: 12
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
            }
        }

        // slider to simulate temperature change
        Slider {
            id: tempSlider
            width: 200
            from: 0
            to: 100
            value: 72
            anchors.horizontalCenter: parent.horizontalCenter
            onValueChanged: {
                tempArc.temperature = Math.round(value)
                tempArc.requestPaint()
            }
        }

        Text {
            text: tempArc.temperature < 40 ? "🟢 Cool" :
                  tempArc.temperature < 70 ? "🟡 Warm" : "🔴 Hot"
            color: "white"
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}