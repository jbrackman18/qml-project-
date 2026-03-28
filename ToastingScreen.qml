import QtQuick 2.15
import QtQuick.Controls 2.15
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
