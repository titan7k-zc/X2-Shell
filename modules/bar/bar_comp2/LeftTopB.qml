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
        id: leftT
        anchors.left: parent.left
        anchors.top: parent.top
        width: root.wid
        height: root.hei + root.rad
        color: Colors.barBackgroundColor
        
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: root.wid
            height: root.hei
            bottomRightRadius: root.rad
            color: Colors.barBorderFallbackColor

            Rectangle{
                anchors.fill: parent
                bottomRightRadius: root.rad
                topLeftRadius: root.se
                color: Colors.barBorderColor
            
                Workspace {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 0
                }
            }

        }
    }

    MultiEffect {
        opacity: Colors.leftTopBarShadowOpacity
        shadowColor: Colors.leftTopBarShadowColor
        anchors.fill: leftT
        source: leftT

        shadowEnabled: true
        shadowBlur: 0.6
        shadowScale: 1
        shadowVerticalOffset:3
        shadowHorizontalOffset:2
        
    }

}
