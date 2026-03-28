import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Bagel Machine"

    // StackView for navigation
    StackView {
        id: myStackView
        anchors.fill: parent
        initialItem: "Bagle.qml"
    }
}