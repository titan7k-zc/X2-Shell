import QtQuick
import Quickshell
import QtQuick.Shapes
import QtQuick.Effects

import "../../../../config"
import "../../../../components"
import "../../../../services"
import "../../../pops"

Item {
    id: root
    implicitWidth: rightB.wid
    implicitHeight: rightB.hei + rightB.rad
    required property real rad

    Shape {
        id: rightB
        property int hei: 40
        property int wid: 650
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp
            strokeColor: "transparent"
            fillColor: Theme.bar_bg

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
        // shadowColor:'#000000'
        shadowVerticalOffset:-3
        shadowHorizontalOffset: -2
        opacity: 0.7
    }



    Row{
        anchors.centerIn:parent
        anchors.verticalCenterOffset:12
        spacing:20

        Rectangle{
            implicitHeight:row_cpu.implicitHeight+(row_cpu.implicitHeight/5)
            implicitWidth:row_cpu.implicitWidth+(row_cpu.implicitWidth/5)
            color:'Transparent'
            radius:8

            Row{
                id:row_cpu
                spacing:10
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-1

                Rou_Indicator {
                    height: 30
                    hi_off: -2.55
                    vi_off: 0.1
                    scale:1
                    width: height 
                    value: SysMon.cpuUsage
                    ic: ""
                    i_scl:1.3
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: 0.3
                    vi_off: -0.2
                    scale:1
                    width: height 
                    value: SysMon.cpuTemp
                    ic: ""
                    i_scl:1.4
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
            }

            MouseArea {
                id: cpuMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Quickshell.execDetached(["kitty", "-e", "btop"])
                }
            }
            scale: cpuMouseArea.pressed ? 0.92 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }

        }
        Rectangle{
            implicitHeight:row_gpu.implicitHeight+(row_gpu.implicitHeight/5)
            implicitWidth:row_gpu.implicitWidth+(row_gpu.implicitWidth/5)
            anchors.verticalCenter:parent.verticalCenter
            color:'Transparent'
            radius:8
        
            Row{
                id:row_gpu
                spacing:10
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-1

                Rou_Indicator {
                    height: 30
                    hi_off: -2.1
                    vi_off: -0.1
                    scale:1
                    i_scl:1.5
                    width: height 
                    value:SysMon.gpuUsage
                    ic: "󰊹"
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: 0.3
                    vi_off: -0.2
                    scale:1
                    i_scl:1.4
                    width: height 
                    value: SysMon.gpuTemp
                    ic: ""
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
            }


            MouseArea {
                id: gpuMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Quickshell.execDetached(["kitty", "-e", "nvtop"]) 
                }
            }
            scale: gpuMouseArea.pressed ? 0.92 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }

        }
        Rectangle{
            implicitHeight:row_mem.implicitHeight+(row_mem.implicitHeight/5)
            implicitWidth:row_mem.implicitWidth+(row_mem.implicitWidth/5)
            anchors.verticalCenter:parent.verticalCenter
            color:'Transparent'
            radius:8
            Row{
                id:row_mem
                spacing:10
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-1

                Rou_Indicator {
                    height: 30
                    hi_off: -1.3
                    vi_off: -0.1
                    scale:1
                    i_scl:1.4
                    width: height 
                    value: SysMon.storageUsage
                    ic: ""
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: -2.5
                    vi_off: -0.2
                    scale:1
                    width: height 
                    value: SysMon.ramUsage
                    ic: ""
                    igColor: Theme.ic_s
                    icColor: Theme.ic_n
                    // trackColor:"gray"
                }
            }

            MouseArea {
                id: memMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Quickshell.execDetached([
                        "kitty",
                        "-e",
                        "bash",
                        "-c",
                        "watch -n 1 'df -h; echo; cat /proc/meminfo'"
                    ])
                }
            }
            scale: memMouseArea.pressed ? 0.92 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }
        }
        Rectangle{
            implicitHeight:row_net.implicitHeight+(row_net.implicitHeight/5)
            implicitWidth:row_net.implicitWidth+(row_net.implicitWidth/5)
            anchors.verticalCenter:parent.verticalCenter
            color:'Transparent'
            radius:8
            Row{
                id:row_net
                spacing:10
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-1

                Text {
                    text: {
                        const speed = SysMon.downloadSpeed

                        if (speed < 1024 * 1024)
                            return "  " + (speed / 1024).toFixed(1) + " KB/s"
                        else
                            return "  " + (speed / (1024 * 1024)).toFixed(2) + " MB/s"
                    }
                    color: Theme.ic_n
                    font.pixelSize:15
                }

                Text {
                    text: {
                        const speed = SysMon.uploadSpeed

                        if (speed < 1024 * 1024)
                            return "  " + (speed / 1024).toFixed(1) + " KB/s"
                        else
                            return "  " + (speed / (1024 * 1024)).toFixed(2) + " MB/s"
                    }
                    color: Theme.ic_n
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
            color:'Transparent'
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
                    color: Theme.ic_n
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
                    text: SysMon.uptimeString
                    color: Theme.ic_n
                }

            }


            MainMP{
                id:right_power_pop
                show:false
                anchorRight:true

                rad:root.rad

            }


            MouseArea{
                anchors.fill:row_up
                onClicked: {
                    right_power_pop.show=!right_power_pop.show
                }
            }
        }

        

    }

}


