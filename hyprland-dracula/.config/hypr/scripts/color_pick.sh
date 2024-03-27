#!/bin/sh

lock_file="/tmp/color_pick.lock"

if [ -f "$lock_file" ]; then
    exit 1
fi

touch "$lock_file"
hyprpicker -a
rm "$lock_file"