#!/bin/bash

BRAVE_CMD="brave"
DMENU_PROMPT="Search (yt/wiki/pk/aur):"

urlencode() {
    local LC_ALL=C
    local string="$*"
    local i chr len
    len=${#string}
    for ((i = 0; i < len; i++)); do
        chr="${string:i:1}"
        case $chr in
            [a-zA-Z0-9.~_-]) printf '%s' "$chr" ;;
            *) printf '%%%02X' "'$chr" ;;
        esac
    done
}

active_class=$(
    xprop -id $(xdotool getactivewindow) WM_CLASS 2>/dev/null | 
    awk -F '"' '{print $4}'
)

query=$(dmenu -p "$DMENU_PROMPT" < /dev/null) || exit 1
[ -z "$query" ] && exit 0

case "$query" in
    yt\ *) 
        url="https://www.youtube.com/results?search_query=$(urlencode "${query#yt }")" ;;
    wiki\ *)
        url="https://en.wikipedia.org/wiki/Special:Search?search=$(urlencode "${query#wiki }")" ;;
    pk\ *)
        url="https://archlinux.org/packages/?q=$(urlencode "${query#pk }")" ;;
    aur\ *)
        url="https://aur.archlinux.org/packages?K=$(urlencode "${query#aur }")" ;;
    *)
        url="https://www.google.com/search?q=$(urlencode "$query")" ;;
esac

if [[ "$active_class" == *[Bb]rave* ]]; then
    "$BRAVE_CMD" "$url"
else
    "$BRAVE_CMD" --new-window "$url"
fi
