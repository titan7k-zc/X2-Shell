
import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower
import "../config"

Item {
    id: root

    implicitWidth: 320
    implicitHeight: 44

    // The currently selected button index
    property int currentIndex: 0

    // Button labels
    property var options: ["", "󰾅", "", "󰈸", ""]

    // Colors
    property color backgroundColor: Colors.performanceCtrlBackgroundColor
    property color activeColor: Colors.performanceCtrlActiveColor
    property color textColor: Colors.performanceCtrlTextColor
    property color activeTextColor: Colors.performanceCtrlActiveTextColor


    // charger connected or not
    property bool isChargerConnected: !UPower.onBattery


    Rectangle {
        id: container

        anchors.fill: parent
        radius: height / 2  
        color: root.backgroundColor
        clip: true

        Rectangle {
            id: indicator

            width: container.width / root.options.length - 1.8
            height: container.height - 8
            y: 4
            x: 4 + root.currentIndex * width
 
            radius: container.radius - 4
            color: root.activeColor
            

            Behavior on x {
                NumberAnimation {
                    duration: 340
                    easing.type: Easing.OutBack
                    easing.overshoot: 0.5
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration: 220
                    easing.type: Easing.OutCubic
                }
            }
        }

        Row {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 0

            Repeater {
                model: root.options

                delegate: Item {
                    required property int index
                    required property string modelData

                    width: (container.width - 8) / root.options.length
                    height: container.height - 8

                    scale: buttonArea.pressed ? 0.94 : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: 160
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: root.currentIndex === index ? root.activeTextColor : root.textColor
                        opacity: root.isChargerConnected? 1.0 : (index >=2? 0.4 : 1.0)

                        font.pixelSize: 20
                        font.bold: root.currentIndex === index

                        Behavior on color {
                            ColorAnimation {
                                duration: 240
                            }
                        }
                        Behavior on opacity {
                            NumberAnimation {
                                duration: 240
                            }
                        }
                    }

                    MouseArea {
                        id: buttonArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            setprofileProcess.index = index
                            setprofileProcess.running = true
                        }
                    }
                }
            }
        }
    }



    function profileToIndex(profile) {
        switch (profile.trim()) {
        case "low-power":  return 0
        case "balanced":   return 1
        case "performance": return 2
        case "max-power":  return 3
        case "custom":     return 4
        default:           return -1
        }
    }

    Process {
        id: profileProcess

        command: [
            "/usr/bin/python",
            "/home/titan/.config/quickshell/X2-Shell/scripts/C_runner.py",
            "platform_profile"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const index = root.profileToIndex(text)
                if (index !== -1)
                    root.currentIndex = index
            }
        }
    }
 
 
    Component.onCompleted:{
        profileProcess.running=true
    }


    Process {
        id: setprofileProcess

        running: false

        property int index: 0

        property string profile: [
            "low-power",
            "balanced",
            "performance",
            "max-power",
            "custom"
        ][index]

        command: [
            "sudo",
            "/usr/bin/python",
            "/home/titan/.config/quickshell/X2-Shell/scripts/C_runner.py",
            "platform_profile",
            profile
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                // const index = root.profileToIndex(text)
                // if (index !== -1)
                //     root.currentIndex = index
            }
        }

        onExited: profileProcess.running = true
    }

}
 