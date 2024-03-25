# !/bis/sh

sudo journalctl --vacuum-size=100M

sudo pacman -Suy
yay -Suy

sudo pacman -Scc

sudo pacman -Rsn $(pacman -Qdtq)

rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash