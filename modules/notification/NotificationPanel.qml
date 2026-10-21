import QtQuick
import Quickshell
import Quickshell.Widgets

import "../../services"
import "../../config"

Item {
    id: root

    // total size for cp
    // implicitWidth: panel.implicitWidth
    // implicitHeight: panel.implicitHeight

    function withAlpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    Rectangle {
        id: panel
        // implicitWidth: 405
        // implicitHeight: 900
        anchors.fill: parent
        color: Colors.notificationPanelColor
        border.width: 1
        border.color: root.withAlpha(Colors.notificationTitleColor, 0.06)
        radius: 9
        // radius: 
        topLeftRadius: 18
        topRightRadius: 18

        Component.onCompleted: {
            // stop dunst so qs can receive notifications
            Quickshell.execDetached(["systemctl", "--user", "stop", "dunst"])
        }


        // ── header: title + notification count ──────────────────────────────

        Rectangle{
            id: headerBackground
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 7
            }

            // width: 200
            height: 58
            radius: 4
            topLeftRadius: 16
            topRightRadius: 16

            color:Colors.bluetoothHeaderColor

        }

        Row {
            anchors {
                top: parent.top
                left: parent.left
                topMargin: 16
                leftMargin: 20
            }
            height: 32
            spacing: 10

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "Notifications"
                color: Colors.notificationHeaderTextColor
                font.pixelSize: 20
                font.family: "Quicksand"
                font.weight: Font.ExtraBold
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                visible: list.count > 0
                height: 22
                width: Math.max(22, badgeText.implicitWidth + 14)
                radius: height / 2
                color: Colors.notificationBadgeColor

                Text {
                    id: badgeText
                    anchors.centerIn: parent
                    text: list.count
                    color: Colors.notificationBadgeTextColor
                    font.pixelSize: 12
                    font.family: "Quicksand"
                    font.weight: Font.Bold
                }
            }
        }


        // ── clear all ───────────────────────────────────────────────────────
        Rectangle {
            id: clearAllButton
            anchors {
                top: parent.top
                right: parent.right
                topMargin: 16
                rightMargin: 20
            }
            implicitWidth: clearAllButtonText.implicitWidth + 28
            implicitHeight: 32
            radius: height / 2
            color: "transparent"
            border.width: 1
            border.color: Colors.notificationClearButtonBorderColor

            visible: list.count > 0
            scale: clearAllButtonMouseArea.pressed ? 0.92 : 1.0
            Behavior on scale { NumberAnimation { duration: 140; easing.type: Easing.OutCubic } }

            Text {
                id: clearAllButtonText
                anchors.centerIn: parent
                text: "Clear all"
                color: Colors.notificationClearButtonTextColor
                font.pixelSize: 13
                font.family: "Quicksand"
                font.weight: Font.Medium
            }

            MouseArea {
                id: clearAllButtonMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: NotificationService.clearNotifications()
            }
        }


        // ── the list ────────────────────────────────────────────────────────
        ListView {
            id: list
            anchors.fill: parent
            anchors.topMargin: 77
            topMargin: 0
            bottomMargin: 12
            spacing: 0
            clip: true

            model: NotificationService.notifications

            highlightRangeMode: ListView.ApplyRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: height
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 520
            highlightMoveVelocity: -1
            onCountChanged: currentIndex = count - 1
            Component.onCompleted: currentIndex = count - 1

            // First appearance
            populate: Transition {
                SequentialAnimation {
                    PropertyAction { property: "opacity"; value: 0 }
                    PropertyAction { property: "scale"; value: 0.92 }
                    PauseAnimation { duration: Math.max(0, Math.min(ViewTransition.index, 8)) * 45 }

                    ParallelAnimation {
                        NumberAnimation {
                            property: "opacity"
                            to: 1
                            duration: 260
                            easing.type: Easing.OutCubic
                        }

                        NumberAnimation {
                            property: "scale"
                            to: 1
                            duration: 340
                            easing.type: Easing.OutBack
                            easing.overshoot: 1.1
                        }
                    }
                }
            }

            // A newly arrived notification
            add: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 260
                        easing.type: Easing.OutCubic
                    }

                    NumberAnimation {
                        property: "scale"
                        from: 0.9
                        to: 1
                        duration: 340
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.1
                    }
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        to: 0
                        duration: 180
                        easing.type: Easing.InQuad
                    }

                    NumberAnimation {
                        property: "scale"
                        to: 0.9
                        duration: 180
                        easing.type: Easing.InQuad
                    }
                }
            }

            displaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 280
                    easing.type: Easing.OutCubic
                }
            }


            delegate: Item {
                id: notificationCard

                required property var modelData

                // ════════════════ CARD SIZE ════════════════
                readonly property real cardMinHeight: 72    // smallest card height
                readonly property real cardPadding: 0      // space above + below the text
                readonly property real cardGap: 8           // space between two cards
                readonly property real sideMargin: 12       // space left + right of the cards
                readonly property real cardRadius: 14       // corner roundness
                readonly property real iconSize: 40         // app icon / image size
                readonly property real appNameSize: 11      // app name font size
                readonly property real titleSize: 14        // title font size
                readonly property real bodySize: 12         // body font size
                readonly property int  bodyLines: 2         // max lines of body text
                // ═══════════════════════════════════════════




                // Keep a copy of the notification data for the card.
                property var snap: ({ appName: "", summary: "", body: "", image: "", appIcon: "", urgency: 1 })
                Binding {
                    target: notificationCard
                    property: "snap"
                    when: !!notificationCard.modelData
                    restoreMode: Binding.RestoreNone
                    value: notificationCard.modelData ? ({
                        appName: notificationCard.modelData.appName,
                        summary: notificationCard.modelData.summary,
                        body: notificationCard.modelData.body,
                        image: notificationCard.modelData.image,
                        appIcon: notificationCard.modelData.appIcon,
                        urgency: notificationCard.modelData.urgency
                    }) : ({})
                }

                // 0 = low, 1 = normal, 2 = critical
                readonly property color accent: snap.urgency === 2 ? Colors.notificationCriticalColor : snap.urgency === 0 ? Colors.notificationLowColor : Colors.notificationNormalColor
                readonly property string iconSource: snap.image ? snap.image  : snap.appIcon ? Quickshell.iconPath(snap.appIcon, true)  : ""
                readonly property bool hovered: cardMouse.containsMouse || closeMouse.containsMouse

                width: list.width
                height: card.height + cardGap

                function openNotification() {
                    if (modelData) NotificationService.activateNotification(modelData)
                }

                function closeNotification() {
                    if (modelData) modelData.dismiss()
                }


                Timer {
                    id: expireTimer

                    property int timeout: notificationCard.modelData ? notificationCard.modelData.expireTimeout : -1

                    interval: timeout
                    repeat: false
                    running: notificationCard.modelData !== null && notificationCard.modelData !== undefined && timeout !== -1  && timeout !== 0 

                    onTriggered: {
                        notificationCard.closeNotification()
                        // console.log("timeout:" + notificationCard.modelData.expireTimeout)
                        // console.log("running timeout:" + interval)
                    }
                }



                Rectangle {
                    id: card
                    x: notificationCard.sideMargin
                    y: notificationCard.cardGap / 2
                    width: notificationCard.width - notificationCard.sideMargin * 2
                    height: Math.max(notificationCard.cardMinHeight, textColumn.implicitHeight + notificationCard.cardPadding * 2)
                    radius: notificationCard.cardRadius
                    color: Colors.notificationCardColor
                    border.width: 1
                    border.color: notificationCard.hovered ? Colors.notificationBorderHoverColor : Colors.notificationBorderColor
                    Behavior on border.color { ColorAnimation { duration: 180 } }

                    scale: cardMouse.pressed ? 0.985 : 1.0
                    Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

                    // urgency stripe -> (grey = low, accent = normal, red = critical)
                    Rectangle {
                        x: 0
                        y: notificationCard.cardRadius
                        width: 3
                        height: card.height - notificationCard.cardRadius * 2
                        radius: 1.5
                        color: notificationCard.accent
                    }


                    // notification icon / image
                    ClippingRectangle {
                        id: appIcon
                        height: notificationCard.iconSize
                        width: height
                        radius: height * 0.3
                        color: Colors.notificationIconBackgroundColor
                        anchors {
                            left: parent.left
                            leftMargin: 14
                            verticalCenter: parent.verticalCenter
                        }

                        Image {
                            id: appIconImage
                            anchors.fill: parent
                            anchors.margins: notificationCard.snap.image ? 0 : 4
                            source: notificationCard.iconSource
                            sourceSize: Qt.size(96, 96)
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                        }

                        // when no icon: first letter of the app name
                        Text {
                            anchors.centerIn: parent
                            visible: appIconImage.status === Image.Null || appIconImage.status === Image.Error
                            text: notificationCard.snap.appName.charAt(0).toUpperCase()
                            color: Colors.notificationIconTextColor
                            font.pixelSize: notificationCard.iconSize * 0.45
                            font.family: "Quicksand"
                            font.weight: Font.ExtraBold
                        }
                    }


                    // notification text, title, body
                    Column {
                        id: textColumn
                        anchors {
                            left: appIcon.right
                            leftMargin: 12
                            right: parent.right
                            rightMargin: 12
                            verticalCenter: parent.verticalCenter
                        }
                        spacing: 2

                        Text {
                            width: parent.width - 20        // leave room for the × button
                            visible: text !== ""
                            text: notificationCard.snap.appName
                            color: notificationCard.accent
                            font.pixelSize: notificationCard.appNameSize
                            font.family: "Quicksand"
                            font.weight: Font.ExtraBold
                            elide: Text.ElideRight
                        }

                        Text {
                            width: parent.width
                            visible: text !== ""
                            text: notificationCard.snap.summary
                            color: Colors.notificationTitleColor
                            font.pixelSize: notificationCard.titleSize
                            font.family: "Quicksand"
                            font.weight: Font.ExtraBold
                            wrapMode: Text.Wrap
                            maximumLineCount: 2
                            elide: Text.ElideRight
                        }

                        Text {
                            width: parent.width
                            visible: text !== ""
                            text: notificationCard.snap.body
                            color: Colors.notificationBodyColor
                            font.family: "Quicksand"
                            font.weight: Font.Medium
                            font.pixelSize: notificationCard.bodySize
                            wrapMode: Text.Wrap
                            maximumLineCount: notificationCard.bodyLines
                            elide: Text.ElideRight
                        }
                        
                    }


                    // click anywhere on the card (except ×) = open the notification
                    MouseArea {
                        id: cardMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notificationCard.openNotification()
                    }


                    // × button = close the notification (declared last so it sits on top)
                    Item {
                        width: 24
                        height: 24
                        anchors {
                            top: parent.top
                            right: parent.right
                            topMargin: 6
                            rightMargin: 6
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "×"
                            font.pixelSize: 20
                            font.family: "Quicksand"
                            font.weight: Font.ExtraBold
                            color: closeMouse.containsMouse ? Colors.notificationCriticalColor : Colors.notificationCloseIconColor
                        }

                        MouseArea {
                            id: closeMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: notificationCard.closeNotification()
                        }
                    }
                }
            }
        }


        // shown when there are no notifications
        Text {
            anchors.centerIn: parent
            visible: list.count === 0
            text: "All caught up"
            color: Colors.notificationEmptyColor
            font.pixelSize: 15
            font.family: "Quicksand"
            font.weight: Font.ExtraBold
        }

    }

}
