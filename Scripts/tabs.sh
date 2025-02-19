#!/bin/bash

 # Find or launch tabbed
 TABBED_ID=$(xdotool search --class tabbed | head -n 1)
 if [ -z "$TABBED_ID" ]; then
 tabbed -c &  # Launch a new tabbed instance
 sleep 0.5  # Small delay to allow tabbed to start
 TABBED_ID=$(xdotool search --class tabbed | head -n 1)
fi

             # Get the active window (the current window you want to put into tabbed)
CURRENT_WINDOW=$(xdotool getactivewindow)

             # Reparent the current window into tabbed
xdotool windowreparent "$CURRENT_WINDOW" "$TABBED_ID"

