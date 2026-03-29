import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 450
    height: 400
    title: "SHT45 Sensor Monitor"

    color: "#f5f5f5"

    Column {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8

        // Title
        Text {
            text: "Adafruit 6260 - SHT45 Sensor"
            font.pointSize: 18
            font.bold: true
            color: "#333333"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Connection Status
        Rectangle {
            width: parent.width
            height: 50
            color: sensor.connected ? "#e8f5e9" : "#ffebee"
            border.color: sensor.connected ? "#4caf50" : "#f44336"
            border.width: 2
            radius: 8

            Row {
                anchors.centerIn: parent
                spacing: 10

                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: sensor.connected ? "#4caf50" : "#f44336"
                    anchors.verticalCenter: parent.verticalCenter

                    // Blinking animation when connected
                    SequentialAnimation on opacity {
                        running: sensor.connected
                        loops: Animation.Infinite
                        NumberAnimation { from: 1.0; to: 0.3; duration: 800 }
                        NumberAnimation { from: 0.3; to: 1.0; duration: 800 }
                    }
                }

                Text {
                    text: sensor.connected ? "Connected" : "Disconnected - Searching..."
                    color: sensor.connected ? "#2e7d32" : "#c62828"
                    font.pointSize: 14
                    font.bold: true
                }
            }
        }

        // Serial Number (if available)
        Text {
            text: "S/N: " + (sensor.serialNumber || "---")
            font.pointSize: 10
            color: "#666666"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: sensor.serialNumber !== ""
        }

        // Temperature Display
        Rectangle {
            width: parent.width
            height: 80
            color: "#fff3e0"
            border.color: "#ff9800"
            border.width: 2
            radius: 8

            Column {
                anchors.centerIn: parent
                spacing: 5

                Text {
                    text: "🌡️ Temperature"
                    font.pointSize: 12
                    color: "#e65100"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: sensor.temperature.toFixed(1) + " °C"
                    font.pointSize: 24
                    font.bold: true
                    color: "#e65100"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // Humidity Display
        Rectangle {
            width: parent.width
            height: 80
            color: "#e3f2fd"
            border.color: "#2196f3"
            border.width: 2
            radius: 8

            Column {
                anchors.centerIn: parent
                spacing: 5

                Text {
                    text: "💧 Humidity"
                    font.pointSize: 12
                    color: "#0d47a1"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: sensor.humidity.toFixed(1) + " %"
                    font.pointSize: 24
                    font.bold: true
                    color: "#0d47a1"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // Touch Indicator
        Rectangle {
            width: parent.width
            height: 50
            color: sensor.touch ? "#c8e6c9" : "#eeeeee"
            border.color: sensor.touch ? "#4caf50" : "#999999"
            border.width: 2
            radius: 8

            Text {
                anchors.centerIn: parent
                text: sensor.touch ? "👆 Touch: ACTIVE" : "Touch: Inactive"
                font.pointSize: 12
                color: sensor.touch ? "#2e7d32" : "#666666"
                font.bold: sensor.touch
            }
        }

        // Manual Refresh Button (optional)
        Button {
            text: "Manual Refresh"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: sensor.readSensor()
            enabled: sensor.connected

            background: Rectangle {
                color: parent.enabled ? (parent.pressed ? "#1976d2" : "#2196f3") : "#cccccc"
                radius: 4
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
