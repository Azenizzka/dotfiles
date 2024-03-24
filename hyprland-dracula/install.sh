# !/bin/bash

function main() {
    enableMultilib
    installYay
    makeAudio
    installDrivers
    installFonts

    installTerminal
    installWM

    installApps

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
    sudo pacman -S alacritty fish fisher

    fish -c "fisher install dracula/fish"
    fish -c "fisher install IlanCosman/tide@v6"

    fish -c "tide configure --auto --style=Classic --prompt_colors='16 colors' --show_time=No --classic_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No"
}

function installWM() {
    sudo pacman -S hyprland hyprpaper waybar xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal xorg-xwayland mako grim slurp wl-clipboard wofi

    yay -S hyprpicker
}

function installApps() {
    sudo pacman -S openssh firefox jre17-openjdk discord telegram-desktop btop neofetch filezilla unzip zip libreoffice-fresh docker docker-compose man nano

    yay -S visual-studio-code-bin intellij-idea-ultimate-edition postman-bin
}

function installConfigs() {
    sudo cp modprobe.d/alsa-base.conf /etc/modprobe.d/
    
    sudo systemctl enable docker docker.socket
    sudo systemctl start docker docker.socket

    cp -r .fonts/ ~/
    cp -r .config/ ~/
    cp -r .themes/ ~/

    chsh -s /usr/bin/fish

    fc-cache -fv
}

main