import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import "../../../../config"

Item {
    id: root
    implicitWidth: leftB.wid
    implicitHeight: leftB.hei + leftB.rad
    required property real rad

    Shape {
        id: leftB

        property int hei: 40
        property int wid: 650
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp

            strokeColor: "transparent"
            fillColor: Colors.bar_bg

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

    // Workspace {
    //     anchors.left: parent.left
    //     anchors.bottom: parent.bottom
    //     anchors.fill: parent
    //     anchors.leftMargin: 7
    //     anchors.bottomMargin: 7
    // }
}