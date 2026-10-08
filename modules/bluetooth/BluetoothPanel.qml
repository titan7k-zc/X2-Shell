import QtQuick
import QtQuick.Shapes
import "../../services"
import "../../config"

Item {
    id: root


    // -----------------------------------
    // Theme 
    // -----------------------------------
    // Surfaces
    property color backgroundColor: Colors.bluetoothBackgroundColor
    property color headerColor: Colors.bluetoothHeaderColor
    property color deviceBackgroundColor: Colors.bluetoothDeviceBackgroundColor
    property color deviceColor: Colors.bluetoothDeviceColor
    property color deviceConnectedColor: Colors.bluetoothDeviceConnectedColor

    // Text
    property color primaryTextColor: Colors.bluetoothPrimaryTextColor
    property color secondaryTextColor: Colors.bluetoothSecondaryTextColor
    property color mutedTextColor: Colors.bluetoothMutedTextColor

    // Bluetooth
    property color bluetoothActiveColor: Colors.bluetoothActiveColor
    property color bluetoothInactiveColor: Colors.bluetoothInactiveColor

    // Toggle
    property color toggleOnColor: Colors.bluetoothToggleOnColor
    property color toggleOffColor: Colors.bluetoothToggleOffColor
    property color toggleKnobOnColor: Colors.bluetoothToggleKnobOnColor
    property color toggleKnobOffColor: Colors.bluetoothToggleKnobOffColor

    // Scan button (sits on the header, so it needs to be lighter than it)
    property color scanColor: Colors.bluetoothScanColor
    property color scanActiveColor: Colors.bluetoothScanActiveColor
    property color scanDisabledColor: Colors.bluetoothScanDisabledColor

    // Battery
    property color batteryColor: Colors.bluetoothBatteryColor
    property color batteryLowColor: Colors.bluetoothBatteryLowColor

    // Fonts / glyphs - Nerd Font.
    property string fontFamily: "Quicksand"
    property string bluetoothGlyph: "\uf293"

    // -----------------------------------
    // Layout metrics
    // -----------------------------------
    readonly property int panelPadding: 8
    readonly property int headerHeight: 64
    readonly property int sectionGap: 8
    readonly property int listPadding: 8
    readonly property int listSpacing: 6
    readonly property int cardHeight: 64
    readonly property int maxListHeight: 330
    readonly property int emptyHeight: 176

    // -----------------------------------
    // State
    // -----------------------------------
    readonly property bool btAvailable: BluetoothService.available
    readonly property bool btEnabled: BluetoothService.enabled
    readonly property bool btScanning: BluetoothService.enabled && BluetoothService.discovering

    // Text shown under the title. Hovering the scan button explains it,
    // which is what the old text label used to do.
    readonly property string statusText: {
        if (!btAvailable)
            return "Unavailable"
        if (!btEnabled)
            return "Off"
        if (scanArea.containsMouse)
            return btScanning ? "Stop scanning" : "Scan for devices"
        if (btScanning)
            return "Scanning…"
        return "On"
    }

    // Height of the device section (0 when Bluetooth is off), animated.
    readonly property real listCardTarget: {
        var n = deviceList.count
        if (n === 0)
            return emptyHeight
        var content = n * cardHeight + (n - 1) * listSpacing + 2 * listPadding
        return Math.min(maxListHeight, content) 
    }

    readonly property real bodyTarget: btEnabled ? sectionGap + listCardTarget : 0
    property real bodyHeight: bodyTarget

    Behavior on bodyHeight {
        NumberAnimation {
            duration: 340
            easing.type: Easing.OutCubic
        }
    }

    // Opening animation (0 → 1)
    property real openProgress: 0

    Behavior on openProgress {
        NumberAnimation {
            duration: 420
            easing.type: Easing.OutBack
            easing.overshoot: 0.8
        }
    }

    Component.onCompleted: openProgress = 1
    onVisibleChanged: openProgress = visible ? 1 : 0

    function withAlpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    implicitWidth: panel.width 
    implicitHeight: maxListHeight + (panelPadding*4) + headerHeight //panel.height



    // -----------------------------------
    // Radar icon — used in scan button and the empty state.
    // -----------------------------------
    component RadarIcon: Item {
        id: radar

        property color color: "red"//Colors.bluetoothPrimaryTextColor
        property bool active: false
        property real size: 24
        readonly property real ringWidth: Math.max(1.5, size * 0.075)

        width: size
        height: size

        function alpha(a) {
            return Qt.rgba(color.r, color.g, color.b, a)
        }

        // Outer ring
        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "transparent"
            border.width: radar.ringWidth
            border.color: radar.color
            opacity: radar.active ? 0.9 : 0.55

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }
        }

        // Inner ring (idle only)
        Rectangle {
            anchors.centerIn: parent
            width: radar.size * 0.58
            height: width
            radius: width / 2
            color: "transparent"
            border.width: radar.ringWidth * 0.8
            border.color: radar.color
            opacity: radar.active ? 0 : 0.4

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }
        }

        // Ping ring expanding from the center
        Rectangle {
            id: ping

            anchors.centerIn: parent
            width: radar.size * 0.2
            height: width
            radius: width / 2
            color: "transparent"
            border.width: radar.ringWidth * 0.8
            border.color: radar.color
            opacity: 0

            ParallelAnimation {
                running: radar.active
                loops: Animation.Infinite
                alwaysRunToEnd: true

                NumberAnimation {
                    target: ping
                    property: "width"
                    from: radar.size * 0.2
                    to: radar.size * 0.95
                    duration: 1000
                    easing.type: Easing.OutCubic
                }

                NumberAnimation {
                    target: ping
                    property: "opacity"
                    from: 0.8
                    to: 0
                    duration: 1000
                    easing.type: Easing.OutQuad
                }
            }
        }

        // Center dot
        Rectangle {
            id: dot

            anchors.centerIn: parent
            width: radar.size * 0.24
            height: width
            radius: width / 2
            color: radar.color

            SequentialAnimation {
                running: radar.active
                loops: Animation.Infinite
                alwaysRunToEnd: true

                NumberAnimation {
                    target: dot
                    property: "scale"
                    to: 1.35
                    duration: 450
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    target: dot
                    property: "scale"
                    to: 1.0
                    duration: 450
                    easing.type: Easing.InOutSine
                }
            }
        }
    }

    // -----------------------------------
    // Panel
    // -----------------------------------

    Rectangle {
        id: panel

        x: 0
        y: 0
        width: 450
        height: root.panelPadding * 2 + root.headerHeight + root.bodyHeight

        radius: 20
        color: root.backgroundColor

        border.width: 1
        border.color: root.withAlpha(root.primaryTextColor, 0.06)

        opacity: Math.min(1, root.openProgress * 1.6)
        scale: 0.94 + 0.06 * root.openProgress
        transformOrigin: Item.Top

        transform: Translate {
            y: (1 - root.openProgress) * -12
        }

        // -----------------------------------------------------
        // Header
        // -----------------------------------------------------

        Rectangle {
            id: header

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: root.panelPadding
            }

            height: root.headerHeight
            radius: 14
            color: root.headerColor

            // Bluetooth badge
            Rectangle {
                id: badge

                width: 44
                height: 44
                radius: 14

                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                color: root.btEnabled ? root.withAlpha(root.bluetoothActiveColor, 0.16) : root.withAlpha(root.mutedTextColor, 0.10)

                Behavior on color {
                    ColorAnimation { duration: 260 }
                }

                Text {
                    anchors.centerIn: parent
                    text: root.bluetoothGlyph
                    font.pixelSize: 22
                    color: root.btEnabled ? root.bluetoothActiveColor : root.bluetoothInactiveColor
                    Behavior on color {
                        ColorAnimation { duration: 260 }
                    }
                }

                SequentialAnimation {
                    id: badgeBounce

                    NumberAnimation {
                        target: badge
                        property: "scale"
                        to: 0.8
                        duration: 90
                        easing.type: Easing.OutQuad
                    }

                    NumberAnimation {
                        target: badge
                        property: "scale"
                        to: 1.0
                        duration: 380
                        easing.type: Easing.OutBack
                        easing.overshoot: 2.2
                    }
                }

                Connections {
                    target: BluetoothService

                    function onEnabledChanged() {
                        badgeBounce.restart()
                    }
                }
            }

            // Title + status
            Column {
                id: titleColumn

                anchors.left: badge.right
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter

                spacing: 1

                Text {
                    text: "Bluetooth"
                    color: root.primaryTextColor
                    font.pixelSize: 16
                    font.family: root.fontFamily
                    font.weight: Font.ExtraBold
                }

                // Status text cross-fades with a small vertical slide
                Item {
                    id: statusItem

                    property string value: root.statusText
                    property string shown: ""

                    width: statusLabel.implicitWidth
                    height: statusLabel.implicitHeight

                    Component.onCompleted: shown = value

                    onValueChanged: {
                        if (shown !== "")
                            swapStatus.restart()
                    }

                    Text {
                        id: statusLabel

                        text: statusItem.shown
                        font.family: root.fontFamily
                        font.weight: Font.Bold
                        font.pixelSize: 11

                        color: root.btScanning
                               ? root.bluetoothActiveColor
                               : root.secondaryTextColor

                        Behavior on color {
                            ColorAnimation { duration: 250 }
                        }
                    }

                    SequentialAnimation {
                        id: swapStatus

                        ParallelAnimation {
                            NumberAnimation {
                                target: statusLabel
                                property: "opacity"
                                to: 0
                                duration: 90
                                easing.type: Easing.InQuad
                            }

                            NumberAnimation {
                                target: statusLabel
                                property: "y"
                                to: -4
                                duration: 90
                                easing.type: Easing.InQuad
                            }
                        }

                        ScriptAction {
                            script: {
                                statusItem.shown = statusItem.value
                                statusLabel.y = 5
                            }
                        }

                        ParallelAnimation {
                            NumberAnimation {
                                target: statusLabel
                                property: "opacity"
                                to: 1
                                duration: 200
                                easing.type: Easing.OutCubic
                            }

                            NumberAnimation {
                                target: statusLabel
                                property: "y"
                                to: 0
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }
            }

            // Toggle
            Rectangle {
                id: toggle

                property real progress: root.btEnabled ? 1 : 0

                width: 52
                height: 30
                radius: height / 2

                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter

                color: root.btEnabled ? root.toggleOnColor : root.toggleOffColor
                opacity: root.btAvailable ? 1 : 0.4
                scale: toggleArea.pressed ? 0.94 : 1

                Behavior on progress {
                    NumberAnimation {
                        duration: 340
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.4
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 240 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 160
                        easing.type: Easing.OutCubic
                    }
                }

                Rectangle {
                    id: knob

                    // The knob stretches while pressed, like a physical switch
                    width: toggleArea.pressed ? 28 : 22
                    height: 22
                    y: 4
                    x: 4 + toggle.progress * (toggle.width - width - 8)
                    radius: height / 2

                    color: root.btEnabled ? root.toggleKnobOnColor : root.toggleKnobOffColor

                    Behavior on width {
                        NumberAnimation {
                            duration: 140
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation { duration: 240 }
                    }
                }

                MouseArea {
                    id: toggleArea
                    anchors.fill: parent
                    enabled: root.btAvailable
                    cursorShape: Qt.PointingHandCursor
                    onClicked: BluetoothService.toggle()
                }
            }

            // Scan button (icon only, left of the toggle)
            Rectangle {
                id: scanButton

                readonly property bool canScan: root.btEnabled
                property color iconColor: root.btScanning ? root.bluetoothActiveColor : (canScan ? root.primaryTextColor : root.mutedTextColor)

                // 0 → 1 while scanning, drives the glow ring
                property real glowAmount: root.btScanning ? 1 : 0
                property real glowPulse: 0

                width: 30
                height: width
                radius: width / 2

                anchors.right: toggle.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                color: "Transparent" //!canScan ? root.scanDisabledColor : (root.btScanning ? root.scanActiveColor : root.scanColor)
                scale: scanArea.pressed ? 0.9 : (scanArea.containsMouse ? 1.06 : 1.0)

                Behavior on iconColor {
                    ColorAnimation { duration: 220 }
                }

                Behavior on glowAmount {
                    NumberAnimation { duration: 350 }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutBack
                        easing.overshoot: 2
                    }
                }

                SequentialAnimation {
                    running: root.btScanning
                    loops: Animation.Infinite
                    alwaysRunToEnd: true

                    NumberAnimation {
                        target: scanButton
                        property: "glowPulse"
                        to: 1
                        duration: 800
                        easing.type: Easing.InOutSine
                    }

                    NumberAnimation {
                        target: scanButton
                        property: "glowPulse"
                        to: 0
                        duration: 800
                        easing.type: Easing.InOutSine
                    }
                }

                // Hover highlight
                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: root.primaryTextColor
                    opacity: scanArea.containsMouse && scanButton.canScan ? 0.07 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 140 }
                    }
                }

                RadarIcon {
                    anchors.centerIn: parent
                    size: parent.width // 24
                    color: scanButton.iconColor
                    active: root.btScanning
                }

                MouseArea {
                    id: scanArea

                    anchors.fill: parent
                    enabled: root.btEnabled
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: BluetoothService.toggleDiscovery()
                }
            }
        }

        // -----------------------------------------------------
        // Devices
        // -----------------------------------------------------

        Item {
            id: body

            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                leftMargin: root.panelPadding
                rightMargin: root.panelPadding
            }

            height: root.bodyHeight
            clip: true

            opacity: root.btEnabled ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 220
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                id: listCard

                anchors {
                    top: parent.top
                    topMargin: root.sectionGap
                    left: parent.left
                    right: parent.right
                }

                height: Math.max(0, body.height - root.sectionGap)
                radius: 14
                color: root.deviceBackgroundColor
                clip: true

                // Empty state
                Item {
                    id: emptyState

                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }

                    height: root.emptyHeight
                    opacity: deviceList.count === 0 ? 1 : 0
                    visible: opacity > 0.01

                    Behavior on opacity {
                        NumberAnimation { duration: 220 }
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 12

                        RadarIcon {
                            anchors.horizontalCenter: parent.horizontalCenter
                            size: 48
                            active: root.btScanning
                            color: root.btScanning ? root.bluetoothActiveColor: root.mutedTextColor

                            Behavior on color {
                                ColorAnimation { duration: 250 }
                            }
                        }

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 3

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: root.btScanning ? "Looking for nearby devices" : "No devices found"
                                color: root.primaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.Bold
                                font.pixelSize: 14
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: root.btScanning ? "Put your device in pairing mode" : "Tap the scan button to search"
                                color: root.secondaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.DemiBold
                                font.pixelSize: 12
                            }
                        }
                    }
                }


                // list view ofr devices
                ListView {
                    id: deviceList

                    anchors {
                        fill: parent
                        margins: root.listPadding
                    }

                    clip: true
                    spacing: root.listSpacing
                    boundsBehavior: Flickable.StopAtBounds
                    enabled: root.btEnabled

                    model: BluetoothService.devices

                    // First appearance
                    populate: Transition {
                        SequentialAnimation {
                            PropertyAction { property: "opacity"; value: 0 }
                            PropertyAction { property: "scale"; value: 0.92 }
                            PauseAnimation { duration: Math.max(0, Math.min(ViewTransition.index, 8)) * 45 }

                            ParallelAnimation {
                                NumberAnimation {
                                    property: "opacity"
                                    to: 1
                                    duration: 260
                                    easing.type: Easing.OutCubic
                                }

                                NumberAnimation {
                                    property: "scale"
                                    to: 1
                                    duration: 340
                                    easing.type: Easing.OutBack
                                    easing.overshoot: 1.1
                                }
                            }
                        }
                    }

                    // A newly discovered device
                    add: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: 260
                                easing.type: Easing.OutCubic
                            }

                            NumberAnimation {
                                property: "scale"
                                from: 0.9
                                to: 1
                                duration: 340
                                easing.type: Easing.OutBack
                                easing.overshoot: 1.1
                            }
                        }
                    }

                    remove: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "opacity"
                                to: 0
                                duration: 180
                                easing.type: Easing.InQuad
                            }

                            NumberAnimation {
                                property: "scale"
                                to: 0.9
                                duration: 180
                                easing.type: Easing.InQuad
                            }
                        }
                    }

                    displaced: Transition {
                        NumberAnimation {
                            properties: "x,y"
                            duration: 280
                            easing.type: Easing.OutCubic
                        }
                    }


                    // device card delegate
                    delegate: Item {
                        id: delegateRoot

                        required property var modelData

                        readonly property bool connected: modelData.connected
                        // Quickshell device state: 2 = disconnecting, 3 = connecting
                        readonly property bool busy: modelData.state === 2 || modelData.state === 3
                        readonly property real batteryValue: Number(BluetoothService.batteryPercent(modelData)) || 0

                        width: deviceList.width
                        height: root.cardHeight



                        // Device card
                        Rectangle {
                            id: card

                            anchors.fill: parent
                            radius: 12

                            color: delegateRoot.connected ? root.deviceConnectedColor : root.deviceColor

                            border.width: 1
                            border.color: root.withAlpha( root.bluetoothActiveColor, delegateRoot.connected ? 0.4 : 0)

                            scale: cardArea.pressed ? 0.975 : 1

                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }

                            Behavior on border.color {
                                ColorAnimation { duration: 260 }
                            }

                            Behavior on scale {
                                NumberAnimation {
                                    duration: 160
                                    easing.type: Easing.OutCubic
                                }
                            }

                            // Hover highlight
                            Rectangle {
                                anchors.fill: parent
                                radius: parent.radius
                                color: root.primaryTextColor
                                opacity: cardArea.containsMouse ? 0.05 : 0

                                Behavior on opacity {
                                    NumberAnimation { duration: 140 }
                                }
                            }

                            // Icon badge
                            Rectangle {
                                id: deviceBadge

                                width: 40
                                height: 40
                                radius: 12

                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                anchors.verticalCenter: parent.verticalCenter

                                color: delegateRoot.connected ? root.withAlpha(root.bluetoothActiveColor, 0.16) : root.withAlpha(root.primaryTextColor, 0.05)

                                Behavior on color {
                                    ColorAnimation { duration: 240 }
                                }

                                Text {
                                    id: deviceIcon
                                    anchors.centerIn: parent
                                    text: BluetoothService.icon(delegateRoot.modelData)
                                    font.pixelSize: 20
                                    color: delegateRoot.connected ? root.bluetoothActiveColor : root.mutedTextColor
                                    Behavior on color {
                                        ColorAnimation { duration: 240 }
                                    }

                                    // Breathes while connecting / disconnecting
                                    SequentialAnimation on opacity {
                                        running: delegateRoot.busy
                                        loops: Animation.Infinite
                                        alwaysRunToEnd: true

                                        NumberAnimation {
                                            to: 0.3
                                            duration: 550
                                            easing.type: Easing.InOutSine
                                        }

                                        NumberAnimation {
                                            to: 1
                                            duration: 550
                                            easing.type: Easing.InOutSine
                                        }
                                    }
                                }
                            }

                            // Name + status
                            Column {
                                id: deviceInfo

                                anchors.left: deviceBadge.right
                                anchors.leftMargin: 12
                                anchors.right: batteryPill.visible ? batteryPill.left : parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter

                                spacing: 2

                                Text {
                                    width: deviceInfo.width
                                    text: delegateRoot.modelData.name || delegateRoot.modelData.deviceName  || delegateRoot.modelData.address
                                    color: root.primaryTextColor
                                    font.family: root.fontFamily
                                    font.weight: Font.Bold
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                }

                                Text {
                                    width: deviceInfo.width

                                    text: BluetoothService.status(delegateRoot.modelData)

                                    color: delegateRoot.connected ? root.bluetoothActiveColor : root.secondaryTextColor

                                    font.family: root.fontFamily
                                    font.weight: Font.DemiBold
                                    font.pixelSize: 11
                                    elide: Text.ElideRight

                                    Behavior on color {
                                        ColorAnimation { duration: 240 }
                                    }
                                }
                            }

                            // Battery pill — fills with the charge level
                            Rectangle {
                                id: batteryPill

                                visible: delegateRoot.modelData.batteryAvailable

                                width: 54
                                height: 24
                                radius: height / 2

                                anchors.right: parent.right
                                anchors.rightMargin: 14
                                anchors.verticalCenter: parent.verticalCenter

                                color: root.withAlpha(root.primaryTextColor, 0.06)
                                clip: true

                                Rectangle {
                                    height: parent.height
                                    radius: height / 2

                                    width: Math.max(height, parent.width * Math.min(100, delegateRoot.batteryValue) / 100)

                                    color: root.withAlpha( delegateRoot.batteryValue <= 20 ? root.batteryLowColor : root.bluetoothActiveColor, 0.3)

                                    Behavior on width {
                                        NumberAnimation {
                                            duration: 450
                                            easing.type: Easing.OutCubic
                                        }
                                    }

                                    Behavior on color {
                                        ColorAnimation { duration: 300 }
                                    }
                                }


                                // Battery percentage text
                                Text {
                                    anchors.centerIn: parent
                                    text: Math.round(delegateRoot.batteryValue) + "%"
                                    color: root.batteryColor
                                    font.pixelSize: 12
                                    font.family: root.fontFamily
                                    font.weight: Font.DemiBold
                                }
                            }

                            // Indeterminate progress line while (dis)connecting
                            Item {
                                id: busyBar

                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    bottom: parent.bottom
                                    leftMargin: 14
                                    rightMargin: 14
                                    bottomMargin: 3
                                }

                                height: 2
                                clip: true
                                opacity: delegateRoot.busy ? 1 : 0

                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }

                                Rectangle {
                                    id: busySlider

                                    width: parent.width * 0.35
                                    height: parent.height
                                    radius: 1
                                    color: root.bluetoothActiveColor

                                    NumberAnimation on x {
                                        running: delegateRoot.busy
                                        loops: Animation.Infinite
                                        from: -busySlider.width
                                        to: busyBar.width
                                        duration: 1000
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }

                            MouseArea {
                                id: cardArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.RightButton

                                // Left click: connect / disconnect. Right click: forget.
                                onClicked: mouse => {
                                    if (mouse.button === Qt.LeftButton)
                                        BluetoothService.toggleDevice(delegateRoot.modelData)
                                    else if (mouse.button === Qt.RightButton)
                                        BluetoothService.forgetDevice(delegateRoot.modelData)
                                }
                            }
                        }
                    }
                }

                // Slim scroll indicator, only visible while scrolling
                Rectangle {
                    visible: deviceList.visibleArea.heightRatio < 1

                    x: parent.width - width - 3
                    y: deviceList.y + deviceList.visibleArea.yPosition * deviceList.height
                    width: 3
                    height: Math.max(24, deviceList.visibleArea.heightRatio * deviceList.height)
                    radius: 1.5

                    color: root.withAlpha(root.secondaryTextColor, 0.6)
                    opacity: deviceList.moving ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 300 }
                    }
                }
            }
        }
    }
}
