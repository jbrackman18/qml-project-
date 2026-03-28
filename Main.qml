import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "Bagel Toaster"

    // StackView for navigation
    StackView {
        id: myStackView
        anchors.fill: parent
        initialItem: "Bagle.qml"
    }
}