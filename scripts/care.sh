# !/bis/sh

sudo journalctl --vacuum-size=100M

sudo pacman -Suy
yay -Suy

sudo pacman -Scc

sudo paccache -r
sudo paccache -rk1
sudo paccache -ruk0

sudo pacman -Rsn $(pacman -Qdtq)

sudo truncate -s 0 /var/log/pacman.log

rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash
sudo rm -rf /tmp/*