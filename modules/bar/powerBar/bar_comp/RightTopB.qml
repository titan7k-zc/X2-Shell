import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "../../../../config"
import "../../../../components"

Item {
    id:root
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
            fillColor: Colors.bar_bg

            startX: 0
            startY: 0

            // top-right
            PathLine {
                x: rightB.wid
                y: 0
            }

            // right side (extends down for the right-side wing)
            PathLine {
                x: rightB.wid
                y: rightB.hei + rightB.rad
            }

            // bottom-right rounded extension
            PathArc {
                x: rightB.wid - rightB.rad
                y: rightB.hei
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Counterclockwise // Mirrored direction
            }

            // bottom
            PathLine {
                x: rightB.rad
                y: rightB.hei
            }

            // bottom-left rounded corner (curves inward)
            PathArc {
                x: 0
                y: rightB.hei - rightB.rad
                radiusX: rightB.rad
                radiusY: rightB.rad
                direction: PathArc.Clockwise // Mirrored direction
            }

            // left side
            PathLine {
                x: 0
                y: 0
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
        shadowVerticalOffset:3
        shadowHorizontalOffset: -2
        opacity: 0.7
    }

    Row{
        anchors.right: parent.right
        anchors.top:parent.top
        anchors.rightMargin: 7
        anchors.topMargin: 1

        spacing: 10


        Rectangle{
            width: sou.implicitWidth+20
            height: 35
            radius: 6
            color:"Transparent"
            Volume{id:sou;anchors.centerIn: parent}
        }

        Rectangle{
            width: bat.implicitWidth+20
            height: 35
            radius: 6
            color:"Transparent"
            Battery{id:bat;anchors.centerIn: parent}
        }
    }
}