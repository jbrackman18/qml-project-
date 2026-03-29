import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    width: 200; height: 100
    color: "#222"
    radius: 10

    Column {
        anchors.centerIn: parent

        Text {
            text: sensorData.temperature.toFixed(1) + "°C"
            color: "orange"
            font.pixelSize: 28
        }

        Text {
            text: sensorData.humidity.toFixed(1) + "%"
            color: "lightblue"
            font.pixelSize: 20
        }
    }
}