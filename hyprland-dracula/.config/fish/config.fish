export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
if status is-login
if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
dbus-run-session Hyprland
end
end