import QtQuick 2.15
import QtQuick.Controls 2.15
<<<<<<< HEAD
import QtQuick.Layouts 2.15
Rectangle {
    id:rectangle
    color: "Black"
    property int cookTime: 10
    property int timer: cookTime
    property bool timerFlag: true
    Timer{
        interval: 1000
        repeat: true
        running: timerFlag
        onTriggered: {
            if(cookTime > 0)
            {
                cookTime--
            }
            else
            {
                running = false
                myStackView.push("Spread.qml")
            }
        }
    }

    //Column will hold the progressbar for the cook time
    Column {
        id: column
        height: 150
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 70
        anchors.rightMargin: 70

        //ProgressBar used to tell user how long cook time will take
        ProgressBar {
            id: progressBar
            from: 0
            to: 10
            value: 10 - cookTime
        }
    }
    //Cancel button used to stop the toasting of the bagel
    Button {
        id: button
        y: 374
        width: 150
        height: 30
        text: qsTr("Cancel")
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked:
        {
            //stops timer for the cooking
            timerFlag = false

            //returns back to ToastBagle screen
            myStackView.push("ToastBagle.qml")
        }
    }

}
=======
Rectangle {
    color: "#b01010"
    anchors.fill: parent
    property int toastSeconds: 30
    property int timeLeft: 0
    property var stackView
    Component.onCompleted: {
        if (!stackView) stackView = StackView.view
        timeLeft = toastSeconds
        toastTimer.start()
    }

    Timer {
        id: toastTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            if (timeLeft > 0) {
                timeLeft--
            } else {
                toastTimer.stop()
                stackView.push("qrc:/qt/qml/EagleHacks2026/Spread.qml", { stackView: stackView })
            }
        }
    }
    Column {
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: "Toasting bagel..."
            color: "white"
            font.pixelSize: 22
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: timeLeft + "s"
            color: "#ffdd44"
            font.pixelSize: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ProgressBar {
            width: 200
            from: 0
            to: toastSeconds
            value: toastSeconds - timeLeft
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            text: "Cancel"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                toastTimer.stop()
                stackView.pop()
            }
        }
    }
}
>>>>>>> toasterscreenfunc
