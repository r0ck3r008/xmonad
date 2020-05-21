--System
import XMonad
import System.IO
--Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
--Uitls
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Dzen


myStartupHook=do
	spawnOnce "picom &"
	spawnOnce "nitrogen --restore &"
	spawnOnce "nm-applet &"


myManageHook = composeAll
	[
		className =? "conky"      --> doFloat
		, manageDocks
	]

main=do
    xmonad $ ewmh def {
		manageHook = myManageHook <+> manageHook defaultConfig
		, layoutHook = avoidStruts  $  layoutHook defaultConfig
		, modMask=mod4Mask
		, terminal="alacritty"
		, startupHook=myStartupHook
		, borderWidth=0
	}
        `additionalKeys`
        [
		((mod4Mask, xK_Return), spawn "alacritty"),
		((mod4Mask, xK_d), spawn "rofi -show drun -lines 5 -eh 2 -width 50 -padding 800 -bw 0 -threads 0 -theme Arc-Dark -show-icons -icon-theme Arc"),
		((mod4Mask, xK_w), spawn "rofi -show window -lines 5 -eh 2 -width 50 -padding 800 -bw 0 -threads 0 -theme Arc-Dark -show-icons -icon-theme Arc"),
		((mod1Mask, xK_l), spawn "i3lock -c 000000 -i ~/.xmonad/lock.png"),
		((mod1Mask .|. controlMask, xK_s), spawn "systemctl poweroff"),
		((mod1Mask, xK_d), spawn "trayer --edge bottom --align right --width 5 --height 12 --SetDockType true --SetPartialStrut true --expand true --transparent true --tint 0x000000 &"),
		((mod1Mask .|. shiftMask, xK_d), spawn "killall trayer"),
		((mod1Mask, xK_i), spawn "conky -d -c /home/naman/.conky/Gotham/Gotham"),
		((mod1Mask .|. shiftMask, xK_i), spawn "killall conky"),
		((mod1Mask .|. shiftMask, xK_Up), spawn "~/.xmonad/.scripts/vol.sh inc"),
		((mod1Mask .|. shiftMask, xK_Down), spawn "~/.xmonad/.scripts/vol.sh dec"),
		((mod1Mask, xK_m), spawn "~/.xmonad/.scripts/vol.sh mute"),
		((mod1Mask, xK_b), spawn "~/.xmonad/.scripts/brit.sh inc"),
		((mod1Mask .|. shiftMask, xK_b), spawn "~/.xmonad/.scripts/brit.sh dec")
        ]
