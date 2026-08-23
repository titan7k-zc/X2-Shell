import QtQuick 2.15
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import Qt5Compat.GraphicalEffects

import "../../config/"

FocusScope {
    id: wall
    implicitWidth: tab.implicitWidth
    implicitHeight: tab.implicitHeight

    property string folderpath: "file:///home/titan/disk0/syscustom/wallpapers/"

    FolderListModel {
        id: wallpaperFolder
        folder: wall.folderpath
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
        showDirs: false
    }

    Process {
        id: wallpaperSetter
        command: []
    }

    Rectangle{
        id:tab // for frame
        implicitHeight: imgArea.implicitHeight+40
        implicitWidth: imgArea.implicitWidth

        radius: 10
        color: Colors.tab_bg
        border.color: Colors.tab_bor
        border.width: 2

        Rectangle {
            id: imgArea
            implicitWidth: 930  //1100
            implicitHeight: 370
            color: "transparent"
            clip: true
            anchors.centerIn: parent
            GridView {
                id: gv
                readonly property int cellSize: 180
                readonly property int columns: Math.max(1, Math.floor((imgArea.width - 20) / cellSize))

                width: columns * cellSize
                height: parent.height - 20
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                cellWidth: cellSize
                cellHeight: cellSize

                // keep off-screen pre-building small so first paint isn't hit
                // with a burst of image decodes + shader passes all at once
                cacheBuffer: 200

                model: wallpaperFolder

                delegate: Item {
                    width: gv.cellWidth
                    height: gv.cellHeight

                    Rectangle {
                        id: thumb
                        anchors.fill: parent
                        anchors.margins: 7
                        radius: 6
                        color: "Transparent"

                        Text {
                            id: loadingIcon

                            text: ""
                            anchors.centerIn: parent
                            opacity:0.2

                            color: Colors.t1

                            visible: img.status !== Image.Ready

                            scale: 1.0


                            SequentialAnimation on scale {
                                loops: Animation.Infinite

                                NumberAnimation {
                                    from: 1.0
                                    to: 3.5
                                    duration: 800
                                    easing.type: Easing.InOutQuad
                                }

                                NumberAnimation {
                                    from: 3.5
                                    to: 1.0
                                    duration: 800
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }


                        scale: mouseArea.pressed ? 0.92 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 120; easing.type: Easing.OutQuad }
                        }

                        Image {
                            id: img
                            anchors.fill: parent
                            source: fileUrl
                            asynchronous: true
                            cache: true
                            fillMode: Image.PreserveAspectCrop

                            // decode at thumbnail resolution instead of native
                            // (this is the biggest win - avoids decoding full-size
                            // images just to shrink them down to 180px)
                            sourceSize.width: thumb.width
                            sourceSize.height: thumb.height

                            // only apply the mask once the image has actually loaded,
                            // so we don't spin up shader/FBO work for every delegate
                            // the instant it's created
                            layer.enabled: status === Image.Ready
                            layer.effect: OpacityMask {
                                maskSource: Rectangle {
                                    width: img.width
                                    height: img.height
                                    radius: thumb.radius
                                }
                            }

                            opacity: status === Image.Ready ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 120 }
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                let path = img.source.toString().replace("file://", "");
                                wallpaperSetter.command = ["awww", "img", "--transition-type", "any", "--transition-duration", "2", "--transition-fps", "60", path];
                                wallpaperSetter.running = true;
                            }
                        }
                    }
                }
            }
        }
    }



}
//awww img --transition-type grow --transition-duration 2 --transition-fps 160 ~/.config/res/wallpapers/ac1.png