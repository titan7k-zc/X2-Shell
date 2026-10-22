import QtQuick
import Quickshell
import QtQuick.Shapes
import QtQuick.Effects
import "../../../config"
import "../../../services/"
import "../../../components"

Item {
    id: root
    implicitWidth: wid
    implicitHeight: hei 
    required property int rad
    required property int se
    property int hei: 40
    property int wid: 640

    signal notificationClicked()


    Rectangle {
        id: rightB
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: root.wid
        height: root.hei + root.rad
        color: "Transparent"
        Rectangle {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: root.wid
            height: root.hei
            topLeftRadius: root.rad
            color: "black"//Colors.barBorderColor

            Rectangle{
                anchors.fill: parent
                bottomRightRadius: root.se
                topLeftRadius: root.rad
                color: Colors.barBorderColor

                Row{
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.right:parent.right
                    anchors.rightMargin:20
                    anchors.leftMargin:20
                    spacing: 10

                    PerformanceCtrl{
                        id:performanceCtrl
                        anchors.verticalCenter:parent.verticalCenter
                        
                        implicitHeight: root.hei-5
                    }
                    Item{
                        width: 30
                        height: 20
                    }
                    BatteryCtrl{
                        id:batteryCtrl
                        anchors.verticalCenter:parent.verticalCenter
                        implicitHeight: root.hei-5
                    }
                    Item{
                        width: 20  
                        height: 20
                    }

                    Rectangle{
                        id: notificationCount
                        anchors.verticalCenter:parent.verticalCenter
                        implicitWidth: notificationCountRow.implicitWidth + 20
                        implicitHeight: root.hei-8
                        radius: height / 2
                        color: Colors.notificationCounterBackgroundColor
                        opacity: 1.0//NotificationService.notifications.values.length > 0 ? 1 : 0
                        scale: notificationCountMouseArea.pressed ? 0.94 : (NotificationService.notifications.values.length > 0 ? 1 : 0.85)
                        // visible: opacity > 0

                        Row{
                            id: notificationCountRow
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 8

                            Text {
                                id: notificationCount2
                                anchors.verticalCenter:parent.verticalCenter
                                anchors.verticalCenterOffset:2
                                text: "󰍡"
                                font.pixelSize: 20
                                color: Colors.notificationCounterIconColor

                            }
                            Text{
                                id: notificationCountText
                                anchors.verticalCenter:parent.verticalCenter
                                anchors.verticalCenterOffset:2
                                text: count
                                font.pixelSize: 12
                                color: Colors.notificationCounterTextColor
                                property string count: NotificationService.notifications.values.length < 10 ? String(NotificationService.notifications.values.length) : "9+"
                                visible: NotificationService.notifications.values.length > 0
                                SequentialAnimation {
                                    id: countPulse
                                    NumberAnimation {
                                        target: notificationCountText
                                        property: "scale"
                                        to: 1.18
                                        duration: 120
                                        easing.type: Easing.OutCubic
                                    }
                                    NumberAnimation {
                                        target: notificationCountText
                                        property: "scale"
                                        to: 1
                                        duration: 180
                                        easing.type: Easing.OutBack
                                    }
                                }

                                onTextChanged: countPulse.restart()

                            }
                        }

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 180
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on scale {
                            NumberAnimation {
                                duration: 260
                                easing.type: Easing.OutBack
                                easing.overshoot: 0.8
                            }
                        }

                        Behavior on width {
                            NumberAnimation {
                                duration: 220
                                easing.type: Easing.OutCubic
                            }
                        }

                        MouseArea {
                            id: notificationCountMouseArea
                            anchors.fill: parent
                            // enabled: NotificationService.notifications.values.length > 0
                            cursorShape: Qt.PointingHandCursor
                            anchors.margins: -5
                            onClicked: {
                                root.notificationClicked()
                            }
                        }
                    
                    }
                    Item{
                        width: 20  
                        height: 20
                    }
                }
                
            }   
        }
    }


    MultiEffect {
        opacity: Colors.shadowOpacity
        shadowColor: Colors.shadowColor
        anchors.fill: rightB
        source: rightB

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        shadowVerticalOffset:-3
        shadowHorizontalOffset:-2
        
    }



}
