import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../config/"

Item{
    id:root
    implicitHeight:menu.implicitHeight
    implicitWidth:menu.implicitWidth
    property int radius:8
    property color buttonColor:"Black"
    property color buttonIcoColor:Theme.ic
    Rectangle{
        id:menu
        implicitWidth:menuCol.implicitWidth
        implicitHeight:menuCol.implicitHeight+10
        color:"Transparent"
        radius:root.radius

        ColumnLayout{
            id:menuCol
            anchors.centerIn:parent
            spacing:15
            

            Rectangle{
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius


                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:1
                    text:""
                    font.pixelSize:35
                    color:root.buttonIcoColor
                }  


                MouseArea {
                    id: powerButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled:true

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "poweroff"])
                    }
                }
                scale: powerButtonMouseArea.pressed ? 0.92 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }



            
                          
            }
            Rectangle{
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius


                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:-1
                    text:"󰑐"
                    font.pixelSize:40
                    color:root.buttonIcoColor
                }
                MouseArea {
                    id: restartButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "reboot"])
                    }
                }
                scale: restartButtonMouseArea.pressed ? 0.92 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }


            }
            Rectangle{
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius

                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:1
                    text:""
                    font.pixelSize:35
                    color:root.buttonIcoColor
                }

                MouseArea {
                    id: lockButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "suspend"])
                    }
                }
                scale: lockButtonMouseArea.pressed ? 0.92 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }
                
            }
        }


    }
}