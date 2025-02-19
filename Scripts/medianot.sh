#!/bin/sh
if playerctl -a status 2>/dev/null | grep -q "Playing"; then
  echo "  $(playerctl -a metadata --format '{{artist}} - {{title}}' | head -n1 | cut -c1-40)"
else
  echo " "
fi
