import QtQuick
import Quickshell
pragma Singleton

Singleton{
    id:root



    // ===> Shape
    property color sBG:"#000000"            // bar bg
    property color sFG:'#344e495f'        // overview rectangles - #2d393939

    // ===> Text
    property color tMain: '#4e495f'         // main text color
    property color tLow: '#79949494'        // date color in overview

    // ===> Item
    property color iMain: '#4e495f'         // normal 
    property color iAlive: '#968383'        // any data or blink 
    property color iActive: '#ef2a68'       // active color
    
    property color iFocus: tMain              // bar bottom 
    property color iFocusLow: "#21949494"            // applauncher select focus
    property color iFocusHeigh: iActive       // power active




}