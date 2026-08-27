import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../config"
import "../services"


// cash img path ->/home/titan/.cache/quickshell/by-shell


Item {
    id: root
    // height: 180
    // width: height * 2
    width: 180
    height: width * 1.8


    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "Transparent"

        ColumnLayout {
            anchors.fill: parent
            spacing: 20

            // ---------------- album art ----------------
            ClippingRectangle {
                id: albumArt
                Layout.preferredWidth: Math.min(root.width, root.height)
                Layout.preferredHeight: Layout.preferredWidth
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                radius: Layout.preferredWidth / 2
                opacity: 0.7
                color: "#2a2a35"

                antialiasing: true
                layer.enabled: true
                layer.smooth: true
                layer.samples: 4   // try 8 if it's still visibly rough

                Image {
                    id: artImage
                    anchors.fill: parent
                    source: SpotifyServices.displayArtSource
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    cache: false
                    antialiasing: true
                    onStatusChanged: {
                        if (status === Image.Error &&
                            source.toString() !== ("file://" + SpotifyServices.artCachePath)) {
                            source = "file://" + SpotifyServices.artCachePath;
                        }
                    }
                }
            }

            //     // placeholder when there's truly nothing to show yet
            //     Text {
            //         anchors.centerIn: parent
            //         visible: artImage.status !== Image.Ready
            //         text: SpotifyServices.running ? "" : "\u266B"
            //         color: "#55555f"
            //         font.pixelSize: 96
            //     }
            // }

            // ---------------- track info ----------------
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 2

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth: Math.min(root.height,root.width)-20
                    text: SpotifyServices.displayTitle
                    color: Colors.tMain
                    font.pixelSize: 18
                    font.bold: true
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth: Math.min(root.height,root.width)-20
                    text: SpotifyServices.displayArtist
                    color: Colors.tLow
                    font.pixelSize: 13
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }

                // ---------------- controls: prev / play-pause / next ----------------
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 5

                    Rectangle {
                        width: 35; height: width; radius: width / 2
                        color: Colors.tMain//"#26262e"
                        scale: prevArea.pressed ? 0.9 : 1
                        Text {
                            anchors.centerIn: parent
                            text: "\u23EE"
                            color: Colors.sBG
                            font.pixelSize: 22
                        }
                        MouseArea {
                            id: prevArea
                            anchors.fill: parent
                            onClicked: SpotifyServices.previous()
                        }
                    }

                    Rectangle {
                        width: 45; height: width; radius: width / 2
                        color: Qt.rgba(Colors.iActive.r,Colors.iActive.g,Colors.iActive.b,0.8)//'#941db954'
                        scale: playArea.pressed ? 0.9 : 1
                        Text {
                            anchors.centerIn: parent
                            text: SpotifyServices.player && SpotifyServices.player.isPlaying ? "\u23F8" : "\u25B6"
                            anchors.horizontalCenterOffset: text === "\u25B6" ? 2.5 : 0
                            anchors.verticalCenterOffset: text === "\u25B6" ? 0.8 : 0
                            color: Colors.sBG
                            font.pixelSize: 26
                        }
                        MouseArea {
                            id: playArea
                            anchors.fill: parent
                            onClicked: SpotifyServices.playPause()
                        }
                    }

                    Rectangle {
                        width: 35; height: width; radius: width / 2
                        color: Colors.tMain//"#26262e"
                        scale: nextArea.pressed ? 0.9 : 1
                        Text {
                            anchors.centerIn: parent
                            text: "\u23ED"
                            color: Colors.sBG
                            font.pixelSize: 22
                        }
                        MouseArea {
                            id: nextArea
                            anchors.fill: parent
                            onClicked: SpotifyServices.next()
                        }
                    }
                }
            }
        }
    }
}
