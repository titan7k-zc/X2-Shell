import "../../components"
import "../../services"
import "../../config"
import QtQuick 2.15
import QtQuick.Layouts

Item {
    id: ov

    implicitWidth: tab.implicitWidth
    implicitHeight: tab.implicitHeight
    property real rad:10

    Rectangle {
        id: tab // for frame

        implicitHeight: dasgArea.implicitHeight + 20
        implicitWidth: dasgArea.implicitWidth + 20
        radius: 10
        color: "Transparent"
        border.color: "Transparent"
        border.width: 2

        Rectangle {
            id: dasgArea

            implicitWidth: 1200
            implicitHeight: 400
            color: "Transparent"
            clip: true
            anchors.centerIn: parent
            radius: 10

            GridLayout {
                anchors.fill: parent
                anchors.margins: 10
                // columns: 4
                // rows: 2
                columnSpacing: 15
                rowSpacing: 15
                

                // date & time
                Rectangle {
                    Layout.column: 0
                    Layout.row: 0
                    Layout.rowSpan: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                    radius: ov.rad
                    color: Colors.sFG
                    

                    ColumnLayout {
                        anchors.centerIn: parent
                        width: parent.width * 0.9

                        spacing: 5


                        Text {
                            text: Time.hour + "\n" + Time.minute

                            color: Colors.tMain

                            font.family: "Nunito"
                            font.weight: Font.ExtraBold
                            font.letterSpacing:0
                            font.pixelSize: Math.min(
                                parent.parent.width * 0.5,
                                parent.parent.height * 0.6
                            )
                            

                            lineHeight: 0.7

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Text {
                            opacity: 0.7

                            text: Time.date
                            color: Colors.tLow

                            font.family: "Nunito"
                            font.weight: Font.Bold
                            font.pixelSize: parent.parent.height * 0.04

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                Rectangle {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: ov.rad
                    color: Colors.sFG


                    Row{
                        anchors.centerIn:parent
                        spacing:20
                        Rectangle{
                            anchors.verticalCenter:parent.verticalCenter
                            width:150
                            height:150
                            color:"Transparent"
                            radius:20


                            AnimatedImage {
                                anchors.fill: parent
                                source: "../../assets/gif/cute-cat-kawaii.gif"

                                fillMode: Image.PreserveAspectCrop
                                clip: true
                                opacity:0.7
                            }
                        }
                        Text{
                            anchors.verticalCenter:parent.verticalCenter
                            anchors.verticalCenterOffset:15
                            text:"󰌽  : X2 Shell\n  : Titan"
                            color:Colors.tMain
                            font.family: "Nunito"
                            font.weight: Font.Bold
                            font.pixelSize:20

                            // lineHeight:0.8

                        }
                    }


                    
                }

                Rectangle {
                    Layout.column: 3
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: ov.rad
                    color: Colors.sFG
                    
                }

                Rectangle {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: ov.rad
                    color: Colors.sFG
                    
                }

                Rectangle {
                    Layout.column: 2
                    Layout.row: 1
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: ov.rad
                    color: Colors.sFG

                }

                Rectangle {
                    Layout.column: 4
                    Layout.row: 0
                    Layout.rowSpan:2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: ov.rad
                    color: Colors.sFG
                    
                    SpotifyPlayer{
                        anchors.centerIn:parent
                        // anchors.verticalCenterOffset:-2
                        // anchors.horizontalCenterOffset:-2
                    }
                }
            }

        }

    }

}
