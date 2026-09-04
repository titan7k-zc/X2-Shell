import QtQuick
import QtQuick.Shapes
import "../config"


Shape {
    id:root
    property int radius: 14
    required property color color
    property bool isTop: true
    property bool mirrorred: false

    implicitHeight: radius
    implicitWidth:radius

    preferredRendererType: Shape.CurveRenderer

    transform: Scale{
        xScale: root.mirrorred?-1:1
        origin.x:root.radius/2
        origin.y:0
    }


    ShapePath{
        fillColor: root.color
        strokeColor: Colors.curvesTransparentColor
        startX: root.isTop?root.radius:0
        startY: root.isTop?0:0

        PathLine{
            x:0
            y:root.isTop?0:root.radius
        }

        PathLine{
            x:root.isTop?0:root.radius
            y:root.isTop?root.radius:root.radius
        }

        PathArc{
            x:root.isTop?root.radius:0
            y:root.isTop?0:0
            radiusX: root.radius
            radiusY: root.radius
            // direction: root.isTop? PathArc.Counterclockwise : PathArc.Clockwise
            direction: PathArc.Clockwise
        }
    }

}
