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
    property int menuWidth: 1900
    property int menuTopRad: 22

    property color menuColor: Theme.bar_bg
    property int animDuration: 420
    property int animEasing: Easing.InOutQuad

    PanelWindow {
        id: menuWindow

        WlrLayershell.layer: WlrLayer.Overlay
        exclusiveZone: 0
        color: "transparent"

        anchors.top: root.anchorTop
        anchors.bottom: root.anchorBottom
        anchors.left: root.anchorLeft
        anchors.right: root.anchorRight

        // Surface is ALWAYS full size while it might be visible.
        // No per-frame Wayland resize -> no glitch.
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
                width: root.menuWidth //root.show ? root.menuWidth : 0   // Behavior on height only running so removed 
                height: root.show ? root.menuHeight : 0

                anchors.top: root.anchorTop ? parent.top : undefined
                anchors.bottom: root.anchorBottom ? parent.bottom : undefined
                anchors.left: root.anchorLeft ? parent.left : undefined
                anchors.right: root.anchorRight ? parent.right : undefined
                anchors.horizontalCenter: (!root.anchorLeft && !root.anchorRight) ? parent.horizontalCenter : undefined
                anchors.verticalCenter: (!root.anchorTop && !root.anchorBottom) ? parent.verticalCenter : undefined

                color: root.menuColor

                property int safeRad: Math.max(0, Math.min(root.menuTopRad, width / 2, height / 2))

                topLeftRadius:     (root.anchorBottom || root.anchorRight) ? safeRad : 0
                topRightRadius:    (root.anchorBottom || root.anchorLeft)  ? safeRad : 0
                bottomLeftRadius:  (root.anchorTop || root.anchorRight)    ? safeRad : 0
                bottomRightRadius: (root.anchorTop || root.anchorLeft)     ? safeRad : 0

                // Behavior on width {
                //     id: sizeAnimW
                //     NumberAnimation { duration: root.animDuration; easing.type: root.animEasing }
                // }
                Behavior on height {
                    id: sizeAnimH
                    NumberAnimation { duration: root.animDuration; easing.type: root.animEasing }
                }
            }

            Curves {
                anchors.left: menu.right   // attach to the RIGHT edge of the rectangle, curve flares outward
                anchors.top: root.anchorTop ? menu.top : undefined
                anchors.bottom: root.anchorBottom ? menu.bottom : undefined
                radius: menu.safeRad
                color: root.menuColor
                isTop: root.anchorTop
                mirrorred: false
            }
            Curves {
                anchors.right: menu.left  // attach to the LEFT edge of the rectangle
                anchors.top: root.anchorTop ? menu.top : undefined
                anchors.bottom: root.anchorBottom ? menu.bottom : undefined
                radius: menu.safeRad
                color: root.menuColor
                isTop: root.anchorTop
                mirrorred: true
            }

        }

        
    }
}