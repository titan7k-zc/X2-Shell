import QtQuick
import QtQuick.Layouts

import "../config"
import "../services"

Item {
    id: root

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton
        hoverEnabled: true

        onClicked: {
            VolumeService.toggleMute()
        }

        onWheel: wheel => {

            if (!VolumeService.ready)
                return

            if (wheel.angleDelta.y > 0) {
                VolumeService.increaseVolume()
            }
            else if (wheel.angleDelta.y < 0) {
                VolumeService.decreaseVolume()
            }

            wheel.accepted = true
        }

        cursorShape: Qt.PointingHandCursor
    }

    Row {
        id: row

        anchors.centerIn: parent
        spacing: 6

        Text {
            text: VolumeService.icon

            color: Colors.volumeIconColor

            font {
                family: "JetBrainsMono Nerd Font Mono"

                pixelSize:
                    VolumeService.deviceKind === "bluetooth"
                    ? 17
                    : 20

                weight: 600
            }

            anchors.verticalCenter: parent.verticalCenter

            anchors.verticalCenterOffset:
                VolumeService.deviceKind === "bluetooth"
                ? 0
                : 1
        }

        Text {
            text: VolumeService.vol + "%"

            color: Colors.volumeTextColor

            font {
                family: "Quicksand"
                pixelSize: 14
                weight: 600
            }

            anchors.verticalCenter: parent.verticalCenter
        }
    }
}