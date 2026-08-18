import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import "../config"
import "../components"




Scope{
    id:root
    property int thickness:20
    property color borderColor:Theme.bar_bg
    property int shadowSpace: 12   // extra room so the shadow isn't clipped

    Variants{
        model:Quickshell.screens

        Item{
            id:screenRoot
            required property var modelData


            // topbar    
            PanelWindow{
                id:topBarWindow
                property int barWidth: 40
                screen:screenRoot.modelData
                anchors{top:true;left:true;right:true}
                implicitHeight:topBarWindow.barWidth + root.shadowSpace
                exclusiveZone:topBarWindow.barWidth
                WlrLayershell.layer:WlrLayer.Top
                WlrLayershell.namespace:"quickshell_border_top"
                color:"transparent"

                Rectangle{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: topBarWindow.barWidth
                    color: root.borderColor

                    layer.enabled: true
                    layer.effect: MultiEffect{
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowOpacity: 0.5
                        shadowBlur: 0.6
                        shadowHorizontalOffset: 0
                        shadowVerticalOffset: 2
                    }
                }
            }


            // bottombar
            PanelWindow{
                id:bottomBarWindow
                property int barWidth: 5
                screen:screenRoot.modelData
                anchors{bottom:true;left:true;right:true}
                implicitHeight:bottomBarWindow.barWidth + root.shadowSpace
                exclusiveZone:bottomBarWindow.barWidth
                WlrLayershell.layer:WlrLayer.Top
                WlrLayershell.namespace:"quickshell_border_bottom"
                color:"transparent"

                Rectangle{
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: bottomBarWindow.barWidth
                    color: root.borderColor

                    layer.enabled: true
                    layer.effect: MultiEffect{
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowOpacity: 0.5
                        shadowBlur: 0.6
                        shadowHorizontalOffset: 0
                        shadowVerticalOffset: -2
                    }
                }
            }


            // right bar
            PanelWindow{
                id:rightBarWindow
                property int barWidth: 5
                property int radius: 16
                property int borderThickness: 0
                color: "transparent"
                anchors.top: true
                anchors.bottom: true
                anchors.right: true
                implicitWidth: borderThickness+barWidth+radius
                exclusiveZone: borderThickness+barWidth
                WlrLayershell.layer:WlrLayer.Top

                Item {
                    anchors.fill: parent

                    layer.enabled: true
                    layer.effect: MultiEffect{
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowOpacity: 0.5
                        shadowBlur: 0.6
                        shadowHorizontalOffset: -2
                        shadowVerticalOffset: 0
                    }

                    Rectangle{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        width: rightBarWindow.barWidth
                        color: root.borderColor
                    }
                    Curves{
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.rightMargin: rightBarWindow.borderThickness+rightBarWindow.barWidth
                        radius: rightBarWindow.radius
                        color: root.borderColor
                        isTop: true
                        mirrorred:true
                    }
                    Curves{
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: rightBarWindow.borderThickness+rightBarWindow.barWidth
                        radius: rightBarWindow.radius
                        color: root.borderColor
                        isTop: false
                        mirrorred:true
                    }
                }
            }


            // left bar
            PanelWindow{
                id:leftBarWindow
                property int barWidth: 5
                property int radius: 16
                color: "transparent"
                anchors.top: true
                anchors.bottom: true
                anchors.left: true
                implicitWidth: barWidth+radius
                exclusiveZone: barWidth
                Item {
                    anchors.fill: parent

                    layer.enabled: true
                    layer.effect: MultiEffect{
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowOpacity: 0.5
                        shadowBlur: 0.6
                        shadowHorizontalOffset: 2
                        shadowVerticalOffset: 0
                    }

                    Rectangle{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        width: leftBarWindow.barWidth
                        color: root.borderColor
                        z:1
                    }
                    Curves{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: leftBarWindow.barWidth
                        radius: leftBarWindow.radius
                        color: root.borderColor
                        isTop: true
                        z:1
                    }
                    Curves{
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: leftBarWindow.barWidth
                        radius: leftBarWindow.radius
                        color: root.borderColor
                        isTop: false
                        z:1
                    }
                }




            }
            
        }
    }


}