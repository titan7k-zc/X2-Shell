pragma Singleton
import QtQuick
import Quickshell
import QtCore

Singleton {
    id:root

    Settings {
        id: controls
        property bool m_layer: false
        property bool s_Widgets: false
        property bool f_Dnd: false
    }
    property list<var> allowedWindows: []  

    property alias multiLayer: controls.m_layer
    property alias showWidgets: controls.s_Widgets
    property alias dnd: controls.f_Dnd
}