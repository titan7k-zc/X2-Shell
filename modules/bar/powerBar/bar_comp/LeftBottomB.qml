import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import "../../../../config"
import "../../../taskbar"


Item {
    id: root
    implicitWidth: leftB.wid
    implicitHeight: leftB.hei + leftB.rad
    required property real rad

    Shape {
        id: leftB

        property int hei: 40
        property int wid: 350
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp

            strokeColor: "transparent"
            fillColor: Colors.sBG

            startX: 0
            startY: leftB.hei + leftB.rad

            // bottom-right (mirrors: top-right)
            PathLine {
                x: leftB.wid
                y: leftB.hei + leftB.rad
            }

            // right side (mirrors: right side)
            PathLine {
                x: leftB.wid
                y: leftB.rad * 2
            }

            // top-right rounded corner (mirrors: bottom-right rounded corner)
            PathArc {
                x: leftB.wid - leftB.rad
                y: leftB.rad
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Counterclockwise
            }

            // top (mirrors: bottom)
            PathLine {
                x: leftB.rad
                y: leftB.rad
            }

            // top-left rounded extension (mirrors: bottom-left rounded extension)
            PathArc {
                x: 0
                y: 0
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Clockwise
            }

            // left side (mirrors: left side)
            PathLine {
                x: 0
                y: leftB.hei + leftB.rad
            }
        }
    }

    MultiEffect {
        anchors.fill: leftB
        source: leftB

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        // shadowColor:'#000000'
        shadowVerticalOffset:-3
        shadowHorizontalOffset: 2
        opacity: 0.7
    }
    Rectangle {
        id: hoverPopup

        anchors.left: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.leftMargin: 15

        width: hoverName.implicitWidth === 0
            ? 0
            : hoverName.implicitWidth + 60

        height: 25

        // topRightRadius: 8
        // bottomRightRadius: 8
        radius:8

        color: Colors.sBG

        opacity: tb.hoveredTitle === "" ? 0 : 1

        Behavior on width {
            NumberAnimation {
                duration: 380
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }

        // Actual popup
        Text {
            id: hoverName

            anchors.fill: parent
            anchors.leftMargin: 30
            anchors.rightMargin: 20

            text: tb.hoveredTitle

            color: Colors.tMain

            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight

            opacity: 1

            // Connections {
            //     target: tb

            //     function onHoveredTitleChanged() {
            //         textAnimation.restart()
            //     }
            // }

            // SequentialAnimation {
            //     id: textAnimation

            //     NumberAnimation {
            //         target: hoverName
            //         property: "opacity"
            //         to: 0
            //         duration: 100
            //         easing.type: Easing.OutCubic
            //     }

            //     PropertyAction {
            //         target: hoverName
            //         property: "text"
            //         value: tb.hoveredTitle
            //     }

            //     NumberAnimation {
            //         target: hoverName
            //         property: "opacity"
            //         to: 1
            //         duration: 260
            //         easing.type: Easing.OutCubic
            //     }
            // }
        }
    }

    MultiEffect {
        id: hoverShadow

        anchors.fill: hoverPopup

        source: hoverPopup

        shadowEnabled: true
        shadowBlur: 0.8
        shadowScale: 1

        shadowHorizontalOffset: 2
        shadowVerticalOffset: -1

        opacity: hoverPopup.opacity * 0.7
    }
        
    
    
    Taskbar {
        id:tb
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        width:leftB.wid-20
        anchors.leftMargin:5
        
    }



}