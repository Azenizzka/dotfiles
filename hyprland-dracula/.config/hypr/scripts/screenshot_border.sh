#!/bin/sh

lock_file="/tmp/hypr_screenshot.lock"

if [ -f "$lock_file" ]; then
    exit 1
fi

touch "$lock_file"
grim -g "$(slurp -b "#282a36aa" -c "#bd93f9ff" -w 2)" - | wl-copy
rm "$lock_file"
