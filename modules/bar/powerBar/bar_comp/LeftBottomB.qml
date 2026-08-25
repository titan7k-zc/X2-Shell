import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import "../../../../config"
import "../../../../components"
import "../../../../services"


Item {
    id: root
    implicitWidth: leftB.wid
    implicitHeight: leftB.hei + leftB.rad
    required property real rad

    Shape {
        id: leftB

        property int hei: 40
        property int wid: 350
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp

            strokeColor: "transparent"
            fillColor: Colors.sBG

            startX: 0
            startY: leftB.hei + leftB.rad

            // bottom-right (mirrors: top-right)
            PathLine {
                x: leftB.wid
                y: leftB.hei + leftB.rad
            }

            // right side (mirrors: right side)
            PathLine {
                x: leftB.wid
                y: leftB.rad * 2
            }

            // top-right rounded corner (mirrors: bottom-right rounded corner)
            PathArc {
                x: leftB.wid - leftB.rad
                y: leftB.rad
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Counterclockwise
            }

            // top (mirrors: bottom)
            PathLine {
                x: leftB.rad
                y: leftB.rad
            }

            // top-left rounded extension (mirrors: bottom-left rounded extension)
            PathArc {
                x: 0
                y: 0
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Clockwise
            }

            // left side (mirrors: left side)
            PathLine {
                x: 0
                y: leftB.hei + leftB.rad
            }
        }
    }

    MultiEffect {
        anchors.fill: leftB
        source: leftB

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        // shadowColor:'#000000'
        shadowVerticalOffset:-3
        shadowHorizontalOffset: 2
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
                    value: SystemMonitor.cpuUsage
                    ic: ""
                    i_scl:1.3
                    igColor: Colors.iActive
                    icColor: Colors.iMain
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: 0.3
                    vi_off: -0.2
                    scale:1
                    width: height 
                    value: SystemMonitor.cpuTemp
                    ic: ""
                    i_scl:1.4
                    igColor: Colors.iActive
                    icColor: Colors.iMain
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
                    value:SystemMonitor.gpuUsage
                    ic: "󰊹"
                    igColor: Colors.iActive
                    icColor: Colors.iMain
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: 0.3
                    vi_off: -0.2
                    scale:1
                    i_scl:1.4
                    width: height 
                    value: SystemMonitor.gpuTemp
                    ic: ""
                    igColor: Colors.iActive
                    icColor: Colors.iMain
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
                    value: SystemMonitor.storageUsage
                    ic: ""
                    igColor: Colors.iActive
                    icColor: Colors.iMain
                    // trackColor:"gray"
                }
                Rou_Indicator {
                    height: 30
                    hi_off: -2.5
                    vi_off: -0.2
                    scale:1
                    width: height 
                    value: SystemMonitor.ramUsage
                    ic: ""
                    igColor: Colors.iActive
                    icColor: Colors.iMain
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









    }

}