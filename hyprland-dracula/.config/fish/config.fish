alias ls "eza"
alias ll "eza -la --group-directories-first -rs=size --total-size --no-user --icons=always --colour=always --colour-scale-mode=fixed"

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
        dbus-run-session Hyprland
    end
end
