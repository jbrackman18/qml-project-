import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    id: rectangle
    color: "#272EF5"
    Image {
        id: background
        source: "https://i.imgur.com/rZrEFba.jpeg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 50
        spacing: 40

        Repeater {
            model: [
                { src: "https://collegestreetbagels.com/cdn/shop/files/plain-bagel.png?v=1751173948", screen: "ToastBagle.qml" },
                { src: "https://www.newyorkerbagels.com/cdn/shop/articles/whole-wheat-everything-bagel_1024x1024.png?v=1511207168", screen: "ToastBagle.qml" },
                { src: "https://turano.com/wp-content/uploads/2019/03/90093_Bagels_Cinnamon_Raisin_Bagels_TD_EDITED_v2_forceUpdate.png", screen: "ToastBagle.qml" }
            ]

            Image {
                id: bagel
                source: modelData.src
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