import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "#1a1a1a"
    anchors.fill: parent
    property string spread: "Nothing"
    property var stackView

    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
        popAnimation.start()
    }

    // animated background gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3d0000" }
            GradientStop { position: 1.0; color: "#1a1a1a" }
        }
    }

    // bagel emoji big and bouncy
    Text {
        id: bagelEmoji
        text: "🥯"
        font.pixelSize: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80
        scale: 0

        NumberAnimation {
            id: popAnimation
            target: bagelEmoji
            property: "scale"
            from: 0
            to: 1
            duration: 600
            easing.type: Easing.OutBack
        }
    }

    // pulse glow behind bagel
    Rectangle {
        width: 120
        height: 120
        radius: 60
        color: "transparent"
        border.color: "#ffdd44"
        border.width: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 72
        opacity: 0

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation { to: 0.6; duration: 800; easing.type: Easing.InOutSine }
            NumberAnimation { to: 0.0; duration: 800; easing.type: Easing.InOutSine }
        }
    }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        spacing: 16

        Text {
            text: "Your Bagel is Ready!"
            color: "white"
            font.pixelSize: 28
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter

            SequentialAnimation on opacity {
                NumberAnimation { from: 0; to: 1; duration: 800 }
            }
        }

        Rectangle {
            width: 250
            height: 2
            color: "#ffdd44"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.6
        }

        Text {
            text: spread !== "Nothing" ? "🧈  Topped with " + spread : "🥯  Plain & perfect"
            color: "#ffdd44"
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item { width: 1; height: 20 }

        Button {
            id: homeButton
            width: 200
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: stackView.pop(null)

            contentItem: Text {
                text: "Back to Home"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: homeButton.pressed ? "#ffdd44" : "transparent"
                border.color: "#ffdd44"
                border.width: 2
                radius: 25
            }
        }
    }
}