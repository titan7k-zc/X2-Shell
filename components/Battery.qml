import QtQuick
import Quickshell.Services.UPower
import Quickshell
import "../config"
import "../services"

Row {
    id: root

    spacing:6
    anchors.centerIn: parent
    anchors.verticalCenterOffset: 1

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)
    readonly property string icon: {
        if (charging)
            return String.fromCodePoint(0xF0084);

        if (level >= 100)
            return String.fromCodePoint(0xF0079);

        if (level < 10)
            return String.fromCodePoint(0xF0083);

        return String.fromCodePoint(0xF007A + (Math.floor(level / 10) - 1));
    }



    Text {
        id: batteryIcon

        text: root.icon
        color: Colors.batteryIconColor

        font {
            family: "JetBrainsMono Nerd Font Propo"
            letterSpacing: 0
            pixelSize: 14
            weight: 600
        }

        SequentialAnimation on opacity {
            running: root.level <= 35 && !root.charging
            loops: Animation.Infinite

            NumberAnimation {
                to: 0.2
                duration: 500
                easing.type: Easing.InOutSine
            }

            NumberAnimation {
                to: 1.0
                duration: 500
                easing.type: Easing.InOutSine
            }

            onRunningChanged: {
                if (!running)
                    batteryIcon.opacity = 1.0
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }




    Text {
        text: root.level+"%"
        color: Colors.batteryTextColor



        font {
            family: "Quicksand"
            letterSpacing: 0
            pixelSize: 14
            weight: 600
        }
    }


    // property bool lowBatteryNotified: false

    // onLevelChanged: {
    //     if (level <= 35 && !charging && root.lowBatteryNotified != true) {
    //         Quickshell.execDetached(["notify-send", "-a", "X2-Shell", "-u", "critical", "Low Battery", "Battery is low. Please charge.."])
    //         // Quickshell.execDetached(["notify-send", "-a", "X2-Shell", "-u", "critical", "-t", "50000", "Battery", "Low Battery.. please charge.."])
    //         lowBatteryNotified = true
    //     }
    // }

    // onChargingChanged:{
    //     if (charging){
    //         NotificationService.clearNotification("X2-Shell", "Low Battery")    
    //         root.lowBatteryNotified = false

    //     }
    // }

    property bool lowBatteryNotified: false

    onLevelChanged: {
        if (level <= 35 && !charging && !lowBatteryNotified) {
            lowBatteryNotified = true

            Quickshell.execDetached([
                "notify-send",
                "-a", "X2-Shell",
                "-u", "critical",
                "Low Battery",
                "Battery is low. Please charge."
            ])
        }

        // Reset only after the battery rises above the threshold.
        if (level > 35) {
            lowBatteryNotified = false
        }
    }

    onChargingChanged: {
        if (charging) {
            NotificationService.clearNotification("X2-Shell", "Low Battery")
        }
    }




   
}
