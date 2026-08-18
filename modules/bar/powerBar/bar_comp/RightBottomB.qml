import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "../../../../config"
import "../../../../components"

Item {
    id: root
    implicitWidth: rightB.wid
    implicitHeight: rightB.hei + rightB.rad
    required property real rad

    Shape {
        id: rightB
        property int hei: 40
        property int wid: 200
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp
            strokeColor: "transparent"
            fillColor: Theme.bar_bg

            startX: 0
            startY: rightB.hei + rightB.rad

            // bottom-right (mirrors: top-right)
            PathLine {
                x: rightB.wid
                y: rightB.hei + rightB.rad
            }

            // right side (extends up for the right-side wing)
            PathLine {
                x: rightB.wid
                y: 0
            }

            // top-right rounded extension (mirrors: bottom-right rounded extension)
            PathArc {
                x: rightB.wid - rightB.rad
                y: rightB.rad
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Clockwise // flipped from Counterclockwise
            }

            // top
            PathLine {
                x: rightB.rad
                y: rightB.rad
            }

            // top-left rounded corner (mirrors: bottom-left rounded corner)
            PathArc {
                x: 0
                y: rightB.rad * 2
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Counterclockwise // flipped from Clockwise
            }

            // left side
            PathLine {
                x: 0
                y: rightB.hei + rightB.rad
            }
        }
    }

    MultiEffect {
        anchors.fill: rightB
        source: rightB

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        // shadowColor:'#000000'
        shadowVerticalOffset:-3
        shadowHorizontalOffset: -2
        opacity: 0.7
    }

    // Row {
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom
    //     anchors.rightMargin: 7
    //     anchors.bottomMargin: 2

    //     // spacing: 10

    //     Rectangle {
    //         width: sou.implicitWidth + 20
    //         height: 35
    //         radius: 6
    //         color: Theme.bar_bg
    //         Volume { id: sou; anchors.centerIn: parent }
    //     }

    //     Rectangle {
    //         width: bat.implicitWidth + 20
    //         height: 35
    //         radius: 6
    //         color: Theme.bar_bg
    //         Battery { id: bat; anchors.centerIn: parent }
    //     }
    // }
}