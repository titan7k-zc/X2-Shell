import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import "../../config"
import "../../components"
import "../pops"
import "./powerBar"




Scope{
    id:root
    property color borderColor:Theme.bar_bg
    property int shadowSpace: 12   // extra room so the shadow isn't clipped
    property int rootRadius: 20
    property int lrBarWid: 15

    Variants{
        model:Quickshell.screens

        Item{
            id:screenRoot
            required property var modelData

            // right bar
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

                // // shadow
                // MultiEffect {
                //     anchors.fill: shape
                //     source: shape
                //     shadowEnabled: true
                //     shadowBlur: 1.0
                //     shadowScale: 1
                //     shadowVerticalOffset: 6
                //     shadowHorizontalOffset: 0
                //     opacity: 0.6
                // }


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


            // left bar
            // left bar
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

            // topbar    
            TopBotB{
                rad:root.rootRadius
            }
            
        }
    }


}