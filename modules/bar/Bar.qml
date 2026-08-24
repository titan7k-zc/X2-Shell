import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../../config"
import "../../services"
import "../../components"
import "./powerBar/bar_comp"





Scope{
    id:root
    property color borderColor:Colors.sBG
    property int shadowSpace: 12   // extra room so the shadow isn't clipped
    property int rootRadius: 20
    property int lrBarWid: 15
    property int hei: 60
    property int toph: 40
    property real rad:rootRadius

    Variants{
        model:Quickshell.screens

        Item{
            id:screenRoot
            required property var modelData

            // ============================================================
            // Right Bar
            // ============================================================
            PanelWindow{
                id:rightBarWindow
                property int barWidth: root.lrBarWid
                property int radius: root.rootRadius
                property int borderThickness: 0
                color: "transparent"
                anchors.top: true
                anchors.bottom: true
                anchors.right: true
                implicitWidth: borderThickness+barWidth+radius
                exclusiveZone: borderThickness+barWidth
                WlrLayershell.layer:WlrLayer.Top

                Item {
                    id: shape
                    anchors.fill: parent

                    Rectangle{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        width: rightBarWindow.barWidth
                        color: root.borderColor
                    }
                }


                MultiEffect {
                    anchors.fill: shape
                    source: shape

                    shadowEnabled: true
                    shadowBlur: 0.6
                    shadowScale: 1
                    // shadowColor:'#000000'
                    shadowVerticalOffset:0
                    shadowHorizontalOffset: -3
                    opacity: 0.7
                }
            }


            PanelWindow{
                id:fakeBrightness

                WlrLayershell.layer:WlrLayer.Overlay
                screen: screenRoot.modelData

                implicitWidth: screenRoot.modelData.width
                implicitHeight: screenRoot.modelData.height

                exclusiveZone:0
                color:'Transparent'
                property real value:80
                
                property var midMask: Region {
                    item: null
                }
                mask:midMask

                Rectangle{
                    anchors.fill:parent
                    color:'#000000'
                    opacity: Math.min(Math.max((100 - fakeBrightness.value) / 100, 0), 0.9)

                }
            }


            // ============================================================
            // Left Bar
            // ============================================================
            PanelWindow{
                id:leftBarWindow
                property int barWidth: root.lrBarWid
                property int radius: root.rootRadius
                color: "transparent"
                anchors.top: true
                anchors.bottom: true
                anchors.left: true
                implicitWidth: barWidth+radius
                exclusiveZone: barWidth

                Item {
                    id: shape2
                    anchors.fill: parent

                    Rectangle{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        width: leftBarWindow.barWidth
                        color: root.borderColor
                        z:1
                    }
                }

                // shadow
                 MultiEffect {
                    anchors.fill: shape2
                    source: shape2

                    shadowEnabled: true
                    shadowBlur: 0.6
                    shadowScale: 1
                    // shadowColor:'#000000'
                    shadowVerticalOffset:0
                    shadowHorizontalOffset: 3
                    opacity: 0.7
                }
            }


            // ============================================================
            // Top Left, Right bars
            // ============================================================
            PanelWindow {
                id: topbar

                WlrLayershell.layer: WlrLayer.Top

                anchors {
                    top: true
                    left: true
                    right: true
                    
                }
                
                exclusiveZone: root.toph   // handles reserved space

                color: "transparent"
                
                // margins.top: -root.toph

                implicitHeight: root.hei

                LeftTopB {
                    id: leftB

                    rad:root.rad

                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                }

                RightTopB {
                    id: rightB

                    rad:root.rad

                    anchors {
                        right: parent.right
                        top: parent.top
                    }
                }
            }
            // ============================================================
            // Bottom Left ,Right bars
            // ============================================================
            PanelWindow {
                id: bottomBar

                WlrLayershell.layer: WlrLayer.Top

                anchors {
                    bottom: true
                    left: true
                    right: true
                    
                }
                
                exclusiveZone: root.toph   // handles reserved space

                color: "Transparent"
                
                // margins.top: -root.toph

                implicitHeight: root.hei

                LeftBottomB {
                    id: leftBot

                    rad:root.rad

                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                    }
                }

                RightBottomB {
                    id: rightBot

                    rad:root.rad

                    anchors {
                        right: parent.right
                        bottom: parent.bottom
                    }
                }
            }

            // ============================================================
            // MIDDLE POPUP
            // ============================================================
            PanelWindow {
                id: midpop

                color: "transparent"

                anchors {
                    top: true
                    right: true
                    left: true
                    bottom: true
                }

                WlrLayershell.layer:mb.clic?WlrLayer.Overlay: WlrLayer.Top
                WlrLayershell.keyboardFocus: mb.clic ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

                exclusiveZone: 0

                margins.top: -root.toph

                property var midMask: Region {
                    item: mb
                }

                mask: midMask

                MidTopB {
                    id: mb

                    anchors.horizontalCenter: parent.horizontalCenter
                    openRad:root.rad+(root.rad/2)
                    closeRed:{
                        if (root.rad<22){
                            return root.rad
                        }else{
                            return 22
                        }
                    }
                }
            }

            // ============================================================
            // Popup close Handler
            // ============================================================

            // temp: disabled because esc handles  close so no need outside click close

            // PanelWindow {
            //     id: closePopsArea

            //     screen: screenRoot.modelData

            //     WlrLayershell.layer: WlrLayer.Top

            //     implicitWidth: screenRoot.modelData.width
            //     implicitHeight: screenRoot.modelData.height

            //     color:'Transparent'
            //     // color:'#26ff0000'  // for debug


            //     property bool popEnabled: mb.clic || ipch.powerPop  // activator
            //     property var popItem

            //     property var tMask: Region {
            //         item: null
            //     }

            //     mask: popEnabled ? null : tMask

            //     MouseArea {
            //         anchors.fill: parent
            //         enabled: closePopsArea.popEnabled


            //         // close
            //         onClicked: {
            //             mb.clic = false
            //             ipch.powerPop=false
            //             console.log("closed from 'closePopsArea'")
            //         }
            //     }
            // }



            // ============================================================
            // Popups Handler
            // ============================================================

            Pop8{
                id:right_power_pop
                show:false
                anchorRight:true

                rad:20
                
                file:"../modules/powerMenu/PowerMenu.qml"

                
                IpcHandler {
                    target: "power"
                    function toggle() {
                        right_power_pop.show=!right_power_pop.show;
                    }

                }
            }


        }
    }


}