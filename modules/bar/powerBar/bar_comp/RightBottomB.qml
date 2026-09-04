import QtQuick
import Quickshell
import QtQuick.Shapes
import QtQuick.Effects

import "../../../../config"

import "../../../../services"

Item {
    id: root
    implicitWidth: rightB.wid
    implicitHeight: rightB.hei + rightB.rad
    required property real rad


    Shape {
        id: rightB
        property int hei: 40
        property int wid: 350
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp
            strokeColor: Colors.powerBarTransparentColor
            fillColor: Colors.powerBarBackgroundColor

            startX: 0
            startY: rightB.hei + rightB.rad

            // bottom-right (mirrors: top-right)
            PathLine {
                x: rightB.wid
                y: rightB.hei + rightB.rad
            }

            // right side (extends up for the right-side wing)
            PathLine {
                x: rightB.wid
                y: 0
            }

            // top-right rounded extension (mirrors: bottom-right rounded extension)
            PathArc {
                x: rightB.wid - rightB.rad
                y: rightB.rad
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Clockwise // flipped from Counterclockwise
            }

            // top
            PathLine {
                x: rightB.rad
                y: rightB.rad
            }

            // top-left rounded corner (mirrors: bottom-left rounded corner)
            PathArc {
                x: 0
                y: rightB.rad * 2
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Counterclockwise // flipped from Clockwise
            }

            // left side
            PathLine {
                x: 0
                y: rightB.hei + rightB.rad
            }
        }
    }

    MultiEffect {
        anchors.fill: rightB
        source: rightB

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        shadowVerticalOffset:-3
        shadowHorizontalOffset: -2
        opacity: 0.7
    }



    Row{
        anchors.centerIn:parent
        anchors.verticalCenterOffset:12
        spacing:20


        Rectangle{
            implicitHeight:row_net.implicitHeight+(row_net.implicitHeight/5)
            implicitWidth:row_net.implicitWidth+(row_net.implicitWidth/5)
            anchors.verticalCenter:parent.verticalCenter
            color: Colors.powerBarTransparentColor
            radius:8
            Row{
                id:row_net
                spacing:10
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-1

                Text {
                    text: {
                        const speed = SystemMonitor.downloadSpeed

                        if (speed < 1024 * 1024)
                            return "  " + (speed / 1024).toFixed(1) + " KB/s"
                        else
                            return "  " + (speed / (1024 * 1024)).toFixed(2) + " MB/s"
                    }
                    color: Colors.powerBarIconColor
                    font.pixelSize:15
                }

                Text {
                    text: {
                        const speed = SystemMonitor.uploadSpeed

                        if (speed < 1024 * 1024)
                            return "  " + (speed / 1024).toFixed(1) + " KB/s"
                        else
                            return "  " + (speed / (1024 * 1024)).toFixed(2) + " MB/s"
                    }
                    color: Colors.powerBarIconColor
                    font.pixelSize:15
                }
            }



            MouseArea {
                id: netMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Quickshell.execDetached(["kitty", "-e", "nethogs"]) 
                }
            }
            scale: netMouseArea.pressed ? 0.92 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }
        }
        Rectangle{
            implicitHeight:row_up.implicitHeight+(row_up.implicitHeight/5)
            implicitWidth:row_up.implicitWidth+(row_up.implicitWidth/5)
            anchors.verticalCenter:parent.verticalCenter
            color: Colors.powerBarTransparentColor
            radius:8
            Row {
                id: row_up
                spacing: 10
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -1

                Text {
                    id: uptimeIcon
                    property var ico:["","󱤌","","󰹻",]
                    text: ico[1]
                    color: Colors.powerBarActiveColor
                    font.pixelSize:20

                    RotationAnimation {
                        target: uptimeIcon
                        from: 0
                        to: 360
                        duration: 5000
                        loops: Animation.Infinite
                        running: true
                    }
                }

                Text {
                    anchors.verticalCenter: uptimeIcon.verticalCenter
                    anchors.verticalCenterOffset:1
                    text: SystemMonitor.uptimeString
                    color: Colors.powerBarIconColor
                }

            }



        }

        

    }


}


