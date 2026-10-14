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
                        scale:widgetMouseArea.pressed ? 0.93 : 1.0
                        color:Controls.showWidgets ? "blue" : "white"
                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󱍕"
                            font.pixelSize: 20
                        }

                        MouseArea{
                            id: widgetMouseArea
                            anchors.fill:parent
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
                        scale:multiLayerMouseArea.pressed ? 0.93 : 1.0
                        color:Controls.multiLayer ? "blue" : "white"
                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󰧾"
                            font.pixelSize: 20
                        }
                        MouseArea{
                            id: multiLayerMouseArea 
                            anchors.fill:parent
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
                        scale:dndMouseArea.pressed ? 0.93 : 1.0
                        color:Controls.dnd ? "blue" : "white"
                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text:"󱙍"
                            font.pixelSize: 18
                        }
                        MouseArea{
                            id: dndMouseArea
                            anchors.fill:parent
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
                        scale:refreshShelllMouseArea.pressed ? 0.93 : 1.0
                        color:refreshShelllMouseArea.pressed ? "blue" : "white"
                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.InOutQuad
                            }
                        }
                        Text{
                            
                            anchors.centerIn: parent
                            text:""
                            font.pixelSize: 20
                        }
                        MouseArea{
                            id: refreshShelllMouseArea
                            anchors.fill:parent
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