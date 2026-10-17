
import QtQuick
import Quickshell.Io
import "../config"

Item {
    id: root

    implicitWidth: 120
    implicitHeight: 44

    // The currently selected button index
    property int currentIndex: 0

    // Button labels
    property var options: ["󰂅", "󱈏"]

    // Colors
    property color backgroundColor: Colors.batteryCtrlBackgroundColor
    property color activeColor: Colors.batteryCtrlActiveColor
    property color textColor: Colors.batteryCtrlTextColor
    property color activeTextColor: Colors.batteryCtrlActiveTextColor


    Rectangle {
        id: container

        anchors.fill: parent
        radius: height / 2
        color: root.backgroundColor
        clip: true

        Rectangle {
            id: indicator

            width: container.width / root.options.length - 3.8
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

                        font.pixelSize: 20
                        font.bold: root.currentIndex === index

                        Behavior on color {
                            ColorAnimation {
                                duration: 240
                            }
                        }
                    }

                    MouseArea {
                        id: buttonArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            // root.currentIndex = index
                            setbatteryProcess.index = index
                            setbatteryProcess.running = true
                        }
                    }
                }
            }
        }
    }

    Process {
        id: batteryProcess

        command: [
            "/usr/bin/python",
            "/home/titan/.config/quickshell/X2-Shell/scripts/C_runner.py",
            "conservation_mode"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Python output:", text)
                root.currentIndex= text.trim() === "1" ? 1 : 0
            }
        }
    }

    Component.onCompleted: {
        batteryProcess.running = true
    }



    Process {
        id: setbatteryProcess

        running: false

        property int index: 0

        command: [
            "sudo",
            "/usr/bin/python",
            "/home/titan/.config/quickshell/X2-Shell/scripts/C_runner.py",
            "conservation_mode",
            index           
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Python output:", text)
                root.currentIndex= text.trim() === "1" ? 1 : 0
                batteryProcess.running = true

            }
        }
    }

    

 
}
