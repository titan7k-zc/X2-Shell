pragma Singleton
import QtQuick
import Quickshell
import QtCore

Singleton {
    id: root

    property alias theme: stheme.theme 

    Settings {
        id: stheme
        property int theme: 0
    }

    property int themeAnimationDuration: 800

    // property var themeColors: [["sam1", "#282828", "#2bc1b086", "#f5d69d", "#c7ba9a", "#6bc7ba9a", "#87dd6363"]]

property var themeColors: [

        ["Cherry",           "#1E1418", "#2bD7BBC3", "#FF8FA3", "#D7BBC3", "#6bD7BBC3", "#87E0505F"],
        ["Crimson",          "#000000", "#2bB0B0B0", "#ED1358", "#B0B0B0", "#6bB0B0B0", "#87FFA040"],
        ["Nord",             "#2E3440", "#2bD8DEE9", "#88C0D0", "#D8DEE9", "#6bD8DEE9", "#87BF616A"],
        ["Monochrome",       "#0A0A0A", "#2bD0D0D0", "#FFFFFF", "#D0D0D0", "#6bD0D0D0", "#87FF6B6B"],
        ["Gruvbox",          "#282828", "#2bD5C4A1", "#83A598", "#D5C4A1", "#6bD5C4A1", "#87FB4934"],
        ["Paper White",      "#BAB6B6", "#2b2A2A2A", "#000000", "#2A2A2A", "#6b2A2A2A", "#87B00020"],
        ["Polar Night",      "#242933", "#2bC8D0DC", "#88C0D0", "#C8D0DC", "#6bC8D0DC", "#87BF616A"],

        ["Warm Sand",         "#282828",      "#2bc1b086",    '#f5d69d',   '#d0c29f',   "#6bc7ba9a",    "#87dd6363"],
        ["Matcha Sage",       "#1e231f",      "#2b8fa893",    "#b8e0b9",   "#9cb39f",   "#6b9cb39f",    "#87dd6b63"],
        ["Nordic Ice",        "#1b2028",      "#2b849db3",    "#a3d4f7",   "#96adc2",   "#6b96adc2",    "#87db6571"],
        ["Rosewater",         "#241c20",      "#2bb58e98",    "#f5b8c8",   "#c7a5ae",   "#6bc7a5ae",    "#87e06666"],
        ["Espresso Cream",    "#1f1b18",      "#2bb59984",    "#f2c9a7",   "#c4ae9b",   "#6bc4ae9b",    "#87d9625b"],
        ["Lavender Haze",     "#1e1c26",      "#2b968bb3",    "#cdb8f7",   "#ada3c7",   "#6bada3c7",    "#87e06680"],
        ["Amber Glow",        "#241e17",      "#2bc2986b",    "#f7c688",   "#c7ad8c",   "#6bc7ad8c",    "#87d95b5b"],
        ["Ocean Mist",        "#172224",      "#2b7eaba8",    "#9df0e8",   "#93bdb9",   "#6b93bdb9",    "#87db6b6b"],
        ["Crimson Velvet",    "#211719",      "#2bb87d87",    "#f79ca9",   "#c799a0",   "#6bc799a0",    "#87f05454"],
        ["Slate Monochrome",  "#1c1c1e",      "#2b9e9ea6",    "#e5e5ea",   "#b5b5bd",   "#6bb5b5bd",    "#87d96565"],
        ["Pistachio",         "#21241c",      "#2ba8b384",    "#d8f09d",   "#b5c296",   "#6bb5c296",    "#87db675c"],
        ["Twilight Plum",     "#221a24",      "#2bad84b3",    "#ebb3f5",   "#bfa1c4",   "#6bbfa1c4",    "#87e06674"],
        ["Cyber Mint",        "#141c1a",      "#2b6eb59e",    "#8cf7d4",   "#8cc4b2",   "#6b8cc4b2",    "#87e35f75"],
        ["Sunset Peach",      "#261d1c",      "#2bc28e86",    "#f7b5a8",   "#c7a59e",   "#6bc7a59e",    "#87e05858"],
        ["Deep Cobalt",       "#161a24",      "#2b7f8fb5",    "#a6c0f7",   "#97a5c4",   "#6b97a5c4",    "#87de646e"],
        ["Evergreen Gold",    "#19211d",      "#2bb0a882",    "#ebd99b",   "#bdb799",   "#6bbdb799",    "#87d9665f"]
    ]









    // // === Global ===

    property color shadowColor: getShadowColor() 
    property color background: themeColors[theme][1]
    property color surface: themeColors[theme][2]
    property color active: themeColors[theme][3]
    property color primary: themeColors[theme][4]
    property color secondary: themeColors[theme][5]
    property color s0: primary
    property color s1: active
    property color s2: themeColors[theme][6]









    property real shadowOpacity: 0.7
    readonly property color shellFallbackShadowColor: '#000000' 

    function getShadowColor() {
        var selectedTheme = themeColors[theme]
        return selectedTheme && selectedTheme.length > 7 && selectedTheme[7] ? selectedTheme[7] : shellFallbackShadowColor
    }

    Behavior on shadowColor {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on background {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on surface {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on active {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on primary {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on secondary {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on s0 {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on s1 {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    Behavior on s2 {ColorAnimation {duration: root.themeAnimationDuration;easing.type: Easing.InOutQuad}}
    // === Brightness ===
    Behavior on brightnessIconColor { ColorAnimation { duration: root.themeAnimationDuration; easing.type: Easing.InOutQuad } }
    // === Volume ===
    Behavior on volumeIconColor { ColorAnimation { duration: root.themeAnimationDuration; easing.type: Easing.InOutQuad } }
    // === Battery ===
    Behavior on batteryIconColor { ColorAnimation { duration: root.themeAnimationDuration; easing.type: Easing.InOutQuad } }



    // property color background: '#282828'
    // property color surface: '#2bc1b086'

    // property color active: '#f5d69d' 
    // property color primary: '#c7ba9a' 
    // property color secondary: '#6bc7ba9a'
    
    // property color s0: primary
    // property color s1: active
    // property color s2: '#87dd6363'






                                                                                                                // background
    
    
    // === Popups ===
    readonly property color pop8MenuColor: background
    // === Bar ===
    readonly property color barBorderColor: background
    // spotify
    readonly property color spotifyControlIconColor: background
    // performance , battery 
    readonly property color performanceCtrlActiveTextColor: background
    readonly property color batteryCtrlActiveTextColor: background
    // === Notification counter ===
    readonly property color notificationCounterIconColor: background
    readonly property color notificationCounterTextColor: background
    // === Control center ===
    readonly property color controlCenterButtonActiveIconColor: background
    
    //=========


                                                                                                                // primary   
    // === Workspace ===
    readonly property color workspaceInactiveColor: primary
    // === Weather ===
    readonly property color weatherPrimaryTextColor: primary
    // === Clock ===
    readonly property color powerBarTextColor: primary
    // === Cava ===
    readonly property color cavaBarColor: primary
    // === Brightness ,Volume, Battery ===
    property color brightnessIconColor:primary 
    property color volumeIconColor:primary 
    property color batteryIconColor: primary
    // power menue
    readonly property color powerIconColor: primary
    // === Overview ===
    readonly property color overviewTextColor: primary
    readonly property color overviewNormalColor: primary // for temperature value
    readonly property color overviewIndicatorIconColor: primary
    // wallpaper theme
    readonly property color wallpaperLoadingTextColor: primary
    readonly property color wallpaperThemeTextColor: primary
    // performance , battery 
    readonly property color performanceCtrlTextColor: primary
    readonly property color batteryCtrlTextColor: primary
    // === Control center ===
    readonly property color controlCenterButtonIconColor: primary






    // === Brightness ,Volume, Battery ===
    readonly property color brightnessTextColor: primary
    readonly property color volumeTextColor: primary
    readonly property color batteryTextColor: primary
                                                                                                                // secondary


    // overview
    readonly property color overviewSecondaryTextColor: secondary
    // spotify
    readonly property color spotifyArtistColor: secondary
    readonly property color spotifyControlColor2: Qt.rgba(secondary.r, secondary.g, secondary.b, 0.7)
    // wallpaper theme
    readonly property color wallpaperThemeSelectedColor: secondary



                                                                                                                // active
    // == workspace ===
    readonly property color workspaceActiveColor: active
    readonly property color workspaceAliveColor: active

    // == battery, performance, notification ===
    readonly property color batteryCtrlActiveColor: active
    readonly property color performanceCtrlActiveColor: active
    readonly property color notificationCounterBackgroundColor: active
    // === Power menu ===
    readonly property color powerFocusedIconColor: active
    // === wallpaper theme ===
    readonly property color wallpaperThemeIconColor: active
    readonly property color wallpaperThemeActiveColor: active
    readonly property color wallpaperThemeBackgroundColor:Qt.rgba(active.r, active.g, active.b, 0.1)// "#a9000000"
    // === Overview ===
    readonly property color overviewIndicatorColor: active
    readonly property color overviewIndicatorTrackColor: Qt.rgba(overviewIndicatorColor.r, overviewIndicatorColor.g, overviewIndicatorColor.b, 0.1)//Qt.rgba(1, 1, 1, 0.12)
    readonly property color overviewWarningColor: active // for temperature value
    // === LevelBar ===
    readonly property color levelBarBackgroundColor: Qt.rgba(active.r, active.g, active.b, 0.1)//mainTextColor 
    readonly property color levelBarFillColor: active 
    // spotify
    readonly property color spotifyTitleColor: active
    readonly property color spotifyPlayColor: Qt.rgba(active.r, active.g, active.b, 0.8)
    readonly property color spotifyAlbumBorderColor: Qt.rgba(active.r, active.g, active.b, 0.7)
    // == taskbar ===
    readonly property color taskbarActiveColor: active
    // === Control center ===
    readonly property color controlCenterButtonHoverColor: Qt.rgba(active.r, active.g, active.b, 0.18)
    readonly property color controlCenterButtonPressedColor: Qt.rgba(active.r, active.g, active.b, 0.28)
    readonly property color controlCenterButtonActiveColor: Qt.rgba(active.r, active.g, active.b, 0.88)
    readonly property color controlCenterButtonBorderColor: Qt.rgba(active.r, active.g, active.b, 0.30)
    readonly property color controlCenterButtonActiveBorderColor: Qt.rgba(active.r, active.g, active.b, 0.95)

    

    
    




                                                                                                                // surface

    // wifi , bluetooth , notification header
    readonly property color bluetoothHeaderColor: surface
    readonly property color wifiHeaderColor: surface
    readonly property color notificationHeaderColor: surface


    // === Bluetooth ===
    readonly property color bluetoothBackgroundColor: "Transparent"
    readonly property color bluetoothPrimaryTextColor: primary//mainTextColor                                                              // scan , primaryTextColor , icon_bg with op , sign_bg with op
    readonly property color bluetoothSecondaryTextColor: secondary//secondaryTextColor                                                        // secondaryTextColor
    readonly property color bluetoothMutedTextColor: secondary//mainIconColor                                                                 // item icon , empty scanner , clear  
    readonly property color bluetoothActiveColor: active//activeColor                                                                       // active second text, icon, icon bg , scanning(both) 
    readonly property color bluetoothInactiveColor: primary//mainIconColor                                                            // main icon
    readonly property color bluetoothToggleOnColor: active//activeColor
    readonly property color bluetoothToggleOffColor: primary//Qt.rgba(mainIconColor.r, mainIconColor.g, mainIconColor.b, 0.35)
    readonly property color bluetoothToggleKnobOnColor: background
    readonly property color bluetoothToggleKnobOffColor: background
    readonly property color bluetoothBatteryColor: primary
    readonly property color bluetoothBatteryLowColor: s2

    
    // === Wi-Fi ===
    readonly property color wifiBackgroundColor: "Transparent" 
    readonly property color wifiDeviceBackgroundColor: background//Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.7)    // <- password field background color
    readonly property color wifiDeviceSurfaceColor: surface//Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.12)      // cancel , passowrd enter filed
    readonly property color wifiPrimaryTextColor: primary
    readonly property color wifiSecondaryTextColor: secondary
    readonly property color wifiMutedTextColor: secondary
    readonly property color wifiActiveColor: active
    readonly property color wifiInactiveColor: primary
    readonly property color wifiToggleOnColor: active
    readonly property color wifiToggleOffColor: primary//Qt.rgba(mainIconColor.r, mainIconColor.g, mainIconColor.b, 0.35)
    readonly property color wifiToggleKnobOnColor: background
    readonly property color wifiToggleKnobOffColor: background
    readonly property color wifiSignalColor: primary
    readonly property color wifiSignalLowColor: s2 

    
    // === Notifications ===
    readonly property color notificationPanelColor: "Transparent"
    readonly property color notificationCardColor: "Transparent"//Qt.rgba(secondary.r, secondary.g, secondary.b, 0.05)//Qt.tint(shellBackgroundColor, Qt.rgba(mainTextColor.r, mainTextColor.g, mainTextColor.b, 0.07))   // lifts on dark themes, sinks on light themes
    readonly property color notificationCarHoverdColor: Qt.rgba(secondary.r, secondary.g, secondary.b, 0.06)//Qt.tint(shellBackgroundColor, Qt.rgba(mainTextColor.r, mainTextColor.g, mainTextColor.b, 0.12))   // lifts on dark themes, sinks on light themes
    readonly property color notificationBorderColor: "Transparent"//secondary//Qt.rgba(mainTextColor.r, mainTextColor.g, mainTextColor.b, 0.08)
    readonly property color notificationBorderHoverColor: active//"//Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.40)
    readonly property color notificationTitleColor: primary//mainTextColor
    readonly property color notificationBodyColor: secondary
    readonly property color notificationCloseIconColor: secondary              // x button
    readonly property color notificationIconBackgroundColor: secondary//Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.12)
    readonly property color notificationIconTextColor: primary//activeColor
    readonly property color notificationHeaderTextColor: primary
    readonly property color notificationBadgeColor: secondary
    readonly property color notificationBadgeTextColor: background
    readonly property color notificationClearButtonBorderColor: primary//Qt.rgba(mainIconColor.r, mainIconColor.g, mainIconColor.b, 0.35)
    readonly property color notificationClearButtonTextColor: primary//mainTextColor
    readonly property color notificationEmptyColor: secondary
    readonly property color notificationLowColor: s1
    readonly property color notificationNormalColor: s0
    readonly property color notificationCriticalColor: s2
 
 

  


  

 







































    // === Launcher ===
    readonly property color launcherPanelColor: "Transparent"
    readonly property color launcherBorderColor: "Transparent"
    readonly property color launcherAccentIconColor: "Transparent"
    readonly property color launcherDragHandleColor: "Transparent"

    readonly property color launcherDimTextColor: primary
    readonly property color launcherPrimaryTextColor: secondary//mainTextColor//"#EBCB8B"             need to fix bcz selsected text aslo using this ..
    readonly property color launcherAccentColor: Qt.rgba(active.r, active.g, active.b, 0.3)  // dont change  
    readonly property color launcherSearchBackgroundColor: Qt.rgba(1, 1, 1, 0.07)
    readonly property color launcherSearchFocusColor: active
    readonly property color launcherIconBubbleColor: Qt.rgba(1, 1, 1, 0.08)





    // === cava ===
    readonly property color cavaBackgroundColor: "Transparent" // background color
    // readonly property color cavaAccentBarColor: Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 1.0)  
    readonly property color cavaAccentBarColor: Qt.rgba(active.r, active.g, active.b, 1.0)// need to check
    readonly property real cavaBarGradientMinimumOpacity: 0.4
    readonly property real cavaBarGradientOpacityRange: 0.6

    // === Control center ===
    readonly property color controlCenterButtonColor: "Transparent"//Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.10)

    // === Overview ===    
    readonly property color overviewSurfaceFillColor: "Transparent"    // dont chnage

    // === Workspace ===
    readonly property color workspaceTransparentColor: "transparent"

    // === Battery control ===
    readonly property color batteryCtrlBackgroundColor: "transparent"

    // === Performance control ===
    readonly property color performanceCtrlBackgroundColor: "Transparent"

    // === Popup menu ===
    readonly property color popupMenuTransparentColor: "transparent"
    
    // === Power menu ===
    readonly property color powerButtonColor: "Transparent"

    // === Spotify ===
    readonly property color spotifyPanelColor: "Transparent"
    readonly property color spotifyAlbumPlaceholderColor: "#3B4252"
    
    // === Wallpaper ===
    readonly property color wallpaperSwitcherTransparentColor: "transparent"
    
    // === Notifications ===
    readonly property color notificationClearButtonBackgroundColor: "transparent"
    readonly property real notificationPanelBorderOpacity: 0.06

    // === Control center ===
    readonly property color controlCenterTransparentColor: "transparent"

    // === Launcher ===
    readonly property color launcherSearchInputColor: "transparent"

    // === Power menu ===
    readonly property color powerMenuSurfaceColor: "transparent"

    // === Weather ===
    readonly property color weatherBackgroundColor: "transparent"
    readonly property color weatherTransparentColor: "transparent"
    readonly property real weatherSecondaryTextOpacity: 0.4

    // === Curves ===
    readonly property color curvesStrokeColor: "transparent"





    // === Shared bar components ===
    readonly property color barBackgroundColor: "transparent"
    readonly property color barShadowColor: getShadowColor()
    readonly property real barShadowOpacity: 0.7
    readonly property color barV2ShadowColor: getShadowColor()
    readonly property real barV2ShadowOpacity: 0.7
    readonly property color topBarShadowColor: getShadowColor()
    readonly property real topBarShadowOpacity: 0.7
    readonly property color rightBottomBarShadowColor: getShadowColor()
    readonly property real rightBottomBarShadowOpacity: 0.7
    readonly property color leftBottomBarShadowColor: getShadowColor()
    readonly property real leftBottomBarShadowOpacity: 0.7
    readonly property color rightTopBarShadowColor: getShadowColor()
    readonly property real rightTopBarShadowOpacity: 0.7
    readonly property color leftTopBarShadowColor: getShadowColor()
    readonly property real leftTopBarShadowOpacity: 0.7
    readonly property color popupMenuShadowColor: getShadowColor()
    readonly property real popupMenuShadowOpacity: 0.7
    readonly property color pop8PopupShadowColor: getShadowColor()
    readonly property color barBorderFallbackColor: "black"
    readonly property color barPowerTransparentColor: "transparent"
    readonly property color barTopTextSecondaryColor: Qt.rgba(powerBarTextColor.r, powerBarTextColor.g, powerBarTextColor.b, 0.7)  // need to check 






    // === Taskbar ===
    readonly property color taskbarTextColor: primary // component is not active but for future use








    // === Bluetooth ===
    readonly property color bluetoothRadarColor: primary
    readonly property color bluetoothRadarFillColor: "transparent"
    readonly property color bluetoothBadgeBackgroundColor: "transparent"
    readonly property color bluetoothScanButtonBackgroundColor: "transparent"
    readonly property color bluetoothClearButtonBackgroundColor: "transparent"
    readonly property color bluetoothDeviceSectionBackgroundColor: "transparent"
    readonly property color bluetoothDeviceCardBackgroundColor: "transparent"
    readonly property real bluetoothPanelBorderOpacity: 0.06
    readonly property real bluetoothConnectedBorderOpacity: 0.4
    readonly property real bluetoothConnectedOverlayOpacity: 0.16
    readonly property real bluetoothNeutralOverlayOpacity: 0.05
    readonly property real bluetoothBatteryIndicatorOpacity: 0.3
    readonly property real bluetoothSecondaryTrackOpacity: 0.6

    // === Wi-Fi ===
    readonly property color wifiRadarColor: primary 
    readonly property color wifiRadarFillColor: "transparent"
    readonly property color wifiPromptButtonTextColor: "white"
    readonly property color wifiPromptButtonHoverColor: "white"
    readonly property color wifiPromptButtonHoverOverlayColor: "white"
    readonly property color wifiBadgeBackgroundColor: "transparent"
    readonly property color wifiDeviceSectionBackgroundColor: "transparent"
    readonly property color wifiNetworkCardBackgroundColor: "transparent"
    readonly property color wifiPasswordFieldBackgroundColor: "transparent"
    readonly property real wifiPanelBorderOpacity: 0.06
    readonly property real wifiConnectedBorderOpacity: 0.4
    readonly property real wifiConnectedOverlayOpacity: 0.16
    readonly property real wifiNeutralOverlayOpacity: 0.05
    readonly property real wifiInputBorderOpacity: 0.06
    readonly property real wifiSignalIndicatorOpacity: 0.3
    readonly property real wifiSecondaryTrackOpacity: 0.6
    readonly property real wifiInputFocusBorderOpacity: 0.5
    readonly property real wifiInputSelectionOpacity: 0.4



    // === Power bar / topbar ===
    readonly property color powerBarBulletColor: Qt.rgba(background.r, background.g, background.b, 0.3)




}
