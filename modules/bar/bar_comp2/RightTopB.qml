import QtQuick
import QtQuick.Effects

import "../../../config"
import "../../../components"

Item {
    id:root
    implicitWidth: wid
    implicitHeight: hei 
    required property int rad
    required property int se
    property int hei: 40
    property int wid: 240


    Rectangle {
        id: rightT
        anchors.right: parent.right
        anchors.top: parent.top
        width: root.wid
        height: root.hei + root.rad
        color: Colors.barBackgroundColor
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            width: root.wid
            height: root.hei
            bottomLeftRadius: root.rad
            color: Colors.barBorderFallbackColor

            Rectangle{
                anchors.fill: parent
                topRightRadius: root.se
                bottomLeftRadius: root.rad
                color: Colors.barBorderColor
                
                Row{
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 0

                    spacing: 5

                    Rectangle{
                        width: bat.implicitWidth+20
                        height: 35
                        radius: 6
                        color: Colors.barPowerTransparentColor
                        Brightness{id:brig;anchors.centerIn: parent}
                    }

                    Rectangle{
                        width: sou.implicitWidth+20
                        height: 35
                        radius: 6
                        color: Colors.barPowerTransparentColor
                        Volume{id:sou;anchors.centerIn: parent}
                    }

                    Rectangle{
                        width: bat.implicitWidth+20
                        height: 35
                        radius: 6
                        color: Colors.barPowerTransparentColor
                        Battery{id:bat;anchors.centerIn: parent}
                    }
                }
                
            }



        }


    }
    MultiEffect {
        opacity: Colors.rightTopBarShadowOpacity
        shadowColor: Colors.rightTopBarShadowColor
        anchors.fill: rightT
        source: rightT

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        shadowVerticalOffset:3
        shadowHorizontalOffset:-2
        
    }




}
