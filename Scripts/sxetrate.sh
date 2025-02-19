#!/bin/bash

current_rate=$(xset q | grep "auto repeat delay" | awk '{print $4, $7}')

if [[ "$current_rate" == "650 20" ]]; then
    echo " "
elif [[ "$current_rate" == "350 100" ]]; then
    echo " "
else
    echo " "
fi

exit
