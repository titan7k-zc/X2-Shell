import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    // === Global ===
    property color shellBackgroundColor: "#191724"
    property color overviewSurfaceColor: "#26233a"
    property color mainTextColor: "#e0def4"
    property color secondaryTextColor: "#908caa"
    property color mainIconColor: mainTextColor
    property color aliveIconColor: '#95ff93'
    property color activeColor: "#eb6f92"
    property color focusColor: "#c4a7e7"
    property color lowFocusColor: "#6e6a86"

    // === Battery ===
    property color batteryIconColor: activeColor
    property color batteryTextColor: mainTextColor

    // === Curves ===
    property color curvesTransparentColor: "Transparent"

    // === Level bar ===
    property color levelBarBackgroundColor: secondaryTextColor
    property color levelBarFillColor: overviewIndicatorColor

    // === Level ring ===

    // === Brightness ===
    property color brightnessIconColor: aliveIconColor
    property color brightnessTextColor: mainTextColor

    // === Volume ===
    property color volumeIconColor: focusColor
    property color volumeTextColor: mainTextColor

    // === Workspace ===
    property color workspaceActiveColor: activeColor
    property color workspaceAliveColor: activeColor
    property color workspaceInactiveColor: mainIconColor
    property color workspaceTransparentColor: "Transparent"

    // === Clock ===
    property color clockTextColor: mainTextColor

    // === Spotify ===
    property color spotifyPanelColor: "Transparent"
    property color spotifyAlbumPlaceholderColor: "#26233a"
    property color spotifyTitleColor: mainTextColor
    property color spotifyArtistColor: secondaryTextColor
    property color spotifyControlColor: mainTextColor
    property color spotifyControlIconColor: shellBackgroundColor
    property color spotifyPlayColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.8)

    // === Progress indicators ===
    property color levelRingBackgroundColor: "#26233a"
    property color levelRingFillColor: "#eb6f92"
    property color levelRingTrackColor: "Transparent"
    property color levelRingValueTextColor: "#f6c177"
    property color indicatorColor: "#9ccfd8"
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
    property color launcherPrimaryTextColor: "#f6c177"
    property color launcherDimTextColor: secondaryTextColor
    property color launcherAccentColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.3)
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
    property color overviewSurfaceFillColor: "Transparent"
    property color overviewIndicatorColor: activeColor
    property color overviewIndicatorIconColor: mainIconColor
    property color overviewWarningColor: activeColor
    property color overviewNormalColor: mainTextColor

    // === Power bar ===
    property color powerBarBackgroundColor: shellBackgroundColor
    property color powerBarTextColor: mainTextColor
    property color powerBarIconColor: mainIconColor
    property color powerBarActiveColor: activeColor
    property color powerBarTransparentColor: "Transparent"
}