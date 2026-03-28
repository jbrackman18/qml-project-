import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle

    color: "#272EF5"

    Button {
        id: button
        width: 61
        height: 41
<<<<<<< HEAD
        text: "Button"
=======
        text: "Start"
>>>>>>> toasterscreenfunc
        icon.color: "#030303"
        palette.buttonText: "Black"
        anchors.centerIn: parent
        onClicked:
        {
            myStackView.push("ToastBagle.qml")
        }
    }
}
