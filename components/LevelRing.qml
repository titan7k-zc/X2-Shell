import QtQuick
import QtQuick.Shapes
import "../config"

Item {
    id: root

    property real value: 75

    property real ringSize: 100
    property real ringWidth: 10

    property real startAngle: -90
    // -90 = top
    //   0 = right
    //  90 = bottom
    // 180 = left

    property color backgroundColor: Colors.levelRingBackgroundColor
    property color fillColor: Colors.levelRingFillColor

    property bool showValue: false

    implicitWidth: ringSize
    implicitHeight: ringSize

    onValueChanged: {
        value = Math.max(0, Math.min(100, value))
    }

    Behavior on value {
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutCubic
        }
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        // Background ring
        ShapePath {
            fillColor: Colors.levelRingTrackColor
            strokeColor: root.backgroundColor
            strokeWidth: root.ringWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2

                radiusX: (root.width - root.ringWidth) / 2
                radiusY: (root.height - root.ringWidth) / 2

                startAngle: root.startAngle
                sweepAngle: 360
            }
        }

        // Value ring
        ShapePath {
            fillColor: Colors.levelRingTrackColor
            strokeColor: root.fillColor
            strokeWidth: root.ringWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2

                radiusX: (root.width - root.ringWidth) / 2
                radiusY: (root.height - root.ringWidth) / 2

                startAngle: root.startAngle
                sweepAngle: root.value * 3.6
            }
        }
    }

    Text {
        visible: root.showValue

        anchors.centerIn: parent

        text: Math.round(root.value) + "%"

        color: Colors.levelRingValueTextColor
        font.pixelSize: root.ringSize / 5
    }
}