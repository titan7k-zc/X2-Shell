import QtQuick
import Quickshell
import Quickshell.Widgets

import "../../services"
import "../../config"

ListView {
    id: root

    width: 320
    height: 40

    orientation: ListView.Horizontal

    // spacing: 6

    clip: true

    boundsBehavior: Flickable.StopAtBounds

    model: TaskbarService.windows

    // Currently hovered window title
    property string hoveredTitle: ""

    Text {
        id: desktopText

        visible: opacity !== 0
        color: Colors.clockTextColor
        text: "[ Desktop ]"
        anchors.centerIn: parent

        opacity: root.count === 0 ? 1 : 0
        scale: root.count === 0 ? 1 : 0.85

        Behavior on opacity {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutBack
            }
        }
    }

    delegate: Item {
        id: entry

        required property var modelData

        width: 36 + 6
        height: 36

        readonly property bool isActive: modelData.activated

        readonly property var desktopEntry: {
            // re-run whenever DesktopEntries' list changes, not just once
            void DesktopEntries.applications.values.length;
            return DesktopEntries.heuristicLookup(modelData.appId);
        }

        IconImage {
            id: icon

            anchors.fill: parent
            anchors.margins: 4

            asynchronous: true

            source: Quickshell.iconPath(entry.desktopEntry?.icon ?? "", "image-missing")
        }

        Rectangle {
            visible: entry.isActive
            height: 4
            width: height * 4
            radius: 2
            color: Colors.activeColor

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -2
        }

        HoverHandler {
            onHoveredChanged: {
                // console.log("root count : " + root.count)
                if (hovered) {
                    root.hoveredTitle = entry.modelData.title;
                } else if (root.hoveredTitle === entry.modelData.title) {
                    root.hoveredTitle = "";
                }
            }
        }

        TapHandler {
            onTapped: {
                clickAnimation.restart();
                TaskbarService.activate(entry.modelData);
            }
        }

        SequentialAnimation {
            id: clickAnimation

            NumberAnimation {
                target: entry
                property: "scale"
                to: 0.82
                duration: 60
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: entry
                property: "scale"
                to: 1.0
                duration: 100
                easing.type: Easing.OutBack
            }
        }
    }
}