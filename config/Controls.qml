pragma Singleton

import QtQuick

QtObject {
    property list<var> allowedWindows: []
    property bool multiLayer: false
    property bool showWidgets: false
    property bool dnd: false 
}