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

function enableAutoRun() {
    
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    sudo touch /etc/systemd/system/getty@tty1.service.d/autologin.conf
    
    echo "[Service]" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
    echo "ExecStart=" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
    echo "ExecStart=-/usr/bin/agetty --autologin <username> --noclear %I 38400 linux" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
    
    sudo sed -i "s/<username>/$USER/g" /etc/systemd/system/getty@tty1.service.d/autologin.conf
    
    cp -r autorun/.config/* ~/.config
    
    sudo systemctl daemon-reload
    
    sudo systemctl enable getty@tty1
    
    echo "Install complete. Reboot in 5 seconds.."
    sleep 5
    reboot
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
    sudo pacman -S qt5-wayland qt6-wayland hyprland hyprpaper waybar xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal mako grim slurp wl-clipboard wofi brightnessctl hypridle hyprlock
    
    yay -S hyprpicker hyprcursor
}

function installApps() {
    sudo pacman -S openssh firefox eza telegram-desktop btop neofetch filezilla unzip zip docker docker-compose man nvim valgrind tree obs-studio tldr
    
    yay -S visual-studio-code-bin postman-bin discord
}

function installConfigs() {
    sudo cp modprobe.d/alsa-base.conf /etc/modprobe.d/
    
    sudo cp -r ../grub-dracula/ /boot/grub/themes/dracula
    sudo cp grub /etc/default/
    sudo grub-mkconfig -o /boot/grub/grub.cfg

    sudo groupadd docker
    sudo usermod -aG docker $USER
    
    sudo systemctl enable docker docker.socket
    sudo systemctl start docker docker.socket
    
    cp -r .fonts/ ~/
    cp -r .config/ ~/
    cp -r .themes/ ~/

    gsettings set org.gnome.desktop.interface gtk-theme gtk-dracula
    gsettings set org.gnome.desktop.interface icon-theme dracula-icons 
    
    chsh -s /usr/bin/fish
    
    fc-cache -fv
    
    sudo cp ../scripts/care.sh /usr/bin/care

    bash ../scripts/care.sh
}

main
