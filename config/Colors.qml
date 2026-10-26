pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import QtCore

Singleton {
    id: root

    property alias theme: stheme.theme 

    Settings {
        id: stheme
        property int theme: 0
    }

    property int themeAnimationDuration: 800



    // system color ctrl
    onThemeChanged: {
        setSysColorProcess.c1 = Colors.themeColors[root.theme][3]
        setSysColorProcess.c2 = Colors.themeColors[root.theme][4]
        setSysColorProcess.running = true 
    }

    Process {
        id: setSysColorProcess

        running: false

        property color c1: undefined
        property color c2: undefined 
 
        command: [
            "sudo",
            "/usr/bin/python",
            "/home/titan/.config/quickshell/X2-Shell/scripts/C_runner.py",
            "sys_conf",
            c1,
            c2           
        ]
 
    }












    // property var themeColors: [["sam1", "#282828", "#2bc1b086", "#f5d69d", "#c7ba9a", "#6bc7ba9a", "#87dd6363"]]

// property var themeColors: [
//     ["Cherry",           "#1E1418", "#2bD7BBC3", "#FF8FA3", "#D7BBC3", "#6bD7BBC3", "#87E0505F"],
//     ["Crimson",          "#000000", "#2bB0B0B0", "#ED1358", "#B0B0B0", "#6bB0B0B0", "#87FFA040"],
//     ["Nord",             "#2E3440", "#2bD8DEE9", "#88C0D0", "#D8DEE9", "#6bD8DEE9", "#87BF616A"],
//     ["Monochrome",       "#0A0A0A", "#2bD0D0D0", "#FFFFFF", "#D0D0D0", "#6bD0D0D0", "#87FF6B6B"],
//     ["Ayu Dark",         "#0D1017", "#2bB7BDC5", "#E6B450", "#B7BDC5", "#6bB7BDC5", "#87F07178"],
//     ["Coffee Dark",      "#211B18", "#2bD1C0B7", "#D9A066", "#D1C0B7", "#6bD1C0B7", "#87D0584F"],
//     ["Gruvbox",          "#282828", "#2bD5C4A1", "#83A598", "#D5C4A1", "#6bD5C4A1", "#87FB4934"],
//     ["Warm Sand",        "#282828", "#2bc1b086", '#f5d69d', '#d0c29f', "#6bc7ba9a", "#87dd6363"],



//     ["Warm Sand2",       '#1a1a1a', "#323232", '#fff1c6', '#9a8f73', "#6bc7ba9a", "#87dd6363"],
    
    
     
    
    
//     ["Paper White",      "#BAB6B6", "#2b2A2A2A", "#000000", "#2A2A2A", "#6b2A2A2A", "#87B00020"],
//     ["Nord Frost",       "#2E3440", "#2bD8DEE9", "#8FBCBB", "#D8DEE9", "#6bD8DEE9", "#87BF616A"],
//     ["Polar Night",      "#242933", "#2bC8D0DC", "#88C0D0", "#C8D0DC", "#6bC8D0DC", "#87BF616A"],
//     ["Blue Steel",       "#202833", "#2bB8C7D9", "#6FA8DC", "#B8C7D9", "#6bB8C7D9", "#87E06C75"],
//     ["Deep Ocean",       "#0D1B24", "#2bB0C4CC", "#5FB3B3", "#B0C4CC", "#6bB0C4CC", "#87E5646E"],
//     ["Aurora",           "#182027", "#2bB9CCC7", "#A3BE8C", "#B9CCC7", "#6bB9CCC7", "#87BF616A"],
//     ["Catppuccin Mocha", "#1E1E2E", "#2bBAC2DE", "#89B4FA", "#BAC2DE", "#6bBAC2DE", "#87F38BA8"],
//     ["Tokyo Night",      "#1A1B26", "#2bA9B1D6", "#7AA2F7", "#A9B1D6", "#6bA9B1D6", "#87F7768E"],
//     ["Dracula",          "#282A36", "#2bF8F8F2", "#BD93F9", "#F8F8F2", "#6bF8F8F2", "#87FF5555"],
//     ["Emerald Night",    "#14181F", "#2bC5CDD9", "#4FD1A5", "#C5CDD9", "#6bC5CDD9", "#87F0647A"],
//     ["Rose Pine",        "#191724", "#2bE0DEF4", "#C4A7E7", "#E0DEF4", "#6bE0DEF4", "#87EB6F92"],
//     ["Everforest",       "#2D353B", "#2bD3C6AA", "#A7C080", "#D3C6AA", "#6bD3C6AA", "#87E67E80"],
//     ["One Dark",         "#282C34", "#2bABB2BF", "#61AFEF", "#ABB2BF", "#6bABB2BF", "#87E06C75"],
//     ["Kanagawa",         "#1F1F28", "#2bC8C093", "#7E9CD8", "#C8C093", "#6bC8C093", "#87E82424"],
//     ["Nord Aurora",      "#3B4252", "#2bE5E9F0", "#88C0D0", "#E5E9F0", "#6bE5E9F0", "#87BF616A"],
//     ["Material Ocean",   "#0F111A", "#2bC5C8C6", "#82AAFF", "#C5C8C6", "#6bC5C8C6", "#87F07178"],
//     ["Moonlight",        "#222436", "#2bA9B8E8", "#82AAFF", "#A9B8E8", "#6bA9B8E8", "#87FF757F"],
//     ["Horizon",          "#1C1E26", "#2bD5D8DA", "#FAB795", "#D5D8DA", "#6bD5D8DA", "#87E95678"],
//     ["Monokai",          "#272822", "#2bF8F8F2", "#66D9EF", "#F8F8F2", "#6bF8F8F2", "#87F92672"],
//     ["Solarized Dark",   "#002B36", "#2b93A1A1", "#268BD2", "#93A1A1", "#6b93A1A1", "#87DC322F"],
//     ["Cyberpunk",        "#0B0E14", "#2bC5C8C6", "#00E5FF", "#C5C8C6", "#6bC5C8C6", "#87FF00A8"],
//     ["Synthwave",        "#241B2F", "#2bE6E1FF", "#FF7EDB", "#E6E1FF", "#6bE6E1FF", "#87FE4450"],
//     ["Amethyst",         "#17131F", "#2bD4C5E2", "#A970FF", "#D4C5E2", "#6bD4C5E2", "#87F0647A"],
//     ["Oceanic",          "#0B1E26", "#2bB8CDD2", "#5CCFE6", "#B8CDD2", "#6bB8CDD2", "#87F0646E"],
//     ["Forest Night",     "#101A16", "#2bB9D0C1", "#78C091", "#B9D0C1", "#6bB9D0C1", "#87E5646E"],
//     ["Midnight",         "#10141C", "#2bB8C2D1", "#6C8ED4", "#B8C2D1", "#6bB8C2D1", "#87E06C75"],
//     ["Obsidian",         "#111111", "#2bC8C8C8", "#6EA8FE", "#C8C8C8", "#6bC8C8C8", "#87F14C4C"],
//     ["Slate",            "#20242B", "#2bBEC6D1", "#7FA6D9", "#BEC6D1", "#6bBEC6D1", "#87E06C75"],
//     ["Arctic",           "#18212B", "#2bC7D5E3", "#72B7FF", "#C7D5E3", "#6bC7D5E3", "#87F0707A"],
//     ["Deep Purple",      "#181520", "#2bC8BED8", "#9B7BFF", "#C8BED8", "#6bC8BED8", "#87F0647A"],
//     ["Lavender",         "#191722", "#2bCAC2DF", "#A78BFA", "#CAC2DF", "#6bCAC2DF", "#87F0647A"],
// ]



property var themeColors: [
    // [Theme, Background, Surface, Active, Primary, Secondary, Warning, Shadow]

    ["Cherry",           "#1E1418", "#1AD7BBC3", "#FF8FA3", "#F0DCE2", "#A98A94", "#FF6B81", "#100B0D"],
    ["Crimson",          "#000000", '#30959595', "#ED1358", "#B0B0B0", "#959595", "#EF2A68", "#0E0000"],
    ["Nord",             "#2E3440", "#1A88C0D0", "#88C0D0", "#D8DEE9", "#AEB8C7", "#BF616A", "#12151B"],
    ["Monochrome",       "#0A0A0A", "#14FFFFFF", "#FFFFFF", "#F5F5F5", "#8A8A8A", "#E0E0E0", '#5b5b5b'],

    ["Ayu Dark",         "#0D1017", "#1AC7D1DB", "#E6B450", "#D5D8DA", "#8A9199", "#F07178", "#070A10"],
    ["Coffee Dark",      "#211B18", "#1AD1C0B7", "#D9A066", "#E8DDD5", "#A4948C", "#E06C75", "#100C0A"],
    ["Gruvbox",          "#282828", "#1AD5C4A1", "#83A598", "#EBDBB2", "#A89984", "#FB4934", "#1A1A1A"],
    // ["Warm Sand",        "#282828", "#2bc1b086",  '#fff1c6', '#9a8f73', "#6bc7ba9a", "#87dd6363", "#1A1A1A"],
    ["Warm Sand",        "#282828", "#2bc1b086", "#f5d69d", "#c7ba9a", "#6bc7ba9a","#87dd6363",'#0b0b0b'],
    ["Paper White",      "#FAFAFA", "#14000000", "#000000", "#0A0A0A", "#6E6E6E", "#B00020", "#B8B8B8"],
  
    ["Nord Frost",       "#2E3440", "#1A81A1C1", "#81A1C1", "#ECEFF4", "#AEB8C7", "#BF616A", "#171B22"],
    ["Polar Night",      "#242933", "#1A88C0D0", "#88C0D0", "#E5E9F0", "#9AA4B2", "#BF616A", "#10141B"],
    ["Blue Steel",       "#202833", "#1A8CB4D8", "#6FA8DC", "#DCE6F2", "#8B9BAD", "#E06C75", "#121820"],
    ["Deep Ocean",       "#0D1B24", "#1A5FB3B3", "#4FA3D1", "#D6E5EA", "#78909C", "#FF6B6B", "#060D12"],
    ["Aurora",           "#182027", "#1AB48EAD", "#A3BE8C", "#DCE7E5", "#899B99", "#E67E80", "#0D1116"],

    ["Catppuccin Mocha", "#1E1E2E", "#1A89B4FA", "#89B4FA", "#CDD6F4", "#A6ADC8", "#F38BA8", "#11111B"],
    ["Tokyo Night",      "#1A1B26", "#1A7AA2F7", "#7AA2F7", "#C0CAF5", "#9AA5CE", "#F7768E", "#101018"],
    ["Dracula",          "#282A36", "#1ABD93F9", "#BD93F9", "#F8F8F2", "#BFBFBF", "#FF5555", "#191A21"],
    ["Emerald Night",    "#14181F", "#1A4FD1A5", "#4FD1A5", "#E8EDF2", "#8D98A8", "#FF6B81", "#0B0E13"],
    ["Rose Pine",        "#191724", "#1A26233A", "#9CCFD8", "#E0DEF4", "#908CAA", "#EB6F92", "#100F18"],
    ["Everforest",       "#2D353B", "#1AA7C080", "#A7C080", "#D3C6AA", "#9DA9A0", "#E67E80", "#1E2529"],

    ["One Dark",         "#282C34", "#1A61AFEF", "#61AFEF", "#ABB2BF", "#7F848E", "#E06C75", "#1C1F25"],
    ["Kanagawa",         "#1F1F28", "#1A7E9CD8", "#7E9CD8", "#DCD7BA", "#727169", "#E46876", "#11111A"],
    ["Nord Aurora",      "#3B4252", "#1A88C0D0", "#88C0D0", "#ECEFF4", "#AEB8C7", "#BF616A", "#252A34"],
    ["Material Ocean",   "#0F111A", "#1A82AAFF", "#82AAFF", "#EEFFFF", "#8F93A2", "#F07178", "#080A10"],
    ["Moonlight",        "#222436", "#1A82AAFF", "#82AAFF", "#C8D3F5", "#828BB8", "#FF757F", "#131522"],

    ["Horizon",          "#1C1E26", "#1AFAB795", "#E95678", "#D5D8DA", "#A1A1A1", "#E95678", "#111218"],
    ["Monokai",          "#272822", "#1A66D9EF", "#66D9EF", "#F8F8F2", "#A6A69C", "#F92672", "#171812"],
    ["Solarized Dark",   "#002B36", "#1A268BD2", "#268BD2", "#839496", "#657B83", "#DC322F", "#001A21"],
    ["Cyberpunk",        "#0B0E14", "#1A00E5FF", "#00E5FF", "#E6E6E6", "#7A7F8B", "#FF3366", "#05070B"],
    ["Synthwave",        "#241B2F", "#1A36F9F6", "#FF7EDB", "#F8F8F2", "#A89BB9", "#FE4450", "#140E1B"],

    ["Amethyst",         "#17131F", "#1AC8A2FF", "#C8A2FF", "#E8E0F0", "#9C91A8", "#F38BA8", "#0D0A12"],
    ["Oceanic",          "#0B1E26", "#1A4DB6E8", "#4DB6E8", "#D8E6E9", "#8199A1", "#EC5F67", "#051116"],
    ["Forest Night",     "#101A16", "#1A78C091", "#8FCB9B", "#D8E8DF", "#81968A", "#E67E80", "#080D0A"],
    ["Midnight",         "#10141C", "#1A6C8ED4", "#6C8ED4", "#D7DEE9", "#7F8A9A", "#E06C75", "#080A0F"],
    ["Obsidian",         "#111111", "#1A6EA8FE", "#6EA8FE", "#E6E6E6", "#858585", "#F44747", "#050505"],

    ["Slate",            "#20242B", "#1A7FA6D9", "#7FA6D9", "#D9DEE7", "#8B939F", "#D96C75", "#12151A"],
    ["Arctic",           "#18212B", "#1A72B7FF", "#72B7FF", "#E5EDF5", "#91A4B7", "#E06C75", "#0B121A"],
    ["Deep Purple",      "#181520", "#1A9B7BFF", "#9B7BFF", "#E6DFF2", "#9288A3", "#E06C75", "#0D0A14"],
    ["Ember",            "#211714", "#1AFF9E64", "#FF9E64", "#F0DDD5", "#A99087", "#FF6B4A", "#100A08"],
    ["Lavender",         "#191722", "#1AA78BFA", "#A78BFA", "#E4DDF5", "#9690AA", "#F38BA8", "#0E0D18"]
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
    readonly property color shellFallbackShadowColor: '#000' 

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

    // power menue
    readonly property color powerIconColor: secondary
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
    readonly property color bluetoothToggleOffColor: secondary//Qt.rgba(mainIconColor.r, mainIconColor.g, mainIconColor.b, 0.35)
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
    readonly property color wifiToggleOffColor: secondary//Qt.rgba(mainIconColor.r, mainIconColor.g, mainIconColor.b, 0.35)
    readonly property color wifiToggleKnobOnColor: background
    readonly property color wifiToggleKnobOffColor: background
    readonly property color wifiSignalColor: primary
    readonly property color wifiSignalLowColor: s2 

    
    // === Notifications ===
    readonly property color notificationPanelColor: "Transparent"
    readonly property color notificationCardColor: "Transparent"//Qt.rgba(secondary.r, secondary.g, secondary.b, 0.05)//Qt.tint(shellBackgroundColor, Qt.rgba(mainTextColor.r, mainTextColor.g, mainTextColor.b, 0.07))   // lifts on dark themes, sinks on light themes
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
    readonly property color barShadowColor: shadowColor
    readonly property real barShadowOpacity: 0.7
    readonly property color barV2ShadowColor: shadowColor
    readonly property real barV2ShadowOpacity: 0.7
    readonly property color topBarShadowColor: shadowColor
    readonly property real topBarShadowOpacity: 0.7
    readonly property color rightBottomBarShadowColor: shadowColor
    readonly property real rightBottomBarShadowOpacity: 0.7
    readonly property color leftBottomBarShadowColor: shadowColor
    readonly property real leftBottomBarShadowOpacity: 0.7
    readonly property color rightTopBarShadowColor: shadowColor
    readonly property real rightTopBarShadowOpacity: 0.7
    readonly property color leftTopBarShadowColor: shadowColor
    readonly property real leftTopBarShadowOpacity: 0.7
    readonly property color popupMenuShadowColor: shadowColor
    readonly property real popupMenuShadowOpacity: 0.7
    readonly property color pop8PopupShadowColor: shadowColor
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
