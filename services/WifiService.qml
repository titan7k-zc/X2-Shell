pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    id: root

    // =========================
    // Wi-Fi devices
    // =========================

    // ObjectModel of every network device (Ethernet, Wi-Fi, ...)
    readonly property var devices: Networking.devices

    // Check whether a device is a Wi-Fi device.
    function isWifiDevice(device) {
        return !!device && device.type === DeviceType.Wifi
    }

    // Return all Wi-Fi devices.
    // NOTE: ObjectModel is not a JS array, the array lives in `.values`.
    function getWifiDevices() {
        return Networking.devices.values.filter(function(device) {
            return device.type === DeviceType.Wifi
        })
    }

    // The Wi-Fi adapter the panel works with (first one found).
    readonly property var primaryDevice: {
        var list = getWifiDevices()
        return list.length > 0 ? list[0] : null
    }

    // is any device available?
    readonly property bool available: primaryDevice !== null

    // is any device scanning?
    readonly property bool scanning: getWifiDevices().some(function(device) {
        return device.scannerEnabled
    })

    // Is Wi-Fi switched on? (global radio switch)
    readonly property bool enabled: Networking.wifiEnabled

    // The network we are currently connected to (or null)
    readonly property var connectedNetwork: {
        var dev = primaryDevice
        if (!dev || !dev.networks)
            return null

        var list = dev.networks.values.filter(function(n) {
            return n.connected
        })
        return list.length > 0 ? list[0] : null
    }

    // Sorted list for the UI: connected first, then strongest signal, then A-Z.
    // ScriptModel diffs the list, so ListView add/remove/displaced animations work.
    ScriptModel {
        id: networkModel
        values: root.buildNetworkList()
    }

    property alias networks: networkModel

    function buildNetworkList() {
        var dev = primaryDevice
        if (!dev || !dev.networks)
            return []

        return dev.networks.values
            .filter(function(n) {
                return n.name && n.name.length > 0   // hide hidden SSIDs
            })
            .sort(function(a, b) {
                if (a.connected !== b.connected)
                    return a.connected ? -1 : 1

                // bucketed so the list doesn't jitter on tiny signal changes
                var sa = Math.round(a.signalStrength * 4)
                var sb = Math.round(b.signalStrength * 4)
                if (sa !== sb)
                    return sb - sa

                return a.name.localeCompare(b.name)
            })
    }


    // Radio / scanning ----------------------------------------------------------------------

    function setEnabled(value) {
        Networking.wifiEnabled = value
    }

    function toggle() {
        Networking.wifiEnabled = !Networking.wifiEnabled
    }

    // With a device: toggles that device. Without: toggles all Wi-Fi devices.
    function toggleScanning(device) {
        if (device) {
            if (!isWifiDevice(device))
                return

            device.scannerEnabled = !device.scannerEnabled
            return
        }

        var target = !scanning
        getWifiDevices().forEach(function(d) {
            d.scannerEnabled = target
        })
    }

    function startScanning(device) {
        if (device) {
            if (isWifiDevice(device))
                device.scannerEnabled = true
            return
        }

        getWifiDevices().forEach(function(d) {
            d.scannerEnabled = true
        })
    }

    function stopScanning(device) {
        if (device) {
            if (isWifiDevice(device))
                device.scannerEnabled = false
            return
        }

        getWifiDevices().forEach(function(d) {
            d.scannerEnabled = false
        })
    }


    // connections related functions ----------------------------------------------------------------------

    function isOpen(network) {
        if (!network)
            return false

        return WifiSecurityType.toString(network.security) === "Open"
    }

    function isPasswordRequired(network) {
        if (!network)
            return false

        return !isOpen(network) && !network.known
    }

    // connect wifi
    function connectNetwork(network, password) {
        if (!network || network.stateChanging)
            return

        // Open / known
        if (!isPasswordRequired(network)) {
            network.connect()
            return
        }

        // Password required network
        if (password && password.length > 0) {
            network.connectWithPsk(password)
        } else {
            console.log("Wi-Fi password is required:", network.name)
        }
    }

    // disconnect wifi
    function disconnectNetwork(network) {
        if (!network || network.stateChanging)
            return

        if (network.connected)
            network.disconnect()
    }

    // toggle connection
    function toggleConnection(network, password) {
        if (!network || network.stateChanging)
            return

        if (network.connected) {
            disconnectNetwork(network)
        } else {
            connectNetwork(network, password)
        }
    }

     // forget
    function forgetNetwork(network) {
        if (!network || network.stateChanging)
            return

        if (network.known)
            network.forget()
    }


    // info helpers ----------------------------------------------------------------------

    function connectionState(network) {
        if (!network)
            return ""

        return ConnectionState.toString(network.state)
    }

    function securityType(network) {
        if (!network)
            return ""

        return WifiSecurityType.toString(network.security)
    }

    // Short, human friendly security name ("Open", "WPA2", "WPA3", ...)
    function securityLabel(network) {
        var s = securityType(network).toLowerCase()

        if (s === "open")
            return "Open"
        if (s.indexOf("wpa3") !== -1 || s.indexOf("sae") !== -1)
            return "WPA3"
        if (s.indexOf("wpa2") !== -1)
            return "WPA2"
        if (s.indexOf("wpa") !== -1)
            return "WPA"
        if (s.indexOf("wep") !== -1)
            return "WEP"

        return "Secured"
    }

    // 0..100
    function signalPercent(network) {
        if (!network)
            return 0

        return Math.round(Math.max(0, Math.min(1, network.signalStrength)) * 100)
    }


    // Text for a failed connection attempt
    function failureText(reason) {
        var name = ""

        try {
            name = ConnectionFailReason.toString(reason)
        } catch (e) {
            name = ""
        }

        if (name === "NoSecrets" || name === "WifiAuthTimeout")
            return "Wrong password"
        if (name === "WifiNetworkLost")
            return "Network lost"

        return "Connection failed"
    }

    // network status (second line of a network card)
    function networkStatus(network, errorReason) {
        if (!network)
            return "Unavailable"

        if (network.stateChanging)
            return connectionState(network) === "Disconnecting" ? "Disconnecting…" : "Connecting…"

        if (network.connected)
            return "Connected · " + securityLabel(network)

        // Custom connection error
        // (the old version was missing braces here, so it always returned errorReason)
        if (errorReason && errorReason.length > 0) {
            console.log("Connection error:", errorReason)
            return errorReason
        }

        if (network.known)
            return "Saved · " + securityLabel(network)

        return "Available · " + securityLabel(network)
    }

    Component.onCompleted: {
        console.log("========== WIFI SERVICE ==========")
        console.log("Available:", available)
        console.log("Wi-Fi enabled:", Networking.wifiEnabled)
        console.log("Wi-Fi devices:", getWifiDevices().length)

        for (const device of getWifiDevices()) {
            console.log(
                "Device:", device.name,
                "Scanning:", device.scannerEnabled
            )
        }
    }
}
