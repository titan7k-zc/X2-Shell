import Singleton
import QtQuick
import QtCore
import Quickshell

QtObject{
    id:root
    property bool appVisible:false
    property var recentIds:[]

    property var _settings:Settings{
        category:"AppLauncher"
    }
}

