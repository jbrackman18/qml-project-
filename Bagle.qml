import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    visible: true
    property alias timeDisplay: timeDisplay


    Image {
        id: background_image
        anchors.fill: parent
        source: "images/bagelback"
        fillMode: Image.Stretch
    }
    // Creates a button with a plain bagel image

    Row{
        anchors.centerIn: parent
        spacing: parent.width * .05
        // Plain bagel button
        Button {
            id: plain
            background: Image {
                source: "images/bagel_PNG81.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * .3
            height: parent.parent.height * .4
            onClicked: myStackView.push("ToastBagle.qml")

            Text {
                id: bagel_text_1
                text: qsTr("Plain Bagel")
                font.pixelSize: 50
                color: "white"

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -50
            }
        }
        // Creates an button with a image of an everything bagel
        Button {
            id: everything
            background: Image {
                source: "images/download.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * .3
            height: parent.parent.height * .4
            onClicked: myStackView.push("ToastBagle.qml")

            Text {
                id: bagel_text_2
                text: qsTr("Plain Bagel")
                font.pixelSize: 50
                color: "white"

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -50
            }
        }
    }

    Text {
        id: timeDisplay
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        font.pixelSize: 40
        color: "white"

        function updateTime() {
            var currentTime = new Date()
            return Qt.formatDateTime(currentTime, "hh:mm:ss");
        }

        text: updateTime()
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timeDisplay.text = timeDisplay.updateTime();
        }
    }
}
