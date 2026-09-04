import QtQuick
import Quickshell
pragma Singleton

Singleton{
    id:root

    // === Global ===
    property color shellBackgroundColor: "#000000"
    property color overviewSurfaceColor: "#00b3b3b3"
    property color mainTextColor: "#959595"
    property color secondaryTextColor: "#c8959595"
    property color mainIconColor: mainTextColor
    property color aliveIconColor: "#ffffff"
    property color activeColor: "#ef2a68"
    property color focusColor: mainTextColor
    property color lowFocusColor: "#21949494"
    property color transparentColor: "transparent"

    // === Battery ===
    property color batteryIconColor: activeColor
    property color batteryTextColor: mainTextColor

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
    property color workspaceTransparentColor: transparentColor

    // === Clock ===
    property color clockTextColor: mainTextColor

    // === Spotify ===
    property color spotifyPanelColor: transparentColor
    property color spotifyAlbumPlaceholderColor: "#2a2a35"
    property color spotifyTitleColor: mainTextColor
    property color spotifyArtistColor: secondaryTextColor
    property color spotifyControlColor: mainTextColor
    property color spotifyControlIconColor: shellBackgroundColor
    property color spotifyPlayColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.8)

    // === Progress indicators ===
    property color levelRingBackgroundColor: "#303030"
    property color levelRingFillColor: "red"
    property color levelRingTrackColor: transparentColor
    property color levelRingValueTextColor: "white"
    property color indicatorColor: "#00c896"
    property color indicatorIconColor: aliveIconColor
    property color indicatorTrackColor: Qt.rgba(1, 1, 1, 0.12)

    // === Launcher ===
    property color launcherPanelColor: transparentColor
    property color launcherBorderColor: transparentColor
    property color launcherPrimaryTextColor: "#F3E7BF"
    property color launcherDimTextColor: mainTextColor
    property color launcherAccentColor: "#9F7355"
    property color launcherAccentIconColor: transparentColor
    property color launcherSearchBackgroundColor: Qt.rgba(1, 1, 1, 0.07)
    property color launcherSearchFocusColor: activeColor
    property color launcherIconBubbleColor: Qt.rgba(1, 1, 1, 0.08)
    property color launcherDragHandleColor: transparentColor

    // === Power menu ===
    property color powerButtonColor: shellBackgroundColor
    property color powerIconColor: mainIconColor
    property color powerFocusedIconColor: activeColor

    // === Bar ===
    property color barBorderColor: shellBackgroundColor
    property color barTransparentColor: transparentColor

    // === Overview ===
    property color overviewTextColor: mainTextColor
    property color overviewSecondaryTextColor: secondaryTextColor
    property color overviewSurfaceFillColor: overviewSurfaceColor
    property color overviewIndicatorColor: activeColor
    property color overviewIndicatorIconColor: mainIconColor
    property color overviewWarningColor: activeColor
    property color overviewNormalColor: mainTextColor

    // === Power bar ===
    property color powerBarBackgroundColor: shellBackgroundColor
    property color powerBarTextColor: mainTextColor
    property color powerBarIconColor: mainIconColor
    property color powerBarActiveColor: activeColor
    property color powerBarTransparentColor: transparentColor


}