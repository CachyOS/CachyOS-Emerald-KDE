/*
    SPDX-FileCopyrightText: 2014 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick

Image {
    id: root
    source: "images/background.jpg"
    fillMode: Image.PreserveAspectCrop
    sourceSize.width: width
    sourceSize.height: height

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }

    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height
        source: "images/rectangle.svg"
        Image {
            source: "images/kde.svg"
            anchors.centerIn: parent
        }
        Rectangle {
            radius: 3
            color: "#17cdffb0"
            anchors {
                bottom: parent.bottom
                bottomMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            height: 6
            width: height * 36
            Rectangle {
                radius: 3
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width * Math.min(1, Math.max(0, root.stage - 1) / 5)
                color: "#ffffff"
                Behavior on width {
                    PropertyAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    PropertyAnimation {
        id: introAnimation
        running: false
        property: "y"
        target: topRect
        to: root.height / 3.7
        duration: 1000
        easing.type: Easing.InOutBack
        easing.overshoot: 1.0
    }
}
