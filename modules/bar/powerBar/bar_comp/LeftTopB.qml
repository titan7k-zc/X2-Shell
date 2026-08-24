import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import "../../../../config"
import "../../../../components"


Item {
    id:root
    implicitWidth: leftB.wid
    implicitHeight: leftB.hei + leftB.rad

    required property real rad

    Shape {
        id: leftB

        property int hei: 40
        property int wid: 200
        property int rad: root.rad
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shp

            strokeColor: "transparent"
            fillColor: Colors.sBG

            startX: 0
            startY: 0

            // top-right
            PathLine {
                x: leftB.wid
                y: 0
            }

            // right side
            PathLine {
                x: leftB.wid
                y: leftB.hei - leftB.rad
            }

            // bottom-right rounded corner
            PathArc {
                x: leftB.wid - leftB.rad
                y: leftB.hei
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Clockwise
            }

            // bottom
            PathLine {
                x: leftB.rad
                y: leftB.hei
            }

            // bottom-left rounded extension
            PathArc {
                x: 0
                y: leftB.hei + leftB.rad
                radiusX: leftB.rad
                radiusY: leftB.rad
                direction: PathArc.Counterclockwise
            }

            // left side
            PathLine {
                x: 0
                y: 0
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
        shadowVerticalOffset:3
        shadowHorizontalOffset: 2
        opacity: 0.7
    }

    Workspace {
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.fill:parent
        anchors.leftMargin: 7
        anchors.topMargin: 7
    }
}