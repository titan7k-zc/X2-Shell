import QtQuick
import Quickshell
pragma Singleton

Singleton{
    id:root
    
    //================================ Colors
    
    // main colors
    property color t1: '#4e495f' //4e495f   - text
    property color ic: '#4e495f' //a77ad9a8   - text
    property color ic_n: '#787090' //a77ad9a8   - text
    property color ic_s: '#005a92' //a77ad9a8   - text
    
    
    // bar bg
    property color bar_bg:'#000000'

    // overview 
    property color ov_bg:'#002f2f2f'


    // wallpaper Switcher
    property color tab_bg: '#00000000'
    property color tab_bor: '#004e495f'


    // time
    property color tim: root.t1
    

    // volume
    property color vol: root.t1
    property color voli:root.ic


    // battery
    property color bat: root.t1
    property color batin:root.ic
        //--- stoped (temp)
    property color batic:"#ff5048"
    property color baticn:"#ffa478"


    // workspaces /3dd1b0
    property color wf:ic_s//"#3dd1b0"
    property color wa:ic_n//"#f5e2c5"
    property color wn:root.ic


















}