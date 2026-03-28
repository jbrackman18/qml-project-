import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent  // Fill the entire StackView/screen
    color: "#272EF5"  // Your background color (optional)

    Row {
        anchors.centerIn: parent
        spacing: parent.width * 0.05  // 5% of screen width

        // Plain bagel button
        Button {
            id: plain
            background: Image {
                source: "images/bagel.png"
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
                source: "images/bagel1.png"
                fillMode: Image.PreserveAspectFit
            }
            width: parent.parent.width * 0.3
            height: parent.parent.height * 0.4
            onClicked: myStackView.push("ToastBagle.qml")
        }
    }
}