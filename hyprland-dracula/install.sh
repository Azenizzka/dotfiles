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
    sudo pacman -S alacritty fish
    installFishPM

    fisher install dracula/fish
    fisher install IlanCosman/tide@v6
    tide configure --auto --style=Classic --prompt_colors='16 colors' --show_time=No --classic_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No
}

function installWM() {
    sudo pacman -S hyprland hyprpaper waybar xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal xorg-xwayland mako grim slurp wl-clipboard wofi

    yay -S hyprpicker
}

function installApps() {

    sudo pacman -S openssh firefox jre-openjdk discord telegram-desktop

    yay -S visual-studio-code-bin intellij-idea-ultimate-edition postman-bin
}

function installFishPM() {
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
}

function installConfigs() {
    sudo cp modprobe.d/alsa-base.conf /etc/modprobe.d/Z

    cp -r .fonts/ ~/
    cp -r .config/ ~/

    chsh -s /usr/bin/fish

    fc-cache -fv
}

main