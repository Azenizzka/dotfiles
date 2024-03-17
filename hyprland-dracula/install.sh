# !/bin/bash

function main() {
    enableMultilib
    installYay
    makeAudio
    installDrivers
    installFonts

    installTerminal
    installWM

    installConfigs
}

function enableMultilib() {
    sudo cp etc/pacman.conf /etc
    sudo pacman -Suy
}

function installYay() {
    mkdir build
    cd build
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ../..
    rm -rf build
}

function makeAudio() {
    sudo pacman -S sof-firmware alsa-utils pulseaudio
}

function installDrivers() {
    sudo pacman -S mesa vulkan-intel
}

function installFonts() {
    sudo pacman -S noto-fonts-emoji noto-fonts-extra
}

function installTerminal() {
    sudo pacman -S alacritty fish
}

function installWM() {
    sudo pacman -S hyprland hyprpaper waybar xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal xorg-xwayland mako grim slurp wl-clipboard mako

    yay -S hyprpicker
}

function installConfigs() {
    sudo cp modprobe.d/alsa-base.conf /etc/modprobe.d/Z

    cp -r .fonts/ ~/
    cp -r .config/ ~/

    chsh -s /usr/bin/fish

    fc-cache -fv
}

main