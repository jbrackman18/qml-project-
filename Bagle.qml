import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    visible: true

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
                source: "images/plainbagel.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * 0.3   // 30% of screen width
            height: parent.parent.height * 0.4  // 40% of screen height
            onClicked: myStackView.push("ToastBagle.qml")
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
            onClicked: myStackView.push("ToastBagle.qml")
        }
    }
}