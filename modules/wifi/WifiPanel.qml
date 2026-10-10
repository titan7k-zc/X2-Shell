import QtQuick
import QtQuick.Shapes
import "../../services"
import "../../config"

Item {
    id: root



    // Surfaces
    property color backgroundColor: Colors.wifiBackgroundColor
    property color headerColor: Colors.wifiHeaderColor
    property color deviceBackgroundColor: Colors.wifiDeviceBackgroundColor
    property color deviceColor: Colors.wifiDeviceColor
    property color deviceConnectedColor: Colors.wifiDeviceConnectedColor

    // Text
    property color primaryTextColor: Colors.wifiPrimaryTextColor
    property color secondaryTextColor: Colors.wifiSecondaryTextColor
    property color mutedTextColor: Colors.wifiMutedTextColor

    // Wi-Fi
    property color wifiActiveColor: Colors.wifiActiveColor
    property color wifiInactiveColor: Colors.wifiInactiveColor

    // Toggle
    property color toggleOnColor: Colors.wifiToggleOnColor
    property color toggleOffColor: Colors.wifiToggleOffColor
    property color toggleKnobOnColor: Colors.wifiToggleKnobOnColor
    property color toggleKnobOffColor: Colors.wifiToggleKnobOffColor

    // Scanning
    property color scanColor: Colors.wifiScanColor
    property color scanActiveColor: Colors.wifiScanActiveColor
    property color scanDisabledColor: Colors.wifiScanDisabledColor

    // Signal strength
    property color signalTextColor: Colors.wifiSignalColor
    property color signalLowColor: Colors.wifiSignalLowColor


    // Fonts / glyphs(Nerd Font)
    property string fontFamily: "Quicksand"
    property string wifiGlyph: "\uf1eb"
    property string lockGlyph: "\uf023"
    property string eyeGlyph: "\uf06e"
    property string eyeOffGlyph: "\uf070"

    // Layout 
    readonly property int panelPadding: 7
    readonly property int headerHeight: 58
    readonly property int sectionGap: 7
    readonly property int listPadding: 7
    readonly property int listSpacing: 5
    readonly property int cardHeight: 58
    readonly property int maxListHeight: 297
    readonly property int emptyHeight: 158
    readonly property int promptHeight: 198     // height of the password prompt

    // State
    readonly property bool wifiAvailable: WifiService.available
    readonly property bool wifiEnabled: WifiService.enabled
    readonly property bool wifiScanning: WifiService.enabled && WifiService.scanning
    readonly property var connectedNetwork: WifiService.connectedNetwork

    // status text under title  -----------------------[need to update bluetoothpanel.qml like thsi]
    readonly property string statusText: {
        if (!wifiAvailable)
            return "Unavailable"
        if (!wifiEnabled)
            return "Off"
        if (scanArea.containsMouse)
            return wifiScanning ? "Stop scanning" : "Scan for networks"
        if (wifiScanning)
            return "Scanning…"
        // if (connectedNetwork)
        //     return "Connected · " + connectedNetwork.name
        return "On"
    }

    // Height of the network section (0 when Wi-Fi is off), animated.
    readonly property real listCardTarget: {
        var n = networkList.count
        if (n === 0)
            return emptyHeight

        var content = n * cardHeight + (n - 1) * listSpacing + 2 * listPadding
        var h = Math.min(maxListHeight, content)

        // the password prompt needs room even when only a few networks exist
        return passwordPrompt.shown ? Math.max(h, promptHeight) : h
    }

    readonly property real bodyTarget: wifiEnabled ? sectionGap + listCardTarget : 0
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

    onVisibleChanged: {
        openProgress = visible ? 1 : 0

        if (!visible)
            passwordPrompt.close()
    }

    onWifiEnabledChanged: {
        if (!wifiEnabled)
            passwordPrompt.close()
    }

    function withAlpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    implicitWidth: panel.width
    implicitHeight: panel.height//maxListHeight + (panelPadding * 4) + headerHeight //panel.height



    // Radar icon
    component RadarIcon: Item {
        id: radar

        property color color: "white"
        property bool active: false
        property real size: 22
        readonly property real ringWidth: Math.max(1.5, size * 0.075)

        width: size
        height: size

        function alpha(a) {
            return Qt.rgba(color.r, color.g, color.b, a)
        }

        // outside ring
        Rectangle {
            anchors.fill: parent
            anchors.rightMargin:-1
            anchors.bottomMargin:-1
            radius: width / 2
            color: "transparent"
            border.width: radar.ringWidth
            border.color: radar.color
            opacity: root.wifiEnabled? (radar.active ? 0.9 : 0.55) : 0.4

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
            opacity: root.wifiEnabled? (radar.active ? 0 : 0.4) : 0.2

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }
        }

        // Ping ring
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

        // dot iin center
        Rectangle {
            id: dot

            anchors.centerIn: parent
            width: radar.size * 0.24
            height: width
            radius: width / 2
            color: radar.color
            opacity: root.wifiEnabled? 1.0 : 0.4

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }

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

    //  button - password prompt
    component PromptButton: Rectangle {
        id: btn

        property string label: ""
        property color textColor: "white"
        property color hoverColor: "white"
        property string fontFamily: ""

        signal clicked()

        height: 34
        radius: 11
        opacity: enabled ? 1 : 0.4
        scale: btnArea.pressed ? 0.96 : 1

        Behavior on opacity {
            NumberAnimation { duration: 160 }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 140
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: btn.hoverColor
            opacity: btnArea.containsMouse && btn.enabled ? 0.08 : 0

            Behavior on opacity {
                NumberAnimation { duration: 140 }
            }
        }

        Text {
            anchors.centerIn: parent
            text: btn.label
            color: btn.textColor
            font.family: btn.fontFamily
            font.weight: Font.Bold
            font.pixelSize: 12
        }

        MouseArea {
            id: btnArea

            anchors.fill: parent
            enabled: btn.enabled
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: btn.clicked()
        }
    }

    // Panel

    Rectangle {
        id: panel

        x: 0
        y: 0
        width: 405
        height: root.panelPadding * 2 + root.headerHeight + root.bodyHeight

        radius: 18
        color: root.backgroundColor

        border.width: 1
        border.color: root.withAlpha(root.primaryTextColor, 0.06)

        opacity: Math.min(1, root.openProgress * 1.6)
        scale: 0.94 + 0.06 * root.openProgress
        transformOrigin: Item.Top

        transform: Translate {y: (1 - root.openProgress) * -12}

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
            radius: 13
            color: root.headerColor

            // Wi-Fi badge
            Rectangle {
                id: badge

                width: 40
                height: 40
                radius: 13

                anchors.left: parent.left
                anchors.leftMargin: 9
                anchors.verticalCenter: parent.verticalCenter

                color: root.wifiEnabled ? root.withAlpha(root.wifiActiveColor, 0.16) : root.withAlpha(root.mutedTextColor, 0.10)

                Behavior on color {
                    ColorAnimation { duration: 260 }
                }

                Text {
                    anchors.centerIn: parent
                    text: root.wifiGlyph
                    font.pixelSize: 20
                    color: root.wifiEnabled ? root.wifiActiveColor : root.wifiInactiveColor
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
                    target: WifiService

                    function onEnabledChanged() {
                        badgeBounce.restart()
                    }
                }
            }

            // Title + status
            Column {
                id: titleColumn

                anchors.left: badge.right
                anchors.leftMargin: 11
                anchors.verticalCenter: parent.verticalCenter

                spacing: 1

                Text {
                    text: "Wi-Fi"
                    color: root.primaryTextColor
                    font.pixelSize: 14
                    font.family: root.fontFamily
                    font.weight: Font.ExtraBold
                }

                // Status
                Item {
                    id: statusItem

                    property string value: root.statusText
                    property string shown: ""

                    // long network names are elided so they never run into the buttons
                    width: Math.min(statusLabel.implicitWidth, 220)
                    height: statusLabel.implicitHeight

                    Component.onCompleted: shown = value

                    onValueChanged: {
                        if (shown !== "")
                            swapStatus.restart()
                    }

                    Text {
                        id: statusLabel
                        width: statusItem.width
                        elide: Text.ElideRight
                        text: statusItem.shown
                        font.family: root.fontFamily
                        font.weight: Font.Bold
                        font.pixelSize: 10
                        color: (root.wifiScanning || root.connectedNetwork)? root.wifiActiveColor: root.secondaryTextColor

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

                        ScriptAction {   // ScriptAction for run js code
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
                property real progress: root.wifiEnabled ? 1 : 0
                width: 47
                height: 27
                radius: height / 2
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                color: root.wifiEnabled ? root.toggleOnColor : root.toggleOffColor
                opacity: root.wifiAvailable ? 1 : 0.4
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
                    width: toggleArea.pressed ? 25 : 20
                    height: 20
                    y: 4
                    x: 4 + toggle.progress * (toggle.width - width - 8)
                    radius: height / 2
                    color: root.wifiEnabled ? root.toggleKnobOnColor : root.toggleKnobOffColor
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
                    enabled: root.wifiAvailable
                    cursorShape: Qt.PointingHandCursor
                    onClicked: WifiService.toggle()
                }
            }

            // Scan button (right)
            Rectangle {
                id: scanButton

                readonly property bool canScan: root.wifiEnabled
                property color iconColor: root.wifiScanning ? root.wifiActiveColor : (canScan ? root.primaryTextColor : root.mutedTextColor)
                property real glowAmount: root.wifiScanning ? 1 : 0
                property real glowPulse: 0

                width: 27
                height: width
                radius: width / 2
                anchors.right: toggle.left
                anchors.rightMargin: 9
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                scale: scanArea.pressed ? 0.9 : (scanArea.containsMouse ? 1.06 : 1.0)

                Behavior on iconColor {ColorAnimation { duration: 220 }}
                Behavior on glowAmount {NumberAnimation { duration: 350 }}
                Behavior on scale {NumberAnimation {duration: 200;easing.type: Easing.OutBack;easing.overshoot: 2}}

                SequentialAnimation {
                    running: root.wifiScanning
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
                    size: parent.width
                    color: scanButton.iconColor
                    active: root.wifiScanning
                }

                MouseArea {
                    id: scanArea
                    anchors.fill: parent
                    enabled: root.wifiEnabled
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: WifiService.toggleScanning()
                }
            }

        }


        // Networks -----------------------------------------------------------------------------------------------------------
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

            opacity: root.wifiEnabled ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 220
                    easing.type: Easing.OutCubic
                }
            }

            // List card (network)
            Rectangle {
                id: listCard

                anchors {
                    top: parent.top
                    topMargin: root.sectionGap
                    // horizontalCenter:parent.horizontalCenter
                    left: parent.left
                    right: parent.right
                }
                // width:380
                height: Math.max(0, body.height - root.sectionGap)
                radius: 13
                color: "Transparent"//root.deviceBackgroundColor
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
                    opacity: networkList.count === 0 ? 1 : 0
                    visible: opacity > 0.01

                    Behavior on opacity {
                        NumberAnimation { duration: 220 }
                    }

                    // no network - middle
                    Column {
                        anchors.centerIn: parent
                        spacing: 12
                        
                        RadarIcon {
                            anchors.horizontalCenter: parent.horizontalCenter
                            size: 43
                            active: root.wifiScanning
                            color: root.wifiScanning ? root.wifiActiveColor : root.mutedTextColor

                            Behavior on color {
                                ColorAnimation { duration: 250 }
                            }
                        }

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 3

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: root.wifiScanning ? "Looking for nearby networks" : "No networks found"
                                color: root.primaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.Bold
                                font.pixelSize: 13
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: root.wifiScanning ? "This can take a few seconds" : "Tap the scan button to search"
                                color: root.secondaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.DemiBold
                                font.pixelSize: 11
                            }
                        }
                    }
                }


                // list view for networks
                ListView {
                    id: networkList

                    anchors.fill:parent
                    anchors.margins: root.listPadding

                    clip: true
                    spacing: root.listSpacing
                    boundsBehavior: Flickable.StopAtBounds
                    enabled: root.wifiEnabled && !passwordPrompt.shown

                    model: WifiService.networks

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

                    // new network (adding time)
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
                    // removed
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
                    // location changed
                    displaced: Transition {
                        NumberAnimation {
                            properties: "x,y"
                            duration: 280
                            easing.type: Easing.OutCubic
                        }
                    }


                    // network card delegate
                    delegate: Item {
                        id: delegateRoot

                        required property var modelData

                        readonly property bool connected: modelData ? modelData.connected : false
                        readonly property bool busy: modelData ? modelData.stateChanging : false
                        readonly property string ssid: modelData ? modelData.name : ""
                        readonly property real signalValue: WifiService.signalPercent(modelData)

                        // Last connection error, cleared when a new attempt starts
                        property string errorText: ""

                        width: networkList.width
                        height: root.cardHeight

                        Connections {
                            target: delegateRoot.modelData
                            ignoreUnknownSignals: true  // only listen to the signals that we need (onConnectionFailed , onStateChanged)

                            function onConnectionFailed(reason) {
                                delegateRoot.errorText = WifiService.failureText(reason)
                            }

                            function onStateChanged() {
                                // if (delegateRoot.busy || delegateRoot.connected)  // [fix] saved network connecteion faield status  
                                if (delegateRoot.connected)  // only clear error msg after successful connection
                                    delegateRoot.errorText = ""
                            }
                        }


                        // Network card
                        Rectangle {
                            id: card

                            anchors.fill: parent
                            radius: 11
                            color: "Transparent" //delegateRoot.connected ? root.deviceConnectedColor : root.deviceColor
                            border.width: 1
                            border.color: root.withAlpha(root.wifiActiveColor, delegateRoot.connected ? 0.4 : 0)
                            scale: cardArea.pressed ? 0.975 : 1

                            Behavior on color {ColorAnimation { duration: 200 }}
                            Behavior on border.color {ColorAnimation { duration: 260 }}
                            Behavior on scale {NumberAnimation {duration: 160;easing.type: Easing.OutCubic}}

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
                                id: networkBadge

                                width: 36
                                height: 36
                                radius: 11

                                anchors.left: parent.left
                                anchors.leftMargin: 11
                                anchors.verticalCenter: parent.verticalCenter

                                color: delegateRoot.connected ? root.withAlpha(root.wifiActiveColor, 0.16) : root.withAlpha(root.primaryTextColor, 0.05)

                                // opacity: 0

                                Behavior on color {
                                    ColorAnimation { duration: 240 }
                                }


                                Text{
                                    anchors.centerIn: parent
                                    text:"󰵬"
                                    color: delegateRoot.connected ? root.wifiActiveColor : root.mutedTextColor
                                    
                                }

                            }

                            // Name + status
                            Column {
                                id: networkInfo

                                anchors.left: networkBadge.right
                                anchors.leftMargin: 11
                                anchors.right: signalPill.left
                                anchors.rightMargin: 11
                                anchors.verticalCenter: parent.verticalCenter

                                spacing: 2

                                Text {
                                    width: networkInfo.width
                                    text: delegateRoot.ssid
                                    color: root.primaryTextColor
                                    font.family: root.fontFamily
                                    font.weight: Font.Bold
                                    font.pixelSize: 13
                                    elide: Text.ElideRight
                                }

                                Text {
                                    id:networkStatus
                                    width: networkInfo.width
                                    text: WifiService.networkStatus(delegateRoot.modelData, delegateRoot.errorText)
                                    color: (delegateRoot.errorText !== "" && !delegateRoot.connected) ? root.signalLowColor : (delegateRoot.connected ? root.wifiActiveColor : root.secondaryTextColor)
                                    font.family: root.fontFamily
                                    font.weight: Font.DemiBold
                                    font.pixelSize: 10
                                    elide: Text.ElideRight

                                    Behavior on color {
                                        ColorAnimation { duration: 240 }
                                    }
                                }
                            }

                            // Signal pill
                            Rectangle {
                                id: signalPill

                                width: 49
                                height: 22
                                radius: height / 2

                                anchors.right: parent.right
                                anchors.rightMargin: 13
                                anchors.verticalCenter: parent.verticalCenter

                                color: root.withAlpha(root.primaryTextColor, 0.06)
                                clip: true

                                Rectangle {
                                    height: parent.height
                                    radius: height / 2

                                    width: Math.max(height, parent.width * Math.min(100, delegateRoot.signalValue) / 100)

                                    color: root.withAlpha(delegateRoot.signalValue <= 25 ? root.signalLowColor : root.wifiActiveColor, 0.3)

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

                                // Signal percentage 
                                Text {
                                    anchors.centerIn: parent
                                    text: Math.round(delegateRoot.signalValue) + "   "
                                    color: root.signalTextColor
                                    font.pixelSize: 11
                                    font.family: root.fontFamily
                                    font.weight: Font.DemiBold
                                }
                            }

                            // line (dis)connecting
                            Item {
                                id: busyBar

                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    bottom: parent.bottom
                                    leftMargin: 13
                                    rightMargin: 13
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
                                    color: root.wifiActiveColor

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

                                // Left click: connect / disconnect
                                // Right click: forget.
                                onClicked: mouse => {
                                    var net = delegateRoot.modelData
                                    if (!net)
                                        return

                                    if (mouse.button === Qt.RightButton)
                                        WifiService.forgetNetwork(net)
                                    else if (WifiService.isPasswordRequired(net))
                                        passwordPrompt.open(net)
                                    else
                                        WifiService.toggleConnection(net)
                                }
                            }
                        }
                    }
                }

                // scroll indicator, visible while scrolling
                Rectangle {
                    visible: networkList.visibleArea.heightRatio < 1

                    x: parent.width - width - 3
                    y: networkList.y + networkList.visibleArea.yPosition * networkList.height
                    width: 3
                    height: Math.max(22, networkList.visibleArea.heightRatio * networkList.height)
                    radius: 1.5

                    color: root.withAlpha(root.secondaryTextColor, 0.6)
                    opacity: networkList.moving ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 300 }
                    }
                }

                // Password prompt (covers the list ehn it is open)
                Item {
                    id: passwordPrompt

                    property var network: null
                    property string shownName: ""
                    property bool reveal: false
                    readonly property bool shown: network !== null

                    function open(net) {
                        if (!net)
                            return

                        passwordInput.text = ""
                        reveal = false
                        shownName = net.name
                        network = net
                    }


                    // close function for clear inputs
                    function close() {
                        network = null
                        passwordInput.text = ""
                        passwordInput.focus = false
                    }

                    function submit() {
                        if (!network || passwordInput.text.length === 0)
                            return

                        WifiService.connectNetwork(network, passwordInput.text)
                        close()
                    }

                    onShownChanged: {
                        if (shown){
                            passwordInput.forceActiveFocus()
                        }
                            
                    }

                    anchors.fill: parent
                    z: 10

                    opacity: shown ? 1 : 0
                    visible: shown || opacity > 0.01

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }

                    // Backdrop (also swallows clicks / scrolling meant for the list)
                    Rectangle {
                        anchors.fill: parent
                        radius: 13
                        color: root.deviceBackgroundColor

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.AllButtons
                            onWheel: wheel => wheel.accepted = true
                        }
                    }

                    Column {
                        anchors.centerIn: parent
                        width: parent.width - 43
                        spacing: 12

                        // Lock badge
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 36
                            height: 36
                            radius: 11
                            color: root.withAlpha(root.wifiActiveColor, 0.16)

                            Text {
                                anchors.centerIn: parent
                                text: root.lockGlyph
                                font.pixelSize: 16
                                color: root.wifiActiveColor
                            }
                        }

                        // Title , name
                        Column {
                            width: parent.width
                            spacing: 3

                            Text {
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: "Enter password"
                                color: root.primaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.Bold
                                font.pixelSize: 13
                            }

                            Text {
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: passwordPrompt.shownName
                                color: root.secondaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.DemiBold
                                font.pixelSize: 11
                                elide: Text.ElideRight
                            }
                        }

                        // Password field
                        Rectangle {
                            width: parent.width
                            height: 38
                            radius: 11
                            color: root.deviceColor

                            border.width: 1
                            border.color: passwordInput.activeFocus ? root.withAlpha(root.wifiActiveColor, 0.5) : root.withAlpha(root.primaryTextColor, 0.06)

                            Behavior on border.color {
                                ColorAnimation { duration: 200 }
                            }

                            TextInput {
                                id: passwordInput

                                anchors {
                                    left: parent.left
                                    right: revealArea.left
                                    verticalCenter: parent.verticalCenter
                                    leftMargin: 13
                                    rightMargin: 7
                                }

                                echoMode: passwordPrompt.reveal ? TextInput.Normal : TextInput.Password
                                passwordCharacter: "•"
                                selectByMouse: true
                                clip: true

                                color: root.primaryTextColor
                                selectionColor: root.withAlpha(root.wifiActiveColor, 0.4)
                                selectedTextColor: root.primaryTextColor
                                font.family: root.fontFamily
                                font.weight: Font.DemiBold
                                font.pixelSize: 13


                                // heyboard shortcuts for submit / cancel
                                Keys.onReturnPressed: passwordPrompt.submit()
                                Keys.onEnterPressed: passwordPrompt.submit()
                                Keys.onEscapePressed: passwordPrompt.close()

                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: passwordInput.text.length === 0
                                    text: "Password"
                                    color: root.mutedTextColor
                                    font: passwordInput.font
                                }
                            }

                            // Show, hide password
                            Item {
                                id: revealArea

                                width: 34
                                height: parent.height
                                anchors.right: parent.right

                                Text {
                                    anchors.centerIn: parent
                                    text: passwordPrompt.reveal ? root.eyeOffGlyph : root.eyeGlyph
                                    font.pixelSize: 13
                                    color: revealMouse.containsMouse ? root.primaryTextColor : root.mutedTextColor

                                    Behavior on color {
                                        ColorAnimation { duration: 140 }
                                    }
                                }

                                MouseArea {
                                    id: revealMouse

                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: passwordPrompt.reveal = !passwordPrompt.reveal
                                }
                            }
                        }

                        // Buttons
                        Row {
                            width: parent.width
                            spacing: 8
                            // canel button
                            PromptButton {
                                width: (parent.width - parent.spacing) / 2
                                label: "Cancel"
                                color: root.deviceColor
                                textColor: root.primaryTextColor
                                hoverColor: root.primaryTextColor
                                fontFamily: root.fontFamily
                                onClicked: passwordPrompt.close()
                            }
                            // connect button
                            PromptButton {
                                width: (parent.width - parent.spacing) / 2
                                label: "Connect"
                                enabled: passwordInput.text.length > 0
                                color: root.toggleOnColor
                                textColor: root.toggleKnobOnColor
                                hoverColor: root.toggleKnobOnColor
                                fontFamily: root.fontFamily
                                onClicked: passwordPrompt.submit()
                            }
                        }
                    }
                }
            }
        }
    }
}
