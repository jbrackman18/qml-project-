import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    anchors.fill: parent
    color: "#f5e6d3"

    property int spreadSeconds: 5
    property int timeLeft: 0
    property string spreadType: "Cream Cheese"
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
        timeLeft = spreadSeconds
        spreadTimer.start()
    }

    Timer {
        id: spreadTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            if (timeLeft > 0) {
                timeLeft--
            } else {
                spreadTimer.stop()
                stackView.push("DoneScreen.qml", { stackView: stackView })
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: "Spreading " + spreadType + "..."
            color: "#333333"
            font.pixelSize: 26
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        AnimatedImage {
            id: spreadGif
            width: 350
            height: 350
            source: "qrc:/images/bagelSpread.gif"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectCrop
            playing: true

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: spreadGif.width
                    height: spreadGif.height
                    radius: 30
                }
            }
        }
    }
}