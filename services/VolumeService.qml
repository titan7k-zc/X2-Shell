pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Singleton {
    id: root

    property var sink: Pipewire.defaultAudioSink

    property real volumeStep: 0.05
    property string activePort: ""

    readonly property bool ready:
        sink !== null && sink.ready

    readonly property bool muted:
        ready && sink.audio.muted

    readonly property real volume:
        ready ? sink.audio.volume : 0

    readonly property int vol:
        Math.round(volume * 100)

    readonly property var props:
        ready ? sink.properties : ({})

    readonly property string deviceKind: {
        if (!ready)
            return "none"

        const bus = props["device.bus"] || ""
        const form = props["device.form-factor"] || ""

        const isBt =
            bus === "bluetooth" ||
            !!props["api.bluez5.address"]

        if (isBt)
            return "bluetooth"

        if (
            activePort.includes("headphone") ||
            form === "headset" ||
            form === "headphone"
        )
            return "headphone"

        if (
            activePort.includes("speaker") ||
            form === "speaker"
        )
            return "speaker"

        return "unknown"
    }

    readonly property string monLs:
        // muted + "|" +
        deviceKind

    onMonLsChanged: {
        CavaServices.restart()
        // console.log("cava restart form volume service")
    }

    readonly property string icon: {
        if (!ready)
            return String.fromCodePoint(0xf0581)

        if (muted)
            return ""

        switch (deviceKind) {

        case "bluetooth":
            return ""

        case "headphone":
            return "\uf025"

        case "speaker":
        default:
            if (vol === 0)
                return ""

            if (vol <= 34)
                return ""

            if (vol <= 64)
                return ""

            return String.fromCodePoint(0xf057e)
        }
    }

    // ---------------------------------------------------------
    // Active port detection
    // ---------------------------------------------------------

    Process {
        id: portProbe

        running: false

        command: [
            "sh",
            "-c",
            "pactl list sinks | awk '/^\\\tActive Port:/{print $3}'"
        ]

        stdout: SplitParser {
            onRead: data => {
                root.activePort = data.trim()
            }
        }
    }

    function refreshPort() {
        portProbe.running = false
        portProbe.running = true
    }

    // ---------------------------------------------------------
    // PipeWire / PulseAudio event listener
    // ---------------------------------------------------------

    Process {
        id: subscriber

        running: true

        command: [
            "pactl",
            "subscribe"
        ]

        stdout: SplitParser {
            onRead: line => {

                if (line.includes("sink"))
                    root.refreshPort()
            }
        }
    }

    // ---------------------------------------------------------
    // Volume controls
    // ---------------------------------------------------------

    function toggleMute() {
        if (!ready)
            return

        sink.audio.muted = !sink.audio.muted
    }

    function increaseVolume() {
        if (!ready)
            return

        sink.audio.volume = Math.min(
            volume + volumeStep,
            1.0
        )
    }

    function decreaseVolume() {
        if (!ready)
            return

        sink.audio.volume = Math.max(
            volume - volumeStep,
            0.0
        )
    }

    function setVolume(value) {
        if (!ready)
            return

        sink.audio.volume = Math.max(
            0.0,
            Math.min(value, 1.0)
        )
    }

    Component.onCompleted: {
        refreshPort()
    }

    onSinkChanged: {
        refreshPort()
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}