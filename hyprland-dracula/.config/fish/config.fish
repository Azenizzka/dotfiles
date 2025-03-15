alias ls "eza"
alias ll "eza -la --group-directories-first -rs=size --total-size --no-user --icons=always --colour=always --colour-scale-mode=fixed"

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

export EZA_COLORS="\
uu=36:\
uR=31:\
un=35:\
gu=37:\
da=0;34:\
ur=34:\
uw=95:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:\
xx=90:"

if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
        dbus-run-session Hyprland
    end
end
