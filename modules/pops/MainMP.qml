import QtQuick 2.15
import Quickshell
import Quickshell.Wayland
import "../../config"
import "../"
import QtQuick.Effects

Scope {
    id: root

    property bool show: false

    property bool anchorTop: true
    property bool anchorBottom: false
    property bool anchorLeft: false
    property bool anchorRight: false


    property int menuHeight: 500
    property int menuWidth: 1600
    property int menuTopRad: 20



    property color menuColor: Theme.bar_bg
    property int animDuration: 420
    property int animEasing: Easing.InOutQuad




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
            return 1.2
        }else{
            return 1
        }
    }
    property real w_ani:{
        if (anchorLeft||anchorRight){
            return 1.2
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


        implicitWidth: root.menuWidth+root.menuTopRad*2
        implicitHeight: root.menuHeight+root.menuTopRad*2

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
                width: /*root.menuWidth*/ root.show ? root.menuWidth : 0   // Behavior on height only running so removed 
                height: root.show ? root.menuHeight : 0

                anchors.top: root.anchorTop ? parent.top : undefined
                anchors.bottom: root.anchorBottom ? parent.bottom : undefined
                anchors.left: root.anchorLeft ? parent.left : undefined
                anchors.right: root.anchorRight ? parent.right : undefined
                anchors.horizontalCenter: (!root.anchorLeft && !root.anchorRight) ? parent.horizontalCenter : undefined
                anchors.verticalCenter: (!root.anchorTop && !root.anchorBottom) ? parent.verticalCenter : undefined

                color: root.menuColor

                property int safeRad: Math.max(0, Math.min(root.menuTopRad, width / 2, height / 2))

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







                // ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------menue itms
                Rectangle{
                    id: maxArea
                    anchors.margins: 20
                    anchors.bottomMargin: 20
                    anchors.fill: parent
                    color: '#4c005931'
                    radius: menu.safeRad
                    clip: true                    

                    opacity: 1
                    scale: 1
                    visible: true
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