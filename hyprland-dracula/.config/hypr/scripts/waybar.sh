#!/bin/sh

is_launch="/tmp/is_waybar_launched.state"

if [ -f "$is_launch" ]; then
    rm "$is_launch"
    killall waybar
else
    touch "$is_launch"
    waybar -c ~/.config/hypr/waybar/config -s ~/.config/hypr/waybar/style.css
fi
