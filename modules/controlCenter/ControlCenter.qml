import QtQuick
import Quickshell
import "../wifi"
import "../bluetooth"

Item{
    implicitHeight: panel.height
    implicitWidth: panel.width
    Rectangle{
        id:panel
        width:450
        height:1400
        color:"Transparent"
        

     

        Column{
            spacing:20
            anchors.margins:30
            anchors.leftMargin:20
            anchors.rightMargin:20
            
            anchors.fill:parent
            anchors.horizontalCenter: parent.horizontalCenter
            WifiPanel{id:wp}
            BluetoothPanel{id:bp}

            Component.onCompleted:{
                console.log("wp.width: "+wp.width+" wp.height: "+wp.height)
                console.log("bp.width: "+bp.width+" bp.height: "+bp.height)
            }
        }
        
        

    }
}