import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../../config"
import "../../../components"
import "../../../services"
import "../../taskbar"

Item{
    id: topBar
    anchors.fill: parent
    property real colRadius:10
    required property bool midB_Status

    Rectangle{
        anchors.fill: parent
        color:"Transparent"
        
        // left side row
        Row{
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing:30

            Workspace {
                anchors.verticalCenter: parent.verticalCenter
            }


            ClippingRectangle{
                anchors.verticalCenter: parent.verticalCenter
                width: tb.width
                height: tb.height+3
                color:Colors.powerBarBulletColor
                radius: topBar.colRadius
                Taskbar {
                    id:tb
                    anchors.centerIn: parent
                    // width:300
                    height:32
                    
                }
            }

        }

        // center row
        Row{
            anchors.centerIn: parent
            spacing:30

            Text {
                id:txt
                text:TimeServices.hour+":"+TimeServices.minute
                opacity: topBar.midB_Status?0:1
                color: Colors.powerBarTextColor
                font {
                    family: "Quicksand"
                    letterSpacing: 0
                    pixelSize: 20
                    weight: Font.Bold
                }
                Behavior on opacity{
                    NumberAnimation{
                        duration: 280
                    }
                }

            }
        }


        // Right side row
        Row{
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing:30
        
            Rectangle{
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.powerBarBulletColor
                width:rightRow.width+15
                height:34
                radius:topBar.colRadius
        
                Row{
                    id: rightRow
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 5
                    spacing: 5


                    Rectangle{
                        width: bat.implicitWidth+20
                        height: 35
                        color: "Transparent"
                        Brightness{id:brig;anchors.centerIn: parent}
                    }

                    Rectangle{
                        width: sou.implicitWidth+20
                        height: 35
                        color: "Transparent"
                        Volume{id:sou;anchors.centerIn: parent}
                    }

                    Rectangle{
                        width: bat.implicitWidth+20
                        height: 35
                        color: "Transparent"
                        Battery{id:bat;anchors.centerIn: parent}
                    }
                }
                
            }

        }



    }

}