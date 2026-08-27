pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland

Singleton {
    id: root

    property var windows: []

    function rebuild() {
        const active = ToplevelManager.activeToplevel;
        const list = [...ToplevelManager.toplevels.values];

        // list.sort((a, b) => {
        //     const aActive = a === active ? 0 : 1
        //     const bActive = b === active ? 0 : 1
        //     return aActive - bActive
        // })

        windows = list;

        // console.log("Taskbar windows:", windows.length)

        // for (const win of windows) {
        //     console.log(" -", win.appId, "|", win.title)
        // }
    }

    function activate(toplevel) {
        if (toplevel)
            toplevel.activate();
    }

    Component.onCompleted: rebuild()

    Connections {
        target: ToplevelManager

        function onActiveToplevelChanged() {
            root.rebuild();
        }
    }

    Connections {
        target: ToplevelManager.toplevels

        function onObjectInsertedPost() {
            root.rebuild();
        }

        function onObjectRemovedPost() {
            root.rebuild();
        }
    }
}
