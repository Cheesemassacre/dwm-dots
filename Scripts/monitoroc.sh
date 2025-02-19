#!/bin/sh

xrandr --newmode "1920x1080_72.00"  210.25  1920 2056 2256 2592  1080 1083 1088 1128 -hsync +vsync

xrandr --addmode HDMI-1 1920x1080_72.00

xrandr --output HDMI-1 --mode "1920x1080_72.00"
