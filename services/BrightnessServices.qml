pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real brightness: 1.0
    property bool ready: false
    property real step: 0.05

    readonly property int pct: Math.round(brightness * 100)

    function setBrightness(value) {
        value = Math.max(0, Math.min(1, value))
        brightness = value
        setProc.command = ["brightnessctl", "set", Math.round(value * 100) + "%"]
        setProc.running = true
    }

    function increase() { setBrightness(brightness + step) }
    function decrease() { setBrightness(brightness - step) }
    function toggle() { setBrightness(brightness <= 0.01 ? 1.0 : 0.0) }

    function refresh() { getProc.running = true }

    Process {
        id: getProc
        command: ["brightnessctl", "-m", "info"]
        stdout: SplitParser {
            onRead: data => {
                const parts = data.trim().split(",")
                if (parts.length >= 4) {
                    root.brightness = parseInt(parts[3].replace("%", "")) / 100
                    root.ready = true
                }
            }
        }
    }

    Process { id: setProc }

    Component.onCompleted: refresh()
}