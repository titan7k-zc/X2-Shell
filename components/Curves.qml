import QtQuick
import QtQuick.Shapes
import "../config"


Shape {
    id: root

    property real radius: 14
    property real cWidth: radius     // defaults to radius
    property real cHeight: radius    // defaults to radius

    required property color color
    property bool isTop: true
    property bool mirrored: false

    implicitWidth: cWidth
    implicitHeight: cHeight

    preferredRendererType: Shape.CurveRenderer

    transform: Scale {
        xScale: root.mirrored ? -1 : 1
        origin.x: root.cWidth / 2
        origin.y: 0
    }

    ShapePath {
        fillColor: root.color
        strokeColor: Colors.curvesStrokeColor
        startX: root.isTop ? root.cWidth : 0
        startY: 0

        PathLine {
            x: 0
            y: root.isTop ? 0 : root.cHeight
        }

        PathLine {
            x: root.isTop ? 0 : root.cWidth
            y: root.cHeight
        }

        PathArc {
            x: root.isTop ? root.cWidth : 0
            y: 0
            radiusX: root.cWidth
            radiusY: root.cHeight
            direction: PathArc.Clockwise
        }
    }
}
