import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../config/"

FocusScope{
    id:root
    signal closed
    implicitHeight:menu.implicitHeight
    implicitWidth:menu.implicitWidth
    property int radius:8
    property color buttonColor: Colors.powerButtonColor
    property color buttonIcoColor: Colors.powerIconColor
    property color buttonFocIcoColor: Colors.powerFocusedIconColor
    Rectangle{
        id:menu
        implicitWidth:menuCol.implicitWidth
        implicitHeight:menuCol.implicitHeight+10
        color: "Transparent"
        radius:root.radius

        ColumnLayout{
            id:menuCol
            anchors.centerIn:parent
            spacing:15
            
            // power off
            Rectangle{
                id:power
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius
                focus:true
                KeyNavigation.up: logout
                KeyNavigation.down: reboot

                Keys.onReturnPressed:{
                    Quickshell.execDetached(["systemctl", "poweroff"])
                    root.closed();
                }



                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:1
                    text:""
                    font.pixelSize:35
                    color:parent.focus?root.buttonFocIcoColor:root.buttonIcoColor
                }  


                MouseArea {
                    id: powerButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled:true

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "poweroff"])
                        root.closed();
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

            // reboot
            Rectangle{
                id:reboot
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius
                focus:false
                KeyNavigation.up: power
                KeyNavigation.down: sleep


                Keys.onReturnPressed:{
                    Quickshell.execDetached(["systemctl", "reboot"])
                    root.closed();
                }

                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:-1
                    text:"󰑐"
                    font.pixelSize:40
                    color:parent.focus?root.buttonFocIcoColor:root.buttonIcoColor
                }
                MouseArea {
                    id: restartButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "reboot"])
                        root.closed();
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

            // sleep
            Rectangle{
                id:sleep
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius
                focus:false
                KeyNavigation.up: reboot
                KeyNavigation.down: logout 

                Keys.onReturnPressed:{
                    Quickshell.execDetached(["systemctl", "suspend"])
                    root.closed();
                }

                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:1
                    text:"󰤄"
                    font.pixelSize:35
                    color:parent.focus?root.buttonFocIcoColor:root.buttonIcoColor
                }

                MouseArea {
                    id: sleepButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Quickshell.execDetached(["systemctl", "suspend"])
                        root.closed();
                    }
                }
                scale: sleepButtonMouseArea.pressed ? 0.92 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }
                
            }
            Rectangle{
                id:logout
                color:root.buttonColor
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                radius:root.radius
                focus:false
                KeyNavigation.up: sleep
                KeyNavigation.down: power 

                Keys.onReturnPressed:{
                    Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.exit()"])
                    root.closed();
                }

                Text{
                    anchors.centerIn:parent
                    anchors.horizontalCenterOffset:1
                    text:"󰍃"
                    font.pixelSize:35
                    color:parent.focus?root.buttonFocIcoColor:root.buttonIcoColor
                }

                MouseArea {
                    id: logoutButtonMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.exit()"])
                        root.closed();
                    }
                }
                scale: logoutButtonMouseArea.pressed ? 0.92 : 1.0

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