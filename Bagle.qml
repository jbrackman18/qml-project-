import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    anchors.fill: parent
    visible: true

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
            width: parent.parent.width * 0.3
            height: parent.parent.height * 0.4
            onClicked: {
                myStackView.push("ToastBagle.qml")
            }
        }

        // Everything bagel button
        Button {
            id: everything
            background: Image {
                source: "images/eBagel.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * 0.3
            height: parent.parent.height * 0.4
            onClicked: {
                myStackView.push("ToastBagle.qml")
            }
        }
    }
}