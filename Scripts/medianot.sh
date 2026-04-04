#!/bin/sh

players=$(playerctl -l 2>/dev/null | grep -v -E 'brave|chromium' | tr '\n' ',' | sed 's/,$//')

if playerctl --player "$players" status 2>/dev/null | grep -q "Playing"; then
  echo "^c#cc241d^^c#c8c093^ $(playerctl --player "$players" metadata --format '{{title}} - {{artist}}' 2>/dev/null | head -n1 | cut -c1-30) "
else
  echo "^c#727169^ ^c#dcd7ba^"
fi
