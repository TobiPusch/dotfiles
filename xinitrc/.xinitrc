#!/bin/sh

setxkbmap -layout de

picom &

slstatus &




CURRENT_HOST=$(hostnamectl --static)


if [ "$CURRENT_HOST" = "archlinuxtobis-Arch" ]; then
xrandr --output HDMI-0 --mode  2560x1440 --rate 144 --pos 0x0 --primary\
 --output DP-2 --mode 1920x1080 --rate 144  --pos 2560x180 
feh --bg-scale --randomize ~/dotfiles/Wallpaper/.config/wallpaper/Images/*

else

xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Tapping Enabled" 1
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Natural Scrolling Enabled" 1
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Accel Speed" 0.3
xinput set-prop "ASUE140A:00 04F3:3134 Touchpad"  "libinput Disable While Typing Enabled" 0
feh --bg-scale --randomize ~/Dotfiles/Wallpaper/.config/wallpaper/Images/*


fi

exec dwm
