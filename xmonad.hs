--System
import System.IO
import XMonad
--Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
--Uitls
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
--Actions
import XMonad.Actions.GridSelect


myStartupHook=do
    spawnOnce "picom &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "nm-applet &"
    spawnOnce "trayer --edge top --align right --width 5 --height 18 --SetDockType true --SetPartialStrut true --expand true --tint 0x00000000 --alpha 0 &"


myManageHook = composeAll
    [
        className =? "conky"      --> doFloat
        , manageDocks
    ]

main=do
  xmproc <- spawnPipe "xmobar ~/.xmobarrc"
  xmonad $ docks $ ewmh def {
    manageHook = myManageHook <+> manageHook defaultConfig,
    layoutHook = avoidStruts  $  layoutHook defaultConfig,
    logHook = dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50
        },
    modMask=mod4Mask,
    terminal="alacritty",
    startupHook=myStartupHook,
    borderWidth=0,
    focusFollowsMouse=False,
    clickJustFocuses=False
}
    `additionalKeys`
    [
        ((mod4Mask, xK_Return), spawn "alacritty"),
        ((mod4Mask, xK_d), spawn "rofi -show drun -lines 5 -eh 2 -width 50 -padding 800 -bw 0 -threads 0 -theme Arc-Dark -show-icons -icon-theme Arc"),
        ((mod1Mask, xK_l), spawn "slock"),
        ((mod1Mask .|. controlMask, xK_s), spawn "systemctl poweroff"),
        ((mod1Mask .|. controlMask, xK_r), spawn "systemctl reboot"),
        ((mod4Mask .|. shiftMask, xK_Up), spawn "~/.xmonad/.scripts/vol.sh inc"),
        ((mod4Mask .|. shiftMask, xK_Down), spawn "~/.xmonad/.scripts/vol.sh dec"),
        ((mod1Mask, xK_m), spawn "~/.xmonad/.scripts/vol.sh mute"),
        ((mod4Mask, xK_b), spawn "~/.xmonad/.scripts/brit.sh inc"),
        ((mod4Mask .|. shiftMask, xK_b), spawn "~/.xmonad/.scripts/brit.sh dec"),
        ((mod4Mask, xK_m), sendMessage ToggleStruts),
        ((mod1Mask, xK_w), goToSelected defaultGSConfig)
    ]
