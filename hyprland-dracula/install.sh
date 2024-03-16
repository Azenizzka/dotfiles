# !/bin/bash

function main() {
    enableMultilib

    installYay

    makeAudio

    installDrivers

    installWM

    installTerminal

    installFonts

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
    sudo pacman -S pipewire pipewire-pulse wireplumber
}

function installFonts() {
    sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts-emoji
}

function installDrivers() {
    sudo pacman -S mesa vulkan-intel
}

function installTerminal() {
    sudo pacman -S alacritty fish
}

function installWM() {
    sudo pacman -S hyprland hyprpaper waybar xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal grim slurp xorg-xwayland

    yay -S hyprpicker
}

function installConfigs() {
    chsh -s /usr/bin/fish

    cp -r .fonts/ ~/
    cp -r .config/ ~/

    fc-cache -fv
}



main