#!/bin/sh

setxkbmap -layout de

picom &

slstatus &

xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Tapping Enabled" 1
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Natural Scrolling Enabled" 1
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Accel Speed" 0.3
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Disable While Typing Enabled" 0

feh --bg-scale --randomize ~/Dotfiles/Wallpaper/.config/wallpaper/Images/*

exec dwm
