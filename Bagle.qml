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
                source: "images/bagel_PNG81.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * .3
            height: parent.parent.height * .4
            onClicked: myStackView.push("ToastBagle.qml")
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
        }
    }
}
