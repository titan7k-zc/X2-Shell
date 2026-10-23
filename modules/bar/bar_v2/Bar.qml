import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../../../config"
import "../../../components"
import "../bar_comp2"


Scope{
    id:root
    property color borderColor: Colors.barBorderColor
    property real rootRadius: 17.5  // max 'tbHei/2' min 0
    property int screenCorners: 10//rootRadius/3  
    property int lrBarWid: 15
    property int topCBarWid: 240
    property int bottomCBarWid: 640
    property int tbHei: 35 // Main visible top,bottom bar height
    property int hei: tbHei+(tbHei/3.5) //Total height for top/bottom PanelWindow



    property int conHei: 5 //  connectors height  (max 5)
    property real conHeiMar: 0//-(conHei-0.8) //  hei Margin..

    Variants{
        model:Quickshell.screens

        Item{
            id:screenRoot
            required property var modelData


            // ============================================================
            // Top bars
            // ============================================================
            PanelWindow {
                id: topbar

                WlrLayershell.layer: WlrLayer.Top

                anchors {
                    top: true
                    left: true
                    right: true
                    
                }
                
                exclusiveZone: root.tbHei   // handles reserved space

                color: Colors.barBackgroundColor
                

                implicitHeight: root.hei

                

                TopB{
                    id: topB
                    z:1
                    
                    rad:root.rootRadius
                    wid:root.bottomCBarWid*2-(rootRadius*2)
                    hei:root.tbHei

                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                LeftTopB {
                    id: leftB
                    z:1
                    rad:root.rootRadius
                    se:root.screenCorners
                    wid:root.topCBarWid
                    hei:root.tbHei

                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                }

                RightTopB {
                    id: rightB
                    z:1
                    rad:root.rootRadius
                    se:root.screenCorners
                    wid:root.topCBarWid
                    hei:root.tbHei

                    anchors {
                        right: parent.right
                        top: parent.top
                    }
                }

  

                // ===top bar connector===
                Rectangle{
                    id: topConnectorBar1
                    z:2
                    anchors {
                        top: parent.top
                        left:leftB.right
                        right:topB.left
                        topMargin:root.conHeiMar
                    }
                    
                    height: root.conHei
                    color:root.borderColor

                    Curves{
                        anchors.top: parent.bottom
                        anchors.left: parent.left
                        radius: root.rootRadius
                        isTop: true
                        color: root.borderColor
                        z: 10
                    }
                    Curves{
                        anchors.top: parent.bottom
                        anchors.right: parent.right
                        radius: root.rootRadius
                        isTop: true
                        color: root.borderColor
                        mirrored: true
                        z: 10
                    }




                }
                // Shadow
                MultiEffect {
                    anchors.fill: topConnectorBar1

                    opacity: Colors.barV2ShadowOpacity
                    shadowColor: Colors.barV2ShadowColor

                    source: topConnectorBar1

                    shadowEnabled: true
                    shadowBlur: 0.5
                    shadowScale: 0.998

                    shadowVerticalOffset: 3
                    shadowHorizontalOffset: 0
                }
                Rectangle{
                    id: topConnectorBar2
                    z:2
                    anchors {
                        top: parent.top
                        left:topB.right
                        right:rightB.left
                        topMargin:root.conHeiMar
                    }
                    
                    height: root.conHei
                    color:root.borderColor

                    Curves{
                        anchors.top: parent.bottom
                        anchors.left: parent.left
                        radius: root.rootRadius
                        isTop: true
                        color: root.borderColor
                        z: 10
                    }
                    Curves{
                        anchors.top: parent.bottom
                        anchors.right: parent.right
                        radius: root.rootRadius
                        isTop: true
                        color: root.borderColor
                        mirrored: true
                        z: 10
                    }

                    

                }
                // Shadow
                MultiEffect {
                    anchors.fill: topConnectorBar2

                    opacity: Colors.barV2ShadowOpacity
                    shadowColor: Colors.barV2ShadowColor

                    source: topConnectorBar2

                    shadowEnabled: true
                    shadowBlur: 0.5
                    shadowScale: 0.998

                    shadowVerticalOffset: 3
                    shadowHorizontalOffset: 0
                }


            }
            // ============================================================
            // Bottom bars
            // ============================================================
            PanelWindow {
                id: bottomBar

                WlrLayershell.layer: WlrLayer.Top

                anchors {
                    bottom: true
                    left: true
                    right: true
                    
                }
                
                exclusiveZone: root.tbHei   // handles reserved space

                color: Colors.barBackgroundColor
                
                // margins.top: -root.tbHei

                implicitHeight: root.hei
                

                LeftBottomB {
                    id: leftBot
                    z:1
                    rad:root.rootRadius
                    se:root.screenCorners
                    wid:root.bottomCBarWid
                    hei:root.tbHei
                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                    }
                }
 
                RightBottomB {
                    id: rightBot
                    z:1
                    rad:root.rootRadius
                    se:root.screenCorners
                    wid:root.bottomCBarWid
                    hei:root.tbHei
                    anchors {
                        right: parent.right
                        bottom: parent.bottom
                    }
                }


                //===bottom bar connector===
                Rectangle{
                    id: bottomConnectorBar
                    z:2
                    height: root.conHei
                    color:root.borderColor
                    anchors {
                        bottom: parent.bottom
                        left:leftBot.right
                        right:rightBot.left
                        bottomMargin:root.conHeiMar
                    }

                    Curves{
                        anchors.bottom: parent.top
                        anchors.left: parent.left
                        radius: root.rootRadius
                        isTop: false
                        color: root.borderColor
                        z: 10
                    }
                    Curves{
                        anchors.bottom: parent.top
                        anchors.right: parent.right
                        radius: root.rootRadius
                        isTop: false
                        color: root.borderColor
                        mirrored: true
                        z: 10
                    }
                    

                }
                // Shadow
                MultiEffect {
                    anchors.fill: bottomConnectorBar

                    opacity: Colors.barV2ShadowOpacity
                    shadowColor: Colors.barV2ShadowColor

                    source: bottomConnectorBar

                    shadowEnabled: true
                    shadowBlur: 0.5
                    shadowScale: 0.998

                    shadowVerticalOffset: -3
                    shadowHorizontalOffset: 0
                }



                // open control center when notification when button is clicked
                Connections {
                    target: rightBot

                    function onNotificationClicked() {
                        right_bottom_power_pop.show = !right_bottom_power_pop.show
                    }
                }
                




            }


            // ============================================================
            // Right Bar
            // ============================================================
            PanelWindow{
                id:rightBarWindow
                property int barWidth: root.lrBarWid
                property int radius: root.rootRadius
                property int borderThickness: 0
                property color borderColor: root.borderColor
                color: Colors.barBackgroundColor
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


                        Curves{
                            anchors.top: parent.top
                            anchors.right: parent.left
                            radius: root.rootRadius
                            isTop: true
                            color: root.borderColor
                            mirrored: true
                            z: 10
                        }
                        Curves{
                            anchors.bottom: parent.bottom
                            anchors.right: parent.left
                            radius: root.rootRadius
                            isTop: false
                            mirrored: true
                            color: root.borderColor
                            z: 10
                        }
                    }
                    
                }


                 MultiEffect {
                    opacity: Colors.barV2ShadowOpacity
                    shadowColor: Colors.barV2ShadowColor
                    anchors.fill: shape
                    source: shape

                    shadowEnabled: true
                    shadowBlur: 0.6
                    shadowScale: 0.998
                    shadowVerticalOffset:0
                    shadowHorizontalOffset: -3
                    
                }
            }
            // ============================================================
            // Left Bar
            // ============================================================
            PanelWindow{
                id:leftBarWindow
                property int barWidth: root.lrBarWid
                property int radius: root.rootRadius
                color: Colors.barBackgroundColor
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

                    Curves{
                        anchors.top: parent.top
                        anchors.left: parent.right
                        radius: root.rootRadius
                        isTop: true
                        color: root.borderColor
                        z: 10
                    }
                    Curves{
                        anchors.bottom: parent.bottom
                        anchors.left: parent.right
                        radius: root.rootRadius
                        isTop: false
                        color: root.borderColor
                        z: 10
                    }
                    }

                    
                }

                 MultiEffect {
                    opacity: Colors.barV2ShadowOpacity
                    shadowColor: Colors.barV2ShadowColor
                    anchors.fill: shape2
                    source: shape2

                    shadowEnabled: true
                    shadowBlur: 0.6
                    shadowScale: 0.998
                    shadowVerticalOffset: 0
                    shadowHorizontalOffset: 3
                    
                }
            }
 


            // ============================================================
            // POPUPS
            // ============================================================
            


            Pop8{
                id:right_bottom_power_pop
                show:false
                anchorRight:true
                // anchorBottom:true

                rad:root.rootRadius
                
                file:"../modules/controlCenter/ControlCenter.qml"//"../modules/bluetooth/BluetoothPanel.qml" 
                
                
                IpcHandler {
                    target: "bluetooth"
                    function toggle() {
                        right_bottom_power_pop.show=!right_bottom_power_pop.show;
                    }

                }
            }
            Pop8{
                id:right_power_pop
                show:false
                // anchorRight:true
                // anchorBottom:true
                anchorLeft:true
                anchorTop:true

                rad:root.rootRadius
                
                file:"../modules/powerMenu/PowerMenu.qml"
                
                IpcHandler {
                    target: "power"
                    function toggle() {
                        right_power_pop.show=!right_power_pop.show;
                    }

                }
            }


            Pop8{
                id:left_wall_pop
                show:false
                anchorLeft:true
                
                unloadOnClose:true

                rad:root.rootRadius
                
                file:"../modules/wallTheme/WallpaperAndThemeSwitcher.qml"

                
                IpcHandler {
                    target: "wall"
                    function toggle() {
                        left_wall_pop.show=!left_wall_pop.show;
                    }

                }
            }


            Component.onCompleted: {
                Controls.allowedWindows = [
                    topbar,
                    bottomBar,
                    leftBarWindow,
                    rightBarWindow
                ]
            }



            // PanelWindow {
            //     id: midpop

            //     color: "Transparent"

            //     anchors {
            //         top: true
            //         right: true
            //         left: true
            //         bottom: true
            //     }

            //     WlrLayershell.layer:mb.clic?WlrLayer.Overlay: WlrLayer.Top
            //     WlrLayershell.keyboardFocus: mb.clic ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

            //     exclusiveZone: 0

            //     margins.top: -root.tbHei

            //     property var midMask: Region {
            //         item: mb
            //     }

            //     mask: midMask

            //     // MidTopB {
            //     //     id: mb

            //     //     anchors.horizontalCenter: parent.horizontalCenter
            //     //     openRad:root.rootRadius+(root.rootRadius/2)
            //     //     closeRed:{
            //     //         if (root.rootRadius<22){
            //     //             return root.rootRadius
            //     //         }else{
            //     //             return 22
            //     //         }
            //     //     }
            //     // }
            // }
        }
    }

}
