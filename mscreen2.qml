import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    anchors.fill: parent
    property var stackView

    // ------------------------------------------------
    // SHT45 sensor values — update these from your
    // backend/C++ by exposing them as Q_PROPERTY and
    // registering the object with rootContext()
    // ------------------------------------------------
    property real sensorTemperature: 24.5   // degrees C from SHT45
    property real sensorHumidity: 58.3      // % RH from SHT45
    property bool sensorConnected: true     // set false if read fails

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

    // sensor status indicator
    Row {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        spacing: 6

        Rectangle {
            width: 10
            height: 10
            radius: 5
            color: sensorConnected ? "#00ff88" : "#ff4444"
            anchors.verticalCenter: parent.verticalCenter

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 600 }
                NumberAnimation { to: 1.0; duration: 600 }
            }
        }

        Text {
            text: sensorConnected ? "SHT45 Connected" : "SHT45 Not Found"
            color: sensorConnected ? "#00ff88" : "#ff4444"
            font.pixelSize: 11
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: "Environment Monitor"
            color: "white"
            font.pixelSize: 22
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // humidity gauge
        Item {
            width: 200
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter

            Canvas {
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

            Canvas {
                id: humidityArc
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    var progress = sensorHumidity / 100
                    var startAngle = Math.PI * 0.75
                    var endAngle = startAngle + progress * Math.PI * 1.5
                    ctx.beginPath()
                    ctx.arc(width / 2, height / 2, 80, startAngle, endAngle)
                    ctx.strokeStyle = sensorHumidity > 70 ? "#ff4444" :
                                      sensorHumidity > 50 ? "#ffdd44" : "#00ccff"
                    ctx.lineWidth = 14
                    ctx.lineCap = "round"
                    ctx.stroke()
                }

                Connections {
                    target: rectangle
                    function onSensorHumidityChanged() {
                        humidityArc.requestPaint()
                    }
                }
            }

            Column {
                anchors.centerIn: parent
                spacing: 2

                Text {
                    text: sensorHumidity.toFixed(1) + "%"
                    color: "white"
                    font.pixelSize: 32
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Humidity"
                    color: "#aaaaaa"
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Text {
                text: "0%"
                color: "#aaaaaa"
                font.pixelSize: 11
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
            }

            Text {
                text: "100%"
                color: "#aaaaaa"
                font.pixelSize: 11
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
            }
        }

        // humidity status
        Text {
            text: sensorHumidity < 30 ? "💧 Too Dry" :
                  sensorHumidity < 50 ? "✅ Comfortable" :
                  sensorHumidity < 70 ? "🌤 Slightly Humid" : "🌊 Too Humid"
            color: "white"
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}