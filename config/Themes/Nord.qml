import QtQuick
import Quickshell
pragma Singleton

Singleton{
    id:root

    // === Global ===
    property color shellBackgroundColor: "#2E3440"
    property color overviewSurfaceColor: "#004C566A"
    property color mainTextColor: "#D8DEE9"
    property color secondaryTextColor: "#c8D8DEE9"
    property color mainIconColor: mainTextColor
    property color aliveIconColor: "#ECEFF4"
    property color activeColor: "#88C0D0"
    property color focusColor: mainTextColor
    property color lowFocusColor: "#214C566A"

    // === Battery ===
    property color batteryIconColor: activeColor
    property color batteryTextColor: mainTextColor

    // === Curves ===
    property color curvesTransparentColor: "Transparent"

    // === Level bar ===
    property color levelBarBackgroundColor: mainTextColor
    property color levelBarFillColor: overviewIndicatorColor

    // === Level ring ===

    // === Brightness ===
    property color brightnessIconColor: activeColor
    property color brightnessTextColor: mainTextColor

    // === Volume ===
    property color volumeIconColor: activeColor
    property color volumeTextColor: mainTextColor

    // === Workspace ===
    property color workspaceActiveColor: activeColor
    property color workspaceAliveColor: aliveIconColor
    property color workspaceInactiveColor: mainIconColor
    property color workspaceTransparentColor: "Transparent"

    // === Clock ===
    property color clockTextColor: mainTextColor

    // === Spotify ===
    property color spotifyPanelColor: "Transparent"
    property color spotifyAlbumPlaceholderColor: "#3B4252"
    property color spotifyTitleColor: mainTextColor
    property color spotifyArtistColor: secondaryTextColor
    property color spotifyControlColor: mainTextColor
    property color spotifyControlIconColor: shellBackgroundColor
    property color spotifyPlayColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.8)

    // === Progress indicators ===
    property color levelRingBackgroundColor: "#3B4252"
    property color levelRingFillColor: "#BF616A"
    property color levelRingTrackColor: "Transparent"
    property color levelRingValueTextColor: "white"
    property color indicatorColor: "#A3BE8C"
    property color indicatorIconColor: aliveIconColor
    property color indicatorTrackColor: Qt.rgba(1, 1, 1, 0.12)

    // === Rou indicator ===
    property color rouIndicatorColor: indicatorColor
    property color rouIndicatorIconColor: indicatorIconColor
    property color rouIndicatorTrackColor: indicatorTrackColor

    // === Popups ===
    property color pop8MenuColor: shellBackgroundColor
    property color pop8TransparentColor: "Transparent"
    property color pop8ShadowColor: shellBackgroundColor

    // === Launcher ===
    property color launcherPanelColor: "Transparent"
    property color launcherBorderColor: "Transparent"
    property color launcherPrimaryTextColor: "#EBCB8B"
    property color launcherDimTextColor: mainTextColor
    property color launcherAccentColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.3)  // dont change
    property color launcherAccentIconColor: "Transparent"
    property color launcherSearchBackgroundColor: Qt.rgba(1, 1, 1, 0.07)
    property color launcherSearchFocusColor: activeColor
    property color launcherIconBubbleColor: Qt.rgba(1, 1, 1, 0.08)
    property color launcherDragHandleColor: "Transparent"

    // === Power menu ===
    property color powerButtonColor: shellBackgroundColor
    property color powerIconColor: mainIconColor
    property color powerFocusedIconColor: activeColor
    property color powerMenuTransparentColor: "Transparent"

    // === Bar ===
    property color barBorderColor: shellBackgroundColor
    property color barTransparentColor: "Transparent"

    // === Taskbar ===
    property color taskbarTextColor: mainTextColor
    property color taskbarActiveColor: activeColor

    // === Wallpaper ===
    property color wallpaperTransparentColor: "Transparent"
    property color wallpaperLoadingTextColor: mainTextColor

    // === Overview ===
    property color overviewTextColor: mainTextColor
    property color overviewSecondaryTextColor: secondaryTextColor
    property color overviewSurfaceFillColor: "Transparent"    // dont chnage
    property color overviewIndicatorColor: activeColor
    property color overviewIndicatorIconColor: mainIconColor
    property color overviewWarningColor: activeColor // for temperature value
    property color overviewNormalColor: mainTextColor // for temperature value

    // === Power bar ===
    property color powerBarBackgroundColor: shellBackgroundColor
    property color powerBarTextColor: mainTextColor
    property color powerBarIconColor: mainIconColor
    property color powerBarActiveColor: activeColor
    property color powerBarTransparentColor: "Transparent"

}
