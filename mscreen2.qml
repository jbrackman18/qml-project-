import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

    Rectangle {
        id: rectangle
        color: "#272EF5"
        anchors.fill: parent

    Button {
        id: buttonBack
        width: 60
        height: 30
        text: qsTr("< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        onClicked: myStackView.pop()
}
}