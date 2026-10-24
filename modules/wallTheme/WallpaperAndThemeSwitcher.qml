import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Quickshell.Widgets
import Quickshell.Io

import "../../config/"

FocusScope {
    id: wall
    implicitWidth: tab.implicitWidth
    implicitHeight: tab.implicitHeight

    property bool showing: false

    onShowingChanged: {
        if (showing) {
            wallpaperQuery.running = true;
            colorList.currentIndex = Colors.theme;
        }
    }

    property string folderpath: "file:///home/titan/disk0/syscustom/wallpapers/"
    property string currentWallpaperPath: ""

    property int setAni: 7

    property var wallpaperAnimations: [
        { type: "wave",   angle: 30,  wave: "20,20", duration: 2,   fps: 60 },  // 0: gentle ripple
        { type: "wave",   angle: 120, wave: "50,60", duration: 2.5, fps: 60 },  // 1: big rolling swell
        { type: "wipe",   angle: 15,  duration: 1.5, fps: 60 },                 // 2: sharp diagonal wipe
        { type: "wipe",   angle: 200, duration: 1.5, fps: 60 },                 // 3: reverse diagonal wipe
        { type: "grow",   pos: "center",       duration: 2,   fps: 60 },        // 4: expanding circle
        { type: "grow",   pos: "top",          duration: 1.5, fps: 60 },        // 5: grow from top
        { type: "outer",  pos: "bottom-right", duration: 2.2, fps: 60 },        // 6: shrinking circle
        { type: "any",    duration: 2,   fps: 60 },                             // 7: random-point grow
        { type: "fade",   duration: 1.5, fps: 60 },                             // 8: bezier crossfade
        { type: "random", duration: 2,   fps: 60 },                             // 9: awww picks random
    ]

    function setWallpaper(path) {
        if (wallpaperSetter.running) {
            wallpaperSetter.running = false;
        }

        var anim = wallpaperAnimations[setAni];
        var cmd = ["awww", "img", "--transition-type", anim.type];

        if (anim.angle !== undefined) cmd.push("--transition-angle", String(anim.angle));
        if (anim.wave !== undefined)  cmd.push("--transition-wave", anim.wave);
        if (anim.pos !== undefined)   cmd.push("--transition-pos", anim.pos);

        cmd.push("--transition-duration", String(anim.duration));
        cmd.push("--transition-fps", String(anim.fps));
        cmd.push(path);

        wallpaperSetter.command = cmd;
        wall.currentWallpaperPath = path;
        wallpaperSetter.running = true;
    }

    // Query current wallpaper on load
    Process {
        id: wallpaperQuery
        command: ["awww", "query"]

        stdout: StdioCollector {
            onStreamFinished: {
                // (.+) up to end of line, so paths with spaces also work
                const match = text.match(/image:\s*(.+)/);
                if (match) {
                    wall.currentWallpaperPath = match[1].trim();
                    wall.trySelectCurrentWallpaper();
                }
            }
        }
    }

    FolderListModel {
        id: wallpaperFolder
        folder: wall.folderpath
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
        showDirs: false

        onStatusChanged: {
            if (status === FolderListModel.Ready) {
                wall.trySelectCurrentWallpaper();
            }
        }
    }

    function trySelectCurrentWallpaper() {
        if (wall.currentWallpaperPath === "" || wallpaperFolder.status !== FolderListModel.Ready)
            return;

        for (let i = 0; i < wallpaperFolder.count; i++) {
            let entryPath = decodeURIComponent(
                wallpaperFolder.get(i, "fileUrl")
                    .toString()
                    .replace("file://", "")
            );

            if (entryPath === wall.currentWallpaperPath) {
                wallpaperList.currentIndex = i;
                break;
            }
        }
    }

    Process {
        id: wallpaperSetter
        command: []
    }

    Rectangle {
        id: tab // frame
        implicitHeight: viewArea.implicitHeight + 40
        implicitWidth: viewArea.implicitWidth

        radius: 10
        color: Colors.wallpaperSwitcherTransparentColor

        Rectangle {
            id: viewArea
            implicitWidth: gridLayout.implicitWidth + 20
            implicitHeight: 518
            color: Colors.wallpaperSwitcherTransparentColor
            clip: true
            anchors.centerIn: parent

            GridLayout {
                id: gridLayout
                columns: 2
                anchors.fill: parent
                anchors.margins: 15
                columnSpacing: 20

                // ================= wallpaper part =================
                Rectangle {
                    id: wallpaperBG
                    Layout.preferredWidth: 320
                    Layout.fillHeight: true
                    color: Colors.wallpaperSwitcherTransparentColor

                    ListView {
                        id: wallpaperList
                        readonly property real itemH: 180

                        anchors.fill: parent
                        spacing: 4
                        clip: true
                        orientation: ListView.Vertical

                        highlightRangeMode: ListView.StrictlyEnforceRange
                        preferredHighlightBegin: height / 3.15
                        preferredHighlightEnd: preferredHighlightBegin + itemH
                        highlightMoveDuration: 320
                        highlightMoveVelocity: -1

                        focus: true

                        // Keys.onReturnPressed: handleSelect()
                        // Keys.onEnterPressed: handleSelect()

                        property bool keyPressed: false

                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                if (!event.isAutoRepeat) {
                                    keyPressed = true
                                    handleSelect()
                                }
                                event.accepted = true
                            }
                        }
                        Keys.onReleased: function(event) {
                            if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter) && !event.isAutoRepeat) {
                                keyPressed = false
                                event.accepted = true
                            }
                        }


                        Keys.onRightPressed: colorList.forceActiveFocus()

                        function handleSelect() {
                            let path = decodeURIComponent(
                                wallpaperFolder.get(wallpaperList.currentIndex, "fileUrl")
                                    .toString().replace("file://", ""));
                            wall.setWallpaper(path);
                        }

                        model: wallpaperFolder
                        delegate: Item {
                            id: wpDelegate
                            readonly property bool isCurrent: ListView.isCurrentItem
                            readonly property string filePath: decodeURIComponent(
                                fileUrl.toString().replace("file://", ""))

                            width: wallpaperList.width
                            height: wallpaperList.itemH   // FIXED

                            ClippingRectangle {
                                id: thumb
                                anchors.fill: parent
                                radius: 10
                                color: Colors.wallpaperSwitcherTransparentColor

                                border.width: 2
                                border.color: wpDelegate.isCurrent ? Colors.wallpaperThemeActiveColor
                                            : wall.currentWallpaperPath === wpDelegate.filePath ? Colors.wallpaperThemeSelectedColor
                                            : Colors.wallpaperSwitcherTransparentColor

                                // "selected = bigger" via scale (cheap, smooth)
                                scale: (mouseArea.pressed || (wpDelegate.isCurrent && wallpaperList.keyPressed)) ? 0.72 : wpDelegate.isCurrent ? 1.0 : 0.8

                                Behavior on border.color { ColorAnimation { duration: 150 } }
                                Behavior on scale { NumberAnimation { duration: 240; easing.type: Easing.OutCubic } }

                                Text {
                                    id: loadingIcon
                                    text: ""
                                    anchors.centerIn: parent
                                    opacity: 0.2
                                    color: Colors.wallpaperLoadingTextColor
                                    visible: img.status !== Image.Ready

                                    SequentialAnimation on scale {
                                        loops: Animation.Infinite
                                        NumberAnimation { from: 1.0; to: 3.5; duration: 800; easing.type: Easing.InOutQuad }
                                        NumberAnimation { from: 3.5; to: 1.0; duration: 800; easing.type: Easing.InOutQuad }
                                    }
                                }

                                Image {
                                    id: img
                                    anchors.fill: parent
                                    source: fileUrl
                                    asynchronous: true
                                    cache: true
                                    fillMode: Image.PreserveAspectCrop
                                    sourceSize.width: 640   // decode smaller = faster, less memory

                                    opacity: status === Image.Ready
                                             ? Math.max(0, 1 - Math.abs(wallpaperList.currentIndex - index) * 0.25)
                                             : 0
                                    Behavior on opacity { NumberAnimation { duration: 240 } }
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onWheel: function(event) {
                                        if (event.angleDelta.y > 0)
                                            wallpaperList.currentIndex = Math.max(0, wallpaperList.currentIndex - 1);
                                        else if (event.angleDelta.y < 0)
                                            wallpaperList.currentIndex = Math.min(wallpaperList.count - 1, wallpaperList.currentIndex + 1);
                                        event.accepted = true;
                                    }

                                    onClicked: {
                                        if (index !== wallpaperList.currentIndex) {
                                            wallpaperList.currentIndex = index;
                                            return;
                                        }
                                        wall.setWallpaper(wpDelegate.filePath);
                                    }
                                }
                            }
                        }
                    }
                }

                // ================= theme part =================
                Rectangle {
                    id: themeBG
                    Layout.preferredWidth: 250
                    Layout.fillHeight: true
                    color: Colors.wallpaperSwitcherTransparentColor

                    ListView {
                        id: colorList
                        readonly property real cardH: 58

                        anchors.fill: parent
                        spacing: 6
                        clip: true
                        orientation: ListView.Vertical

                        highlightRangeMode: ListView.StrictlyEnforceRange
                        preferredHighlightBegin: (height - cardH) / 2
                        preferredHighlightEnd: preferredHighlightBegin + cardH
                        highlightMoveDuration: 320
                        highlightMoveVelocity: -1

                        Component.onCompleted: currentIndex = Colors.theme

                        // Keys.onReturnPressed: Colors.theme = colorList.currentIndex
                        // Keys.onEnterPressed: Colors.theme = colorList.currentIndex

                        property bool keyPressed: false

                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                if (!event.isAutoRepeat) {
                                    keyPressed = true
                                    Colors.theme = colorList.currentIndex
                                }
                                event.accepted = true
                            }
                        }
                        Keys.onReleased: function(event) {
                            if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter) && !event.isAutoRepeat) {
                                keyPressed = false
                                event.accepted = true
                            }
                        }

                        Keys.onLeftPressed: wallpaperList.forceActiveFocus()

                        model: Colors.themeColors.length
                        delegate: Item {
                            id: themeDelegate
                            readonly property bool isCurrent: ListView.isCurrentItem

                            width: colorList.width
                            height: colorList.cardH   // FIXED

                            Rectangle {
                                id: card
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                height: colorList.cardH
                                width: Math.max(colorRow.implicitWidth, nameText.implicitWidth) + 20
                                radius: 10
                                color: Colors.wallpaperThemeBackgroundColor

                                border.width: 2
                                border.color: themeDelegate.isCurrent ? Colors.wallpaperThemeActiveColor
                                            : Colors.theme === index ? Colors.wallpaperThemeSelectedColor
                                            : Colors.wallpaperSwitcherTransparentColor

                                opacity: Math.max(0, 1 - Math.abs(colorList.currentIndex - index) * 0.25)

                                transformOrigin: Item.Right
                                scale: (themeMouseArea.pressed || (themeDelegate.isCurrent && colorList.keyPressed)) ? 0.88 : themeDelegate.isCurrent ? 1.0 : 0.92

                                Behavior on border.color { ColorAnimation { duration: 180; easing.type: Easing.OutCubic } }
                                Behavior on scale { NumberAnimation { duration: 240; easing.type: Easing.OutCubic } }
                                Behavior on opacity { NumberAnimation { duration: 240; easing.type: Easing.OutCubic } }

                                // === Theme name ===
                                Text {
                                    id: nameText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    text: Colors.themeColors[index][0]
                                    font.family: "Quicksand"
                                    font.weight: Font.Bold
                                    font.pixelSize: 17   // FIXED
                                    color: Colors.wallpaperThemeTextColor
                                }

                                // === Color preview ===
                                Row {
                                    id: colorRow
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    spacing: 5   // FIXED

                                    Repeater {
                                        // If index 1 is NOT a color in your palette, use slice(2, 12)
                                        model: Colors.themeColors[index].slice(1)
                                        delegate: Rectangle {
                                            width: 16   // FIXED
                                            height: 16
                                            radius: 8
                                            color: modelData
                                            border.color: Colors.wallpaperThemeIconColor
                                            border.width: 1
                                        }
                                    }
                                }

                                // === Interaction ===
                                MouseArea {
                                    id: themeMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onWheel: function(event) {
                                        if (event.angleDelta.y > 0)
                                            colorList.currentIndex = Math.max(0, colorList.currentIndex - 1);
                                        else if (event.angleDelta.y < 0)
                                            colorList.currentIndex = Math.min(colorList.count - 1, colorList.currentIndex + 1);
                                        event.accepted = true;
                                    }

                                    onClicked: {
                                        if (index !== colorList.currentIndex) {
                                            colorList.currentIndex = index;
                                            return;
                                        }
                                        Colors.theme = index;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
