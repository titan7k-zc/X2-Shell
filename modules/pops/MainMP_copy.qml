import QtQuick 2.15
import Quickshell
import Quickshell.Wayland
import "../../config"
import "../../components"
import QtQuick.Effects

Scope {
    id: root

    property bool show: false

    property bool anchorTop: false
    property bool anchorBottom: false
    property bool anchorLeft: false
    property bool anchorRight: false


    property int menuHeight: maxArea.itemHei+40
    property int menuWidth:  maxArea.itemWid+40
    required property int rad



    property color menuColor: Theme.bar_bg
    property int animDuration: 420
    property int animEasing: Easing.InOutQuad


    default property alias content: contentGrid.data




    property int menueLoc: {
        if (anchorTop && anchorLeft)       return 1
        else if (anchorTop && anchorRight) return 3
        else if (anchorTop)                return 2
        else if (anchorBottom && anchorRight) return 5
        else if (anchorBottom && anchorLeft)  return 7
        else if (anchorBottom)             return 6
        else if (anchorRight)              return 4
        else if (anchorLeft)               return 8
        return 2 // default
    }


    property real h_ani:{
        if (anchorTop||anchorBottom){
            return 1.4
        }else{
            return 1
        }
    }
    property real w_ani:{
        if (anchorLeft||anchorRight){
            return 1.4
        }else{
            return 1
        }
    }

    PanelWindow {
        id: menuWindow

        WlrLayershell.layer: WlrLayer.Overlay
        exclusiveZone: 0
        color: "transparent"

        anchors.top: root.anchorTop
        anchors.bottom: root.anchorBottom
        anchors.left: root.anchorLeft
        anchors.right: root.anchorRight


        implicitWidth: root.menuWidth+root.rad*2
        implicitHeight: root.menuHeight+root.rad*2

        // Only actually detach/hide the surface once fully closed
        visible: root.show || sizeAnimW.running || sizeAnimH.running

        

        property var midMask: Region {
            item: menu
        }

        mask: root.show ? null : midMask


        Item {
            id: clipper
            anchors.fill: parent
            clip: true

            layer.enabled: true
            layer.effect: MultiEffect{
                shadowEnabled: true
                shadowColor: "black"
                shadowOpacity: 0.5
                shadowBlur: 0.6
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 2
            }

            Rectangle {
                id: menu
                width: root.show ? root.menuWidth : 0   
                height: root.show ? root.menuHeight : 0

                anchors.top: root.anchorTop ? parent.top : undefined
                anchors.bottom: root.anchorBottom ? parent.bottom : undefined
                anchors.left: root.anchorLeft ? parent.left : undefined
                anchors.right: root.anchorRight ? parent.right : undefined
                anchors.horizontalCenter: (!root.anchorLeft && !root.anchorRight) ? parent.horizontalCenter : undefined
                anchors.verticalCenter: (!root.anchorTop && !root.anchorBottom) ? parent.verticalCenter : undefined

                color: root.menuColor

                property int safeRad: Math.max(0, Math.min(root.rad, width / 2, height / 2))

                topLeftRadius:     (root.menueLoc===4 || root.menueLoc===5 || root.menueLoc===6 ) ? safeRad : 0
                topRightRadius:    (root.menueLoc===6 || root.menueLoc===7 || root.menueLoc===8 ) ? safeRad : 0
                bottomLeftRadius:  (root.menueLoc===2 || root.menueLoc===3 || root.menueLoc===4 ) ? safeRad : 0
                bottomRightRadius: (root.menueLoc===8 || root.menueLoc===1 || root.menueLoc===2 ) ? safeRad : 0

                Behavior on height {
                    id: sizeAnimH
                    NumberAnimation { duration: root.animDuration/root.h_ani; easing.type: root.animEasing }
                }
                Behavior on width {
                    id: sizeAnimW
                    NumberAnimation { duration: root.animDuration/root.w_ani; easing.type: root.animEasing }
                }



                clip:true


                // -------------------------------------------------------------   Real menu   ---------------------------------------------------------------------------------------------------------------------menu itms
                Rectangle {
                    id: maxArea
                    anchors.centerIn: parent

                    height: Math.max(0, menu.height - 40)
                    width: Math.max(0, menu.width - 40)

                    color: '#4c005931'
                    radius: menu.safeRad
                    clip: true

                    property real itemHei:500
                    property real itemWid:100

                    Grid {
                        id: contentGrid
                        anchors.centerIn: parent
                        spacing: 8
                        // injected Popup{ ... } children get reparented here 
                    }


                    opacity: root.show ? 1 : 0.2
                    Behavior on opacity {
                        NumberAnimation { duration: root.animDuration/2; easing.type: root.animEasing }
                    }
                }
            }






            // curve 1
            Curves {
                anchors.left: {
                    if (root.menueLoc===1 || root.menueLoc===8){
                        return menu.left
                    }else if (root.menueLoc===6 || root.menueLoc===7){
                        return menu.right
                    }else {
                        return undefined
                    }

                }

                anchors.right: {
                    if (root.menueLoc ===4 ||root.menueLoc ===5){
                        return menu.right
                    }else if (root.menueLoc===2 || root.menueLoc===3){
                        return menu.left
                    }else {
                        return undefined
                    }

                }


                anchors.top: {
                    if (root.menueLoc===2 || root.menueLoc===3){
                        return menu.top
                    }else if (root.menueLoc===1 || root.menueLoc===8){
                        return menu.bottom
                    }else{
                        return undefined
                    }

                }



                anchors.bottom: {
                    if(root.menueLoc===6 || root.menueLoc===7){
                        return menu.bottom
                    }else if (root.menueLoc ===4 ||root.menueLoc ===5){
                        return menu.top
                    }else{
                        return undefined
                    }

                }

                isTop: root.menueLoc===1 ||root.menueLoc===2 ||root.menueLoc===3 ||root.menueLoc===8 
                mirrorred: root.menueLoc===2 ||root.menueLoc===3 ||root.menueLoc===4 ||root.menueLoc===5 

                radius: menu.safeRad
                color: root.menuColor
            }
            
        
            // curve 2
            Curves {
                anchors.left: {
                    if (root.menueLoc === 7 || root.menueLoc === 8) {
                        return menu.left
                    } else if (root.menueLoc === 1 || root.menueLoc === 2) {
                        return menu.right
                    } else {
                        return undefined
                    }
                }

                anchors.right: {
                    if (root.menueLoc === 3 || root.menueLoc === 4) {
                        return menu.right
                    } else if (root.menueLoc === 5 || root.menueLoc === 6) {
                        return menu.left
                    } else {
                        return undefined
                    }
                }

                anchors.top: {
                    if (root.menueLoc === 1 || root.menueLoc === 2) {
                        return menu.top
                    } else if (root.menueLoc === 3 || root.menueLoc === 4) {
                        return menu.bottom
                    } else {
                        return undefined
                    }
                }

                anchors.bottom: {
                    if (root.menueLoc === 5 || root.menueLoc === 6) {
                        return menu.bottom
                    } else if (root.menueLoc === 7 || root.menueLoc === 8) {
                        return menu.top
                    } else {
                        return undefined
                    }
                }

                isTop: root.menueLoc === 1 ||
                    root.menueLoc === 2 ||
                    root.menueLoc === 3 ||
                    root.menueLoc === 4

                mirrorred: root.menueLoc === 3 ||
                        root.menueLoc === 4 ||
                        root.menueLoc === 5 ||
                        root.menueLoc === 6

                radius: menu.safeRad
                color: root.menuColor
            }






        }

        
    }
}