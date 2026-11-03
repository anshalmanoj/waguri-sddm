import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2

import SddmComponents 2.0

Item {
    id: loginPanel

    property color primaryColor: "#FF7AD9"
    property color textColor: "#FDF4FF"
    property color mutedColor: "#D8B4FE"
    property color errorColor: "#FF6B9A"
    property color successColor: "#8EF0C8"
    property string fontFamily: "Quicksand"
    property string fontFamilyBold: "Quicksand"

    readonly property real base: width / 26
    readonly property real earSize: base * 4.4
    readonly property real cardRadius: width * 0.052

    TextConstants { id: textConstants }

    // Outer soft glow behind the card
    Rectangle {
        anchors.fill: card
        anchors.margins: -base * 0.45
        radius: card.radius + base * 0.45
        color: "#26A855F7"
    }

    // Cute ears, tucked behind the card
    Rectangle {
        width: loginPanel.earSize; height: width
        x: card.width * 0.20 - width / 2
        y: -height / 2
        radius: base * 0.5
        rotation: 45
        color: "#E62A1750"
    }
    Rectangle {
        width: loginPanel.earSize * 0.48; height: width
        x: card.width * 0.20 - width / 2
        y: -loginPanel.earSize * 0.09 - height / 2
        radius: base * 0.28
        rotation: 45
        color: "#FFB6E9"
    }
    Rectangle {
        width: loginPanel.earSize; height: width
        x: card.width * 0.80 - width / 2
        y: -height / 2
        radius: base * 0.5
        rotation: 45
        color: "#E62A1750"
    }
    Rectangle {
        width: loginPanel.earSize * 0.48; height: width
        x: card.width * 0.80 - width / 2
        y: -loginPanel.earSize * 0.09 - height / 2
        radius: base * 0.28
        rotation: 45
        color: "#FFB6E9"
    }

    // Cute flower accent on right ear
    Image {
        width: loginPanel.base * 1.5; height: width
        x: card.width * 0.80 + loginPanel.base * 0.25
        y: -loginPanel.base * 0.75
        source: "../Assets/flower.svg"
        fillMode: Image.PreserveAspectFit
    }

    // Main Card
    Rectangle {
        id: card
        anchors.fill: parent
        radius: loginPanel.cardRadius
        border.width: Math.max(1, base * 0.08)
        border.color: "#59C084FC"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#E6261347" }
            GradientStop { position: 0.55; color: "#E61A0C33" }
            GradientStop { position: 1.0; color: "#E6120826" }
        }
    }

    ColumnLayout {
        anchors.fill: card
        anchors.margins: base * 1.7
        spacing: base * 0.85

        // Cute Waguri Avatar Badge with glowing ring
        Item {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: base * 4.8
            Layout.preferredHeight: base * 4.8

            Rectangle {
                id: avatarRing
                anchors.fill: parent
                radius: width / 2
                border.width: Math.max(2, base * 0.12)
                border.color: "#FFD6F5"
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFA1E5" }
                    GradientStop { position: 0.5; color: "#C084FC" }
                    GradientStop { position: 1.0; color: "#7C3AED" }
                }

                // Inner circle for avatar
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - Math.max(4, loginPanel.base * 0.22)
                    height: width
                    radius: width / 2
                    color: "#280B3B"
                    clip: true

                    Image {
                        anchors.fill: parent
                        source: "../Assets/waguri-avatar.png"
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                    }
                }
            }

            // Small flower badge on bottom-right of avatar
            Rectangle {
                width: base * 1.25; height: width
                radius: width / 2
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: -base * 0.08
                anchors.bottomMargin: -base * 0.04
                color: "#280B3B"
                border.width: 1.5
                border.color: "#FFD6F5"

                Image {
                    anchors.centerIn: parent
                    width: parent.width * 0.70
                    height: width
                    source: "../Assets/flower.svg"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        // Welcome Header
        ColumnLayout {
            Layout.fillWidth: true
            spacing: base * 0.08

            QQC2.Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: "Welcome back ♡"
                color: loginPanel.textColor
                font.family: loginPanel.fontFamilyBold
                font.pixelSize: base * 1.3
                elide: Text.ElideRight
            }

            QQC2.Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: sddm.hostName ? "sign in to " + sddm.hostName : "kaoruko waguri theme"
                color: loginPanel.mutedColor
                font.family: loginPanel.fontFamily
                font.pixelSize: base * 0.68
                elide: Text.ElideRight
            }
        }

        // Username Field
        QQC2.TextField {
            id: name
            Layout.fillWidth: true
            Layout.preferredHeight: base * 2.55
            text: userModel.lastUser
            color: loginPanel.textColor
            selectionColor: "#66FF7AD9"
            selectedTextColor: "#FFFFFF"
            placeholderText: textConstants.userName
            placeholderTextColor: "#9D84BC"
            font.family: loginPanel.fontFamily
            font.pixelSize: base * 0.82
            leftPadding: base * 2.5
            rightPadding: base * 0.9
            verticalAlignment: TextInput.AlignVCenter
            selectByMouse: true

            background: Rectangle {
                color: name.activeFocus ? "#E62A1450" : "#B3150A2C"
                radius: height * 0.34
                border.width: Math.max(1, loginPanel.base * 0.07)
                border.color: name.activeFocus ? loginPanel.primaryColor : "#4D8B6BC4"
                Behavior on color { ColorAnimation { duration: 140 } }
                Behavior on border.color { ColorAnimation { duration: 140 } }
            }

            Image {
                source: "../Assets/user.svg"
                width: loginPanel.base * 0.95
                height: width
                anchors.left: parent.left
                anchors.leftMargin: loginPanel.base * 0.9
                anchors.verticalCenter: parent.verticalCenter
                opacity: name.activeFocus ? 0.95 : 0.55
                fillMode: Image.PreserveAspectFit
            }

            KeyNavigation.backtab: rebootButton
            KeyNavigation.tab: password

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(name.text, password.text, session.currentIndex)
                    event.accepted = true
                }
            }
        }

        // Password Field
        QQC2.TextField {
            id: password
            Layout.fillWidth: true
            Layout.preferredHeight: base * 2.55
            font.family: loginPanel.fontFamily
            font.pixelSize: base * 0.82
            color: loginPanel.textColor
            selectionColor: "#66FF7AD9"
            selectedTextColor: "#FFFFFF"
            placeholderText: textConstants.password
            placeholderTextColor: "#9D84BC"
            leftPadding: base * 2.5
            rightPadding: base * 0.9
            verticalAlignment: TextInput.AlignVCenter
            echoMode: TextInput.Password
            passwordCharacter: "•"
            passwordMaskDelay: 0
            focus: true
            selectByMouse: true

            background: Rectangle {
                color: password.activeFocus ? "#E62A1450" : "#B3150A2C"
                radius: height * 0.34
                border.width: Math.max(1, loginPanel.base * 0.07)
                border.color: password.activeFocus ? loginPanel.primaryColor : "#4D8B6BC4"
                Behavior on color { ColorAnimation { duration: 140 } }
                Behavior on border.color { ColorAnimation { duration: 140 } }
            }

            Image {
                source: "../Assets/lock.svg"
                width: loginPanel.base * 0.95
                height: width
                anchors.left: parent.left
                anchors.leftMargin: loginPanel.base * 0.9
                anchors.verticalCenter: parent.verticalCenter
                opacity: password.activeFocus ? 0.95 : 0.55
                fillMode: Image.PreserveAspectFit
            }

            Timer {
                interval: 200
                running: name.text !== ""
                onTriggered: password.forceActiveFocus()
            }

            KeyNavigation.backtab: name
            KeyNavigation.tab: session

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(name.text, password.text, session.currentIndex)
                    event.accepted = true
                }
            }
        }

        // Session Selector
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: base * 2.1
            spacing: base * 0.5

            Image {
                source: "../Assets/monitor.svg"
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: base * 0.95
                Layout.preferredHeight: base * 0.95
                opacity: 0.55
                fillMode: Image.PreserveAspectFit
            }

            QQC2.ComboBox {
                id: session
                Layout.fillWidth: true
                Layout.preferredHeight: base * 2.1
                font.family: loginPanel.fontFamily
                font.pixelSize: base * 0.72
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0

                background: Rectangle {
                    color: "#8C150A2C"
                    radius: height * 0.34
                    border.width: Math.max(1, loginPanel.base * 0.07)
                    border.color: session.activeFocus ? "#80FF7AD9" : "#338B6BC4"
                }

                contentItem: Text {
                    leftPadding: loginPanel.base * 0.85
                    rightPadding: loginPanel.base * 2.0
                    text: session.displayText
                    font: session.font
                    color: loginPanel.textColor
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                indicator: Image {
                    x: session.width - width - loginPanel.base * 0.8
                    y: (session.height - height) / 2
                    width: loginPanel.base * 0.85
                    height: width
                    source: "../Assets/chevron.svg"
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.8
                }

                delegate: QQC2.ItemDelegate {
                    id: sessionDelegate
                    width: session.width
                    height: loginPanel.base * 2.0
                    highlighted: session.highlightedIndex === index

                    contentItem: Text {
                        leftPadding: loginPanel.base * 0.85
                        text: name
                        color: loginPanel.textColor
                        font: session.font
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        radius: loginPanel.base * 0.3
                        color: sessionDelegate.hovered || sessionDelegate.highlighted ? "#4D8B5CF6" : "transparent"
                    }
                }

                popup: QQC2.Popup {
                    y: session.height + loginPanel.base * 0.25
                    x: 0
                    width: session.width
                    padding: loginPanel.base * 0.35

                    background: Rectangle {
                        color: "#F21B0D33"
                        radius: loginPanel.base * 0.8
                        border.width: 1
                        border.color: "#66B98CFF"
                    }

                    contentItem: ListView {
                        clip: true
                        implicitHeight: Math.min(contentHeight, loginPanel.base * 9)
                        model: session.popup.visible ? session.delegateModel : null
                        currentIndex: session.highlightedIndex

                        QQC2.ScrollIndicator.vertical: QQC2.ScrollIndicator { }
                    }
                }

                KeyNavigation.backtab: password
                KeyNavigation.tab: loginButton
            }
        }

        // Status Label
        QQC2.Label {
            id: statusLabel
            Layout.fillWidth: true
            Layout.preferredHeight: base * 1.05
            text: textConstants.prompt
            color: loginPanel.mutedColor
            font.family: loginPanel.fontFamily
            font.pixelSize: base * 0.66
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight

            Connections {
                target: sddm
                function onLoginSucceeded() {
                    statusLabel.color = loginPanel.successColor
                    statusLabel.text = textConstants.loginSucceeded
                }
                function onLoginFailed() {
                    statusLabel.color = loginPanel.errorColor
                    statusLabel.text = textConstants.loginFailed
                }
            }
        }

        Item { Layout.fillHeight: true }

        // Login Button
        QQC2.Button {
            id: loginButton
            Layout.fillWidth: true
            Layout.preferredHeight: base * 2.55
            text: textConstants.login

            contentItem: Text {
                text: loginButton.text
                font.family: loginPanel.fontFamilyBold
                font.pixelSize: base * 0.85
                color: "#280738"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Item {
                Rectangle {
                    anchors.fill: parent
                    radius: height * 0.34
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#FFA1E5" }
                        GradientStop { position: 0.5; color: "#E879F9" }
                        GradientStop { position: 1.0; color: "#A855F7" }
                    }
                }
                Rectangle {
                    anchors.fill: parent
                    radius: height * 0.34
                    color: "#FFFFFF"
                    opacity: loginButton.hovered ? 0.16 : 0
                    Behavior on opacity { NumberAnimation { duration: 120 } }
                }
                Rectangle {
                    anchors.fill: parent
                    radius: height * 0.34
                    color: "#000000"
                    opacity: loginButton.down ? 0.12 : 0
                }
            }

            scale: loginButton.down ? 0.985 : 1.0
            Behavior on scale { NumberAnimation { duration: 90 } }

            onClicked: sddm.login(name.text, password.text, session.currentIndex)

            KeyNavigation.tab: shutdownButton
        }

        // Action Buttons (Shutdown / Reboot)
        RowLayout {
            Layout.fillWidth: true
            spacing: base * 0.6

            QQC2.Button {
                id: shutdownButton
                Layout.fillWidth: true
                Layout.preferredHeight: base * 2.15

                contentItem: Item {
                    Row {
                        anchors.centerIn: parent
                        spacing: loginPanel.base * 0.4

                        Image {
                            width: loginPanel.base * 0.8
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../Assets/power.svg"
                            fillMode: Image.PreserveAspectFit
                            opacity: 0.8
                        }

                        Text {
                            text: textConstants.shutdown
                            font.family: loginPanel.fontFamily
                            font.pixelSize: loginPanel.base * 0.62
                            color: shutdownButton.hovered ? loginPanel.primaryColor : loginPanel.mutedColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                background: Rectangle {
                    radius: loginPanel.base * 0.7
                    color: shutdownButton.hovered ? "#26FF7AD9" : "#0DFFFFFF"
                    border.width: 1
                    border.color: shutdownButton.hovered ? "#66FF7AD9" : "#1FFFFFFF"
                    Behavior on color { ColorAnimation { duration: 120 } }
                    Behavior on border.color { ColorAnimation { duration: 120 } }
                }

                onClicked: sddm.powerOff()

                KeyNavigation.backtab: loginButton
                KeyNavigation.tab: rebootButton
            }

            QQC2.Button {
                id: rebootButton
                Layout.fillWidth: true
                Layout.preferredHeight: base * 2.15

                contentItem: Item {
                    Row {
                        anchors.centerIn: parent
                        spacing: loginPanel.base * 0.4

                        Image {
                            width: loginPanel.base * 0.8
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../Assets/reboot.svg"
                            fillMode: Image.PreserveAspectFit
                            opacity: 0.8
                        }

                        Text {
                            text: textConstants.reboot
                            font.family: loginPanel.fontFamily
                            font.pixelSize: loginPanel.base * 0.62
                            color: rebootButton.hovered ? loginPanel.primaryColor : loginPanel.mutedColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                background: Rectangle {
                    radius: loginPanel.base * 0.7
                    color: rebootButton.hovered ? "#26FF7AD9" : "#0DFFFFFF"
                    border.width: 1
                    border.color: rebootButton.hovered ? "#66FF7AD9" : "#1FFFFFFF"
                    Behavior on color { ColorAnimation { duration: 120 } }
                    Behavior on border.color { ColorAnimation { duration: 120 } }
                }

                onClicked: sddm.reboot()

                KeyNavigation.backtab: shutdownButton
                KeyNavigation.tab: name
            }
        }
    }

    Component.onCompleted: {
        if (name.text === "")
            name.focus = true
        else
            password.focus = true
    }
}
