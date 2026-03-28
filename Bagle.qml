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
        text: "Start"
        icon.color: "#030303"
        palette.buttonText: "Black"
        anchors.centerIn: parent
        onClicked:
        {
            myStackView.push("ToastBagle.qml")
        }
    }
<<<<<<< HEAD
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
=======
>>>>>>> 1beda2ad07af186c9902f50b372b0e844a5bd6a8
}
