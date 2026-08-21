import QtQuick
import Quickshell.Io

import "../pops"

Item{
    id:root
    property alias powerPop:right_power_pop.show

    MainMP{
        id:right_power_pop
        show:false
        anchorRight:true

        rad:20
        
        file:"../powerMenu/PowerMenu.qml"
    }


    IpcHandler {
        target: "pop"


        function power() {
            right_power_pop.show=!right_power_pop.show;
        }

    }
}