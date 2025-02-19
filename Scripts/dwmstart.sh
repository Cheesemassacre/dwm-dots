#!/bin/sh
# xrandr -o left
# feh --bg-scale /home/marin/Pictures/wall12.jpg &
exec /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
slstatus &
unclutter -idle 2 &
dunst &
picom -b  &
sxhkd &
# xrandr --output HDMI-1 --auto --primary --left-of eDP-1 --output eDP-1 --auto --off &
feh --bg-fill Pictures/wallbsp.jpg &
# feh --bg-fill Pictures/wallhaven-2em8y6.jpg &
# exec .dotfiles/keynav/keynav/keynav &
# ./.kmrl.sh &
playerctld daemon &

#  while true; do
#  	xsetroot -name "$(date '+ %a %d/%m %H:%M ')"
#  	sleep 2
#  done
