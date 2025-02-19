#!/bin/bash
BL=$(brightnessctl g)
brightnessctl s 40%
imv-x11 -f ~/Pictures/backlight.jpg 
brightnessctl s "$BL"

