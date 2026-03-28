import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
<<<<<<< HEAD
    title: "Coffee Machine"
=======
    title: "Bagel Machine"
>>>>>>> jeff

    // StackView for navigation
    StackView {
        id: myStackView
        anchors.fill: parent
        initialItem: "Bagle.qml"
    }
}