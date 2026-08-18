import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./bar_comp"
import "../../../components"
import "../../../config"

Scope {
    id: bar

    property int hei: 60
    property int toph: 40
    required property real rad


    // ============================================================
    // topbar
    // ============================================================
    PanelWindow {
        id: topbar

        WlrLayershell.layer: WlrLayer.Top

        anchors {
            top: true
            left: true
            right: true
            
        }
        
        exclusiveZone: bar.toph   // handles reserved space

        color: "transparent"
        
        // margins.top: -bar.toph

        height: bar.hei

        LeftTopB {
            id: leftB

            rad:bar.rad

            anchors {
                left: parent.left
                top: parent.top
            }
        }

        RightTopB {
            id: rightB

            rad:bar.rad

            anchors {
                right: parent.right
                top: parent.top
            }
        }
    }
    // ============================================================
    // bottomBar
    // ============================================================
    PanelWindow {
        id: bottomBar

        WlrLayershell.layer: WlrLayer.Top

        anchors {
            bottom: true
            left: true
            right: true
            
        }
        
        exclusiveZone: bar.toph   // handles reserved space

        color: "Transparent"
        
        // margins.top: -bar.toph

        height: bar.hei

        LeftBottomB {
            id: leftBot

            rad:bar.rad

            anchors {
                left: parent.left
                bottom: parent.bottom
            }
        }

        RightBottomB {
            id: rightBot

            rad:bar.rad

            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }
    }


    // ============================================================
    // MIDDLE POPUP
    // ============================================================
    PanelWindow {
        id: midpop

        color: "transparent"

        anchors {
            top: true
            right: true
            left: true
            bottom: true
        }

        WlrLayershell.layer: WlrLayer.Top

        // This window must never reserve space.
        exclusiveZone: 0

        margins.top: -bar.toph


        // ========================================================
        // INPUT MASK
        // ========================================================

        property var midMask: Region {
            item: mb
        }

        // Closed:
        // only MidB receives mouse input.
        //
        // Open:
        // the whole PanelWindow receives input so that
        // clicking outside MidB can close it.
        mask: mb.clic ? null : midMask


        // ========================================================
        // CLICK OUTSIDE TO CLOSE
        // ========================================================

        MouseArea {
            anchors.fill: parent

            enabled: mb.clic

            onClicked: (mouse) => {
                var pos = mapToItem(
                    mb,
                    mouse.x,
                    mouse.y
                )

                if (
                    pos.x < 0 ||
                    pos.y < 0 ||
                    pos.x > mb.width ||
                    pos.y > mb.height
                ) {
                    mb.clic = false

                    console.log("closed from Bar")
                }
            }
        }


        // ========================================================
        // MIDDLE BUTTON / POPUP
        // ========================================================

        MidTopB {
            id: mb

            anchors.horizontalCenter: parent.horizontalCenter
            openRad:bar.rad+(bar.rad/2)
            closeRed:{
                if (bar.rad<22){
                    return bar.rad
                }else{
                    return 22
                }
            }
        }
    }


}