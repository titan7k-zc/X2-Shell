import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import "../../../../components"
import "../../../../config"


Item {
    id: midB
    anchors.horizontalCenter: parent.horizontalCenter

    implicitWidth: wid
    implicitHeight: hei

    property bool clic: false
    property int wid: 550
    property int hei: 40
    property int rad:openRad
    required property real openRad
    required property real closeRed
    property string activeTab: "Overview"


    Behavior on wid {
        NumberAnimation { duration: 380; easing.type: Easing.InOutQuad }
    }
    Behavior on hei {
        NumberAnimation { duration: 380; easing.type: Easing.InOutQuad }
    }
    Behavior on rad {
        NumberAnimation { duration: 380; easing.type: Easing.InOutQuad }
    }

    Shape {
        id: shape

        ShapePath {
            id: shp

            strokeColor: "transparent"
            fillColor: Theme.bar_bg

            startX: 0
            startY: 0

            // Top-right
            PathLine {
                x: shp.startX + midB.wid
                y: shp.startY
            }

            PathArc {
                x: shp.startX + midB.wid - midB.rad
                y: shp.startY + midB.rad
                radiusX: midB.rad
                radiusY: radiusX
                direction: PathArc.Counterclockwise
            }

            // Right side
            PathLine {
                x: shp.startX + midB.wid - midB.rad
                y: shp.startY + midB.hei - midB.rad
            }

            // Bottom-right
            PathArc {
                x: shp.startX + midB.wid - midB.rad * 2
                y: shp.startY + midB.hei
                radiusX: midB.rad
                radiusY: radiusX
                direction: PathArc.Clockwise
            }

            // Bottom
            PathLine {
                x: shp.startX + midB.rad * 2
                y: shp.startY + midB.hei
            }

            // Bottom-left
            PathArc {
                x: shp.startX + midB.rad
                y: shp.startY + midB.hei - midB.rad
                radiusX: midB.rad
                radiusY: radiusX
                direction: PathArc.Clockwise
            }

            // Left side
            PathLine {
                x: shp.startX + midB.rad
                y: shp.startY + midB.rad
            }

            // Top-left
            PathArc {
                x: shp.startX
                y: shp.startY
                radiusX: midB.rad
                radiusY: radiusX
                direction: PathArc.Counterclockwise
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: !midB.clic          // avoid accidental re-trigger while open
            onClicked: midB.clic = true
        }
    }

    // shadow
    MultiEffect {
        anchors.fill: shape
        source: shape
        shadowEnabled: true
        shadowBlur: 1.0
        shadowScale: 1
        shadowVerticalOffset: 6
        shadowHorizontalOffset: 0
        opacity: 0.6
    }

    Rectangle {
        id: min_time
        anchors.horizontalCenter: parent.horizontalCenter
        width: 100
        height: 35
        color: "Transparent"

        opacity: midB.clic ? 0 : 1
        scale: midB.clic ? 0.85 : 1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: 220; easing.type: Easing.OutQuad }
        }
        Behavior on scale {
            NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 1.1 }
        }

        Time {
            anchors.centerIn: parent
            show: true
        }
    }

    Rectangle {
        id: tabBar

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        color: "transparent"

        implicitWidth: 600
        implicitHeight: 40

        // Show / hide animation
        opacity: midB.clic ? 1 : 0
        scale: midB.clic ? 1 : 0.1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 460
                easing.type: Easing.OutBack
                easing.overshoot: 1.1
            }
        }


        // =========================
        // TABS
        // =========================

        Row {
            id: tabRow

            anchors.centerIn: parent

            Repeater {
                id: tabRepeater

                model: [
                    "Overview",
                    "Wallpapers",
                    "Theme",
                    "Settings"
                ]

                delegate: Rectangle {
                    required property string modelData

                    width: 150
                    height: 35

                    color: "transparent"

                    Text {
                        anchors.centerIn: parent

                        text: modelData

                        color: Theme.t1
                        font.bold: true

                        opacity: midB.activeTab === modelData ? 1.0 : 0.55

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            midB.activeTab = modelData
                        }
                    }
                }
            }
        }


        // =========================
        // ACTIVE TAB INDICATOR
        // =========================

        Rectangle {
            id: activeIndicator

            width: 130
            height: 4

            radius: 20
            color: Theme.t1

            y: tabRow.y + tabRow.height - height

            x: {
                var index = tabRepeater.model.indexOf(midB.activeTab)

                // Safety fallback
                if (index < 0)
                    index = 0

                return tabRow.x
                    + (index * 150)
                    + (150 - width) / 2
            }

            Behavior on x {
                NumberAnimation {
                    duration: 280
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    Rectangle {
        id: maxArea
        anchors.margins: 45
        anchors.bottomMargin: 20
        anchors.fill: shape
        color: "transparent"
        radius: midB.rad
        clip: true                    

        opacity: 0
        scale: 0
        visible: false


        Loader {
            id: wl
            width: wl.item ? wl.item.implicitWidth : 0
            height: wl.item ? wl.item.implicitHeight : 0
            anchors.centerIn: parent
            scale: 0.97 // bottom fix
            active: true
            opacity: 0

            // Crossfade the panel content in whenever it (re)loads, i.e.
            // on first open and whenever activeTab swaps the source.
            onLoaded: contentFade.restart()

            NumberAnimation {
                id: contentFade
                target: wl
                property: "opacity"
                from: 0
                to: 1
                duration: 280
                easing.type: Easing.OutQuad
            }

            // Component.onCompleted: {
            //     setSource("../../../wall/WallpaperSwitcher.qml", {});
            // }


            source:{
                if (midB.activeTab === "Overview"){
                    return "../../../overview/Overview.qml"
                }else if (midB.activeTab === "Wallpapers"){
                    return "../../../wall/WallpaperSwitcher.qml"
                }
            }
        }
    }

    states: [
        State {
            name: "open"
            when: midB.clic
            PropertyChanges { target: midB; wid: wl.width + 60; hei: wl.height + 60; rad: midB.openRad }
            PropertyChanges { target: maxArea; opacity: 1; scale: 1; visible: true }
        },
        State {
            name: "closed"
            when: !midB.clic
            PropertyChanges { target: midB; wid: 550; hei: 40; rad: midB.closeRed }
            PropertyChanges { target: maxArea; opacity: 0; scale: 0; visible: false }
        }
    ]

    transitions: [
        Transition {
            from: "closed"; to: "open"
            SequentialAnimation {
                PropertyAction { target: maxArea; property: "visible" }
                ParallelAnimation {
                    // container morph
                    NumberAnimation {
                        target: midB
                        properties: "wid,hei,rad"
                        duration: 500
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.2
                    }
                    // content reveal, staggered slightly behind the container
                    SequentialAnimation {
                        PauseAnimation { duration: 140 }
                        ParallelAnimation {
                            NumberAnimation { target: maxArea; property: "opacity"; duration: 300 }
                            NumberAnimation {
                                target: maxArea; property: "scale"
                                duration: 350
                                easing.type: Easing.OutBack
                                easing.overshoot: 1.2
                            }
                        }
                    }
                }
            }
        },
        Transition {
            from: "open"; to: "closed"
            SequentialAnimation {
                ParallelAnimation {
                    // content collapses first
                    NumberAnimation { target: maxArea; property: "opacity"; duration: 200 }
                    NumberAnimation {
                        target: maxArea; property: "scale"
                        duration: 260
                        easing.type: Easing.InBack     // safe direction for shrink-to-zero
                        easing.overshoot: 1.0
                    }
                    // container starts shrinking slightly after content begins fading
                    SequentialAnimation {
                        PauseAnimation { duration: 80 }
                        NumberAnimation {
                            target: midB
                            properties: "wid,hei,rad"
                            duration: 380
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                PropertyAction { target: maxArea; property: "visible" }
            }
        }
    ]
}
