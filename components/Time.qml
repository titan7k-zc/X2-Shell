import "../config"
import QtQuick
import Quickshell


Row {
    id: root
    required property bool show

    readonly property string date: {
        // Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
        Qt.formatDateTime(clock.date, "yyyy MMM d") //"yy/M/d hh:mm"
    }
    readonly property string hou: {
        // Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
        Qt.formatDateTime(clock.date, "hh") //"yy/M/d hh:mm"
    }
    readonly property string mini: {
        // Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
        Qt.formatDateTime(clock.date, "mm") //"yy/M/d hh:mm"
    }






    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }




    // clock1 (s)
    Text {
        id:txt
        text:root.hou+":"+root.mini
        visible:root.show
        font {
            family: "Quicksand"
            letterSpacing: 0
            pixelSize: 20
            weight: Font.Bold
        }

        color:Theme.tim
    }


}
