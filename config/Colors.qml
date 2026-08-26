import QtQuick
import Quickshell
pragma Singleton

Singleton{
    id:root

//Qt.rgba(Colors.tMain.r,Colors.tMain.g,Colors.tMain.b,0.8)


    // ===> Shape
    property color sBG:"#000000"            // bar bg
    property color sFG:'#00b3b3b3'        // overview rectangles - #2d393939

    // ===> Text
    property color tMain: '#959595'         // main text color 4e495f
    property color tLow: '#c8959595'        // date color in overview 79949494

    // ===> Item
    property color iMain: tMain         // normal 
    property color iAlive: '#ffffff'        // any data or blink 
    property color iActive:'#ef2a68'//'#ef2a68'       // active color

    
    property color iFocus: tMain              // bar bottom 
    property color iFocusLow: "#21949494"            // applauncher select focus
    property color iFocusHeigh: iActive       // power active


    property color mWarning:iActive//'#ef2a68'      
    property color mNormal:tMain      


}