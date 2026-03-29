import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    Image {
        id: background
        source: "images/picnicbackground.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 50
        spacing: 40

        Repeater {
            model: [
                { src: "images/plain-bagel.png", screen: "ToastBagle.qml" },
                { src: "images/whole-wheat-everything-bagel.png", screen: "ToastBagle.qml" },
                { src: "images/Bagels_Cinnamon_Raisin_Bagels.png", screen: "ToastBagle.qml" }
            ]

            Image {
                id: bagel
                source: Qt.resolvedUrl(modelData.src)
                width: 100
                height: 100

                Behavior on scale {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bagel.scale = 1.2
                    onExited: bagel.scale = 1.0
                    onClicked: myStackView.push(modelData.screen)
                }
            }
        }
    }

    Button {
        id: buttonTopRight
        width: 100
        height: 30
        text: "Maintenance"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        onClicked: {
            myStackView.push("lockscreen.qml")
        }

        contentItem: Text {
            text: buttonTopRight.text
            color: "white"
            font.pixelSize: 10
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: buttonTopRight.pressed ? "#44ffffff" : "transparent"
            border.color: "white"
            border.width: 1
            radius: 6
        }
    }
}

