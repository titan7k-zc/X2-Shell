import QtQuick
import QtQuick.Layouts
import Quickshell
import "../wifi"
import "../bluetooth"
import "../notification"
import "../../config"

Item{
    implicitHeight: panel.height
    implicitWidth: panel.width
    Rectangle{
        id:panel
        width:450
        height:1400
        color:"Transparent"
        
        ColumnLayout {
            anchors.fill: parent
            anchors.topMargin: 30
            anchors.bottomMargin: 30
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 20

            WifiPanel {
                Layout.fillWidth: true
            }

            BluetoothPanel {
                Layout.fillWidth: true
            }

            NotificationPanel {
                Layout.fillWidth: true
                Layout.fillHeight: true 
            }

            Rectangle {

                id:buttonsRow

                Layout.fillWidth: true
                Layout.preferredHeight: 45
                color: "Transparent"

                RowLayout{
                    anchors.fill:parent
                    spacing: 10
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true 
                        radius: 10
                        property bool active: Controls.showWidgets
                        scale: widgetMouseArea.pressed ? 0.94 : widgetMouseArea.containsMouse ? 1.03 : 1.0
                        color: active ? Colors.controlCenterButtonActiveColor
                            : widgetMouseArea.pressed ? Colors.controlCenterButtonPressedColor
                            : widgetMouseArea.containsMouse ? Colors.controlCenterButtonHoverColor
                            : Colors.controlCenterButtonColor
                        border.width: 1
                        border.color: active ? Colors.controlCenterButtonActiveBorderColor : Colors.controlCenterButtonBorderColor
                        Behavior on color {
                            ColorAnimation {
                                duration: 180
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on border.color {
                            ColorAnimation {
                                duration: 180
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 180
                                easing.type: Easing.OutBack
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󱍕"
                            font.pixelSize: 20
                            color: parent.active ? Colors.controlCenterButtonActiveIconColor : Colors.controlCenterButtonIconColor
                            Behavior on color { ColorAnimation { duration: 180; easing.type: Easing.OutCubic } }
                        }

                        MouseArea{
                            id: widgetMouseArea
                            anchors.fill:parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                Controls.showWidgets=!Controls.showWidgets
                                console.log("showWidgets:-" + Controls.showWidgets)
                            }
                        }

                    }
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true 
                        radius: 10
                        property bool active: Controls.multiLayer
                        scale: multiLayerMouseArea.pressed ? 0.94 : multiLayerMouseArea.containsMouse ? 1.03 : 1.0
                        color: active ? Colors.controlCenterButtonActiveColor
                            : multiLayerMouseArea.pressed ? Colors.controlCenterButtonPressedColor
                            : multiLayerMouseArea.containsMouse ? Colors.controlCenterButtonHoverColor
                            : Colors.controlCenterButtonColor
                        border.width: 1
                        border.color: active ? Colors.controlCenterButtonActiveBorderColor : Colors.controlCenterButtonBorderColor
                        Behavior on color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on border.color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on scale {
                            NumberAnimation { duration: 180; easing.type: Easing.OutBack }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󰧾"
                            font.pixelSize: 20
                            color: parent.active ? Colors.controlCenterButtonActiveIconColor : Colors.controlCenterButtonIconColor
                            Behavior on color { ColorAnimation { duration: 180; easing.type: Easing.OutCubic } }
                        }
                        MouseArea{
                            id: multiLayerMouseArea 
                            anchors.fill:parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                Controls.multiLayer=!Controls.multiLayer
                                console.log("multiLayer:-" + Controls.multiLayer)
                            }
                        }
                    }
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true 
                        radius: 10
                        property bool active: Controls.dnd
                        scale: dndMouseArea.pressed ? 0.94 : dndMouseArea.containsMouse ? 1.03 : 1.0
                        color: active ? Colors.controlCenterButtonActiveColor
                            : dndMouseArea.pressed ? Colors.controlCenterButtonPressedColor
                            : dndMouseArea.containsMouse ? Colors.controlCenterButtonHoverColor
                            : Colors.controlCenterButtonColor
                        border.width: 1
                        border.color: active ? Colors.controlCenterButtonActiveBorderColor : Colors.controlCenterButtonBorderColor
                        Behavior on color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on border.color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on scale {
                            NumberAnimation { duration: 180; easing.type: Easing.OutBack }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󱙍"
                            font.pixelSize: 18
                            color: parent.active ? Colors.controlCenterButtonActiveIconColor : Colors.controlCenterButtonIconColor
                            Behavior on color { ColorAnimation { duration: 180; easing.type: Easing.OutCubic } }
                        }
                        MouseArea{
                            id: dndMouseArea
                            anchors.fill:parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                Controls.dnd=!Controls.dnd
                                console.log("dnd:-" + Controls.dnd)
                            }  
                        }
                    }
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true 
                        radius: 10
                        scale: refreshShelllMouseArea.pressed ? 0.94 : refreshShelllMouseArea.containsMouse ? 1.03 : 1.0
                        color: refreshShelllMouseArea.pressed ? Colors.controlCenterButtonPressedColor
                            : refreshShelllMouseArea.containsMouse ? Colors.controlCenterButtonHoverColor
                            : Colors.controlCenterButtonColor
                        border.width: 1
                        border.color: Colors.controlCenterButtonBorderColor
                        Behavior on color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on border.color {
                            ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
                        }
                        Behavior on scale {
                            NumberAnimation { duration: 180; easing.type: Easing.OutBack }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:""
                            font.pixelSize: 20
                            color: Colors.controlCenterButtonIconColor
                            Behavior on color { ColorAnimation { duration: 180; easing.type: Easing.OutCubic } }
                        }
                        MouseArea{
                            id: refreshShelllMouseArea
                            anchors.fill:parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                Quickshell.execDetached([
                                    "sh", "-c",
                                    "pkill qs; qs -c X2-Shell"
                                ])
                            }
                        }
                    }
                }

            }
        }
        
        

    }
}