pragma Singleton

import QtQuick

QtObject {
    property list<var> allowedWindows: []
    property bool multiLayer: false
    property bool showWidgets: true
    property bool dnd: false 
}