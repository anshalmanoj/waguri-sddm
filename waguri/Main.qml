import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

import "Components"

Rectangle {
    id: root
    width: 960
    height: 600

    property color primaryColor: "#FF7AD9"
    property color textColor: "#FDF4FF"
    property color mutedColor: "#D8B4FE"
    property color errorColor: "#FF6B9A"
    property color successColor: "#8EF0C8"

    property var now: new Date()

    FontLoader { id: fontMedium; source: "Assets/fonts/Quicksand-Medium.ttf" }
    FontLoader { id: fontBold; source: "Assets/fonts/Quicksand-Bold.ttf" }

    readonly property string uiFont: fontMedium.status === FontLoader.Ready ? fontMedium.name : "Quicksand"
    readonly property string uiFontBold: fontBold.status === FontLoader.Ready ? fontBold.name : uiFont
    readonly property bool showClock: String(config.showClock) !== "false"
    readonly property bool showCharacter: String(config.showCharacter) === "true"
    readonly property bool showFloatingPetals: String(config.showFloatingPetals) !== "false"

    Timer {
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: root.now = new Date()
    }

    Repeater {
        model: screenModel

        Item {
            id: screenItem
            property variant geometry: screenModel.geometry(index)
            x: geometry.x; y: geometry.y
            width: geometry.width; height: geometry.height

            Image {
                id: bg
                anchors.fill: parent
                source: Qt.resolvedUrl(config.background ? config.background : "Assets/waguri-moonlight.jpg")
                fillMode: Image.PreserveAspectCrop
                smooth: true
                onStatusChanged: {
                    if (status === Image.Error && source !== Qt.resolvedUrl("Assets/waguri-moonlight.jpg")) {
                        source = Qt.resolvedUrl("Assets/waguri-moonlight.jpg")
                    }
                }
            }

            MultiEffect {
                anchors.fill: bg
                source: bg
                blurEnabled: (config.BlurStrength !== undefined ? Number(config.BlurStrength) : 0.0) > 0.01
                blurMax: 64
                blur: config.BlurStrength !== undefined ? Number(config.BlurStrength) : 0.0
            }

            // Elegant gentle dark gradient on left side for text/card readability
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#B30A0416" }
                    GradientStop { position: 0.36; color: "#730A0416" }
                    GradientStop { position: 0.65; color: "#260A0416" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
            }

            // Subtle bottom vignette for depth
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.70; color: "#00000000" }
                    GradientStop { position: 1.0; color: "#400A0416" }
                }
            }
        }
    }

    Item {
        id: mainContainer
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y
        width: geometry.width; height: geometry.height

        // Floating Sakura / Fragrant Flower Petals
        Item {
            id: floatingPetalsContainer
            anchors.fill: parent
            visible: root.showFloatingPetals

            Repeater {
                model: 22

                Item {
                    id: petalItem
                    property real startX: parent.width * (0.02 + ((index * 0.381966) % 1) * 0.96)
                    property real driftDist: 25 + (index % 5) * 14
                    property real speed: 8500 + (index % 6) * 1100
                    property real rotSpeed: 4500 + (index % 4) * 1200

                    width: 14 + (index % 4) * 4
                    height: width * 1.15
                    x: startX
                    y: -height

                    Image {
                        id: petalImg
                        anchors.fill: parent
                        source: "Assets/petal.svg"
                        fillMode: Image.PreserveAspectFit
                        opacity: 0.40 + (index % 5) * 0.12
                    }

                    SequentialAnimation on y {
                        loops: Animation.Infinite
                        running: true
                        PauseAnimation { duration: (index * 480) % 3600 }
                        NumberAnimation {
                            from: -petalItem.height
                            to: parent.height + petalItem.height
                            duration: petalItem.speed
                            easing.type: Easing.Linear
                        }
                    }

                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        running: true
                        NumberAnimation {
                            to: petalItem.startX + petalItem.driftDist
                            duration: petalItem.speed / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            to: petalItem.startX - petalItem.driftDist
                            duration: petalItem.speed / 2
                            easing.type: Easing.InOutSine
                        }
                    }

                    RotationAnimation on rotation {
                        loops: Animation.Infinite
                        from: 0
                        to: (index % 2 === 0 ? 360 : -360)
                        duration: petalItem.rotSpeed
                        direction: index % 2 === 0 ? RotationAnimation.Clockwise : RotationAnimation.Counterclockwise
                    }
                }
            }
        }

        // Floating twinkle sparkles
        Item {
            id: sparklesContainer
            anchors.fill: parent

            Repeater {
                model: 24

                Image {
                    width: 7 + (index % 4) * 4
                    height: width
                    x: parent.width * (0.45 + ((index * 0.6180339887) % 1) * 0.52)
                    y: parent.height * (0.05 + ((index * 0.3819660113 + 0.18) % 1) * 0.88)
                    source: "Assets/sparkle.svg"
                    fillMode: Image.PreserveAspectFit
                    rotation: (index * 37) % 90

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        PauseAnimation { duration: (index % 6) * 300 }
                        NumberAnimation { to: 0.9; duration: 1500 + (index % 5) * 260; easing.type: Easing.InOutSine }
                        NumberAnimation { to: 0.1; duration: 1500 + (index % 5) * 260; easing.type: Easing.InOutSine }
                    }
                }
            }
        }

        // Optional foreground character sprite (if enabled)
        Item {
            id: character
            visible: root.showCharacter
            anchors.right: parent.right
            anchors.top: parent.top
            width: parent.width * 0.55
            height: parent.height

            Image {
                id: aura
                width: parent.width * 0.92
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -parent.height * 0.12
                source: "Assets/glow.svg"
                opacity: 0.7

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.9; duration: 4200; easing.type: Easing.InOutSine }
                    NumberAnimation { to: 0.62; duration: 4200; easing.type: Easing.InOutSine }
                }
            }

            Image {
                id: girl
                property real bob: 0
                x: parent.width - width + parent.width * 0.03
                y: parent.height - height + bob
                height: parent.height * 1.06
                width: height * 0.643
                source: "Assets/anime-girl.svg"
                fillMode: Image.PreserveAspectFit
                smooth: true

                SequentialAnimation on bob {
                    loops: Animation.Infinite
                    NumberAnimation { to: -9; duration: 3400; easing.type: Easing.InOutSine }
                    NumberAnimation { to: 0; duration: 3400; easing.type: Easing.InOutSine }
                }
            }
        }

        // Brand Title (Top-Left Badge)
        Item {
            id: brand
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.045
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.045
            width: brandRow.implicitWidth
            height: brandRow.implicitHeight

            Row {
                id: brandRow
                spacing: mainContainer.height * 0.012

                Image {
                    width: mainContainer.height * 0.042
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    source: "Assets/flower.svg"
                    fillMode: Image.PreserveAspectFit
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: mainContainer.height * 0.002

                    Text {
                        text: "waguri"
                        color: root.textColor
                        font.family: root.uiFontBold
                        font.pixelSize: Math.max(20, mainContainer.height * 0.030)
                        font.letterSpacing: mainContainer.height * 0.005
                    }

                    Text {
                        text: "kaoruko waguri theme"
                        color: root.mutedColor
                        font.family: root.uiFont
                        font.pixelSize: Math.max(9, mainContainer.height * 0.0125)
                        font.letterSpacing: mainContainer.height * 0.0018
                    }
                }
            }
        }

        // Left Login Stack
        Column {
            id: leftStack
            width: Math.min(parent.width * 0.33, parent.height * 0.51)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width * 0.20
            anchors.verticalCenter: parent.verticalCenter
            spacing: parent.height * 0.026

            // Centered Clock above the login card
            Column {
                width: parent.width
                visible: root.showClock
                spacing: parent.height * 0.002

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Qt.formatTime(root.now, "HH:mm")
                    color: root.textColor
                    font.family: root.uiFontBold
                    font.pixelSize: Math.min(mainContainer.height * 0.088, leftStack.width * 0.24)
                    font.letterSpacing: -1
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Qt.formatDate(root.now, "dddd, d MMMM")
                    color: root.mutedColor
                    font.family: root.uiFont
                    font.pixelSize: Math.max(11, mainContainer.height * 0.019)
                    font.letterSpacing: mainContainer.height * 0.0015
                }
            }

            Item {
                width: 1
                height: mainContainer.height * 0.02
            }

            LoginPanel {
                id: loginPanel
                width: parent.width
                height: width * 1.18

                primaryColor: root.primaryColor
                textColor: root.textColor
                mutedColor: root.mutedColor
                errorColor: root.errorColor
                successColor: root.successColor
                fontFamily: root.uiFont
                fontFamilyBold: root.uiFontBold
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: mainContainer.height * 0.008

                Image {
                    width: mainContainer.height * 0.016
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    source: "Assets/flower.svg"
                    opacity: 0.65
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    text: "Press Enter to sign in"
                    color: root.mutedColor
                    font.family: root.uiFont
                    font.pixelSize: Math.max(9, mainContainer.height * 0.014)
                    opacity: 0.85
                }
            }
        }
    }
}
