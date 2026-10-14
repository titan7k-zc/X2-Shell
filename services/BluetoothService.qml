pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io

Singleton {
    id: root

    Process {
        id: bluetoothAgent

        running: true
        command: [
            "bluetoothctl",
            "--timeout",
            "86400",
            "agent",
            "NoInputNoOutput"
        ]
    }

    // // Adapter
    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool available: !!adapter
    readonly property bool enabled: adapter ? adapter.enabled : false
    readonly property bool discovering: adapter ? adapter.discovering : false

    // // Devices
    readonly property var devices: Bluetooth.devices
  

    // Adapter controls ==========================
    function toggle() {
        if (!adapter)
            return
        adapter.enabled = !adapter.enabled
    }

    function enable() {
        if (!adapter)
            return
        adapter.enabled = true
    }

    function disable() {
        if (!adapter)
            return
        adapter.enabled = false
    }

    // Discovery ==========================
    function startDiscovery() {
        if (!adapter)
            return
        if (!adapter.enabled)
            return
        adapter.discovering = true
    }

    function stopDiscovery() {
        if (!adapter)
            return
        adapter.discovering = false
    }

    function toggleDiscovery() {
        if (!adapter)
            return
        if (!adapter.enabled)
            return
        adapter.discovering = !adapter.discovering
    }





    // Connect 
    function connectDevice(device) {
        if (!device)
            return
        if (device.connected)
            return
        if (device.pairing)
            return
        if (device.state === BluetoothDeviceState.Connecting || device.state === BluetoothDeviceState.Disconnecting)
            return

        console.log("Bluetooth: connect requested:", device.name,"paired:", device.paired, "bonded:", device.bonded)
        stopDiscovery()

        if (device.paired || device.bonded) {
            device.trusted = true
            device.connect()
        } else {
            console.log("Bluetooth: NEW DEVICE -> pair():", device.name, device.address)
            device.pair()   // onPairedChanged will call connect()
        }
    }

    // Disconnect
    function disconnectDevice(device) {
        device.disconnect()
    }

    // Pair
    function pairDevice(device) {
        if (device.connected)
            return
        if (device.pairing)
            return
        if (device.pairing)
            return
        device.pair()
    }

    // Cancel pairing
    function cancelPairing(device) {
        device.cancelPair()
    }

    // Forget
    function forgetDevice(device) {
        console.log("forgoting")
        device.forget()
    }



    // Forget all Bluetooth unknown devices.
    function clearUnknown() {
        // console.log("Bluetooth: starting cleanup")

        const deviceList = devices.values

        // console.log("Device list:", deviceList)
        // console.log("Device count:", deviceList.length)

        deviceList.forEach(function(device) {
            if (!device)
                return

            console.log(
                "Checking:", device.name,
                "Connected:", device.connected,
                "Paired:", device.paired,
                "Bonded:", device.bonded
            )

            if (device.connected || device.paired || device.bonded)
                return

            console.log("Forgetting:", device.name)
            root.forgetDevice(device)
        })
    }







    // Status
    function status(device) {
        if (!device)
            return ""
        if (device.connected)
            return "Connected"
        if (device.state === BluetoothDeviceState.Connecting)
            return "Connecting..."
        if (device.state === BluetoothDeviceState.Disconnecting)
            return "Disconnecting..."
        if (device.pairing)
            return "Pairing..."
        if (device.paired || device.bonded)
            return "Paired"
        return "Available"
    }

    // Icon 
    function icon(device) {
        if (!device)
            return ""

        switch (device.icon) {
        case "audio-headphones":
            return "\uf025"
        case "audio-headset":
            return "󰋎"
        case "audio-card":
            return "\uf028"
        case "phone":
            return "\uf10b"
        case "computer":
            return "\uf108"
        case "input-keyboard":
            return "\uf11c"
        case "input-mouse":
            return "󰍽"
        case "input-gaming":
            return "\uf11b"
        default:
            return "\uf293"
        }
    }

    // Battery
    function batteryPercent(device) {
        if (!device)
            return 0
        if (!device.batteryAvailable)
            return 0
        return Math.round(device.battery * 100)
    }

 
    function toggleDevice(device) {
        if (!device)
            return
        if (device.connected) {
            disconnectDevice(device)
            return
        }
        if (device.pairing) {
            cancelPairing(device)
            return
        }
        if (device.state === BluetoothDeviceState.Connecting ||
            device.state === BluetoothDeviceState.Disconnecting) {
            return
        }
        if (device.paired || device.bonded) {
            connectDevice(device)
            return
        }
        pairDevice(device)
    }





//     // MOCK BLUETOOTH DATA — for UI testing
//     readonly property var adapter: null
//     readonly property bool available: true
//     readonly property bool enabled: true
//     readonly property bool discovering: false

//     readonly property var devices: [
//     {
//         name: "UGREEN LightBuds Pro",
//         address: "A1:B2:C3:D4:E5:F6",
//         paired: true,
//         connected: false,
//         battery: 85
//     },
//     {
//         name: "Sony WH-1000XM5 Wireless Noise Cancelling Headphones",
//         address: "11:22:33:44:55:66",
//         paired: true,
//         connected: false,
//         battery: 42
//     },
//     {
//         name: "Logitech MX Master 3S",
//         address: "AA:BB:CC:DD:EE:FF",
//         paired: true,
//         connected: true,
//         battery: 100
//     },
//     {
//         name: "Unknown Device",
//         address: "12:34:56:78:9A:BC",
//         paired: false,
//         connected: false,
//         battery: -1
//     },
//     {
//         name: "Mechanical Keyboard",
//         address: "FE:DC:BA:98:76:54",
//         paired: true,
//         connected: false,
//         battery: 15
//     },
//     {
//         name: "Mechanical Keyboard2",
//         address: "FE:DC:BA:98:76:54",
//         paired: true,
//         connected: false,
//         battery: 15
//     },
//     {
//         name: "Mechanical Keyboard3",
//         address: "FE:DC:BA:98:76:54",
//         paired: true,
//         connected: false,
//         battery: 15
//     }
// ]












}
