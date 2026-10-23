import QtQuick
import Quickshell

import "../config"
import "../services"

Item{
    id:root
    property real radius:10
    property color bgColor:Colors.cavaBackgroundColor
    property color barColor:Colors.cavaBarColor
    property bool anchorBottom: false
    

    width:360
    height:50

    Rectangle{
        anchors.fill: parent
        radius: root.radius
        color: root.bgColor

        scale:cavaMouseArea.pressed? 0.9:1.0


        Row{
            anchors.fill: parent
            anchors.margins: 8
            anchors.bottomMargin: root.anchorBottom ? 0 : 8
            spacing: 4

            Repeater{
                model: CavaServices.barLevels
                Item{
                    anchors.verticalCenter: parent.verticalCenter
                    // anchors.verticalCenterOffset:0.5  // need to fix hardcoded value
                    id:barContainer
                    width: (parent.width - (parent.spacing * (CavaServices.barCount - 1))) / CavaServices.barCount
                    height: parent.height

                    Rectangle{
                        anchors.centerIn: !root.anchorBottom ? parent : undefined
                        
                        anchors.bottom: root.anchorBottom ? parent.bottom : undefined





                        width: parent.width
                        height: Math.max(width, parent.height * modelData)
                        radius: width / 2
                        color: Qt.rgba(root.barColor.r, root.barColor.g, root.barColor.b, Colors.cavaBarGradientMinimumOpacity + (Colors.cavaBarGradientOpacityRange * modelData))

                        

                        Behavior on height{
                            NumberAnimation{
                                duration: 50
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }
        }

        MouseArea{
            id:cavaMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                CavaServices.restart()
            }
        }
    }
    
}
