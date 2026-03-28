import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    anchors.fill: parent
    visible: true
    property alias timeDisplay: timeDisplay


    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "images/bagelback.png"
        fillMode: Image.Stretch
    }

    // Maintenance button (top right)
    Button {
        id: buttonTopRight
        width: 60
        height: 30
        text: "Maintenance"
        font.pixelSize: 8
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        onClicked: {
            myStackView.push("maintainanceScreen.qml")
        }
    }
    Row {
        anchors.centerIn: parent
        spacing: parent.width * 0.05

        // Plain bagel button
        Button {
            id: plain
            background: Image {
                source: "images/plainBagel.png"
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

        // Everything bagel button
        Button {
            id: everything
            background: Image {
                source: "images/eBagel.png"
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
    Button {
        id: buttonTopRight
        width: 60
        height: 30
        text: qsTr("Maintenance")
        font.pixelSize: 8
        icon.color: "#030303"
        palette.buttonText: "Black"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        onClicked:
        {
            myStackView.push("maintainanceScreen.qml")
        }
    }
}
