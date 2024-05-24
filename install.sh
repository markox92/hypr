#!/bin/bash
function message() {
    clear
    echo ""
    printf "\e[36m _                      _                 _ \e[0m\n"
    printf "\e[36m| |                    | |               | |\e[0m\n"
    printf "\e[36m| |__  _   _ _ __  _ __| | __ _ _ __   __| |\e[0m\n"
    printf "\e[36m| '_ \| | | | '_ \| '__| |/ _\` | '_ \ / _\` |\e[0m\n"
    printf "\e[36m| | | | |_| | |_) | |  | | (_| | | | | (_| |\e[0m\n"
    printf "\e[36m|_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|\e[0m\n"
    printf "\e[36m        __/ | |                             \e[0m\n"
    printf "\e[36m       |___/|_|                             \e[0m\n"
    echo ""
    echo ""
    printf "\e[36mInstalling Please Wait.....\e[0m\n"
    echo ""
}
function copy() {
    echo ""
    printf "\e[36mLast Step..................\e[0m\n"
    echo ""
    printf "Make DIR .config..........."
    mkdir -p "$HOME/.config"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Kitty............"
    mkdir -p "$HOME/.config/kitty"
    yes | cp -rf $1/dotfiles/kitty/* "$HOME/.config/kitty/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Hyprland........."
    mkdir -p "$HOME/.config/hypr"
    yes | cp -rf $1/dotfiles/hypr/* "$HOME/.config/hypr/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Wallpaper........"
    mkdir -p "$HOME/Images"
    yes | cp -rf $1/dotfiles/wallpaper.jpg "$HOME/Images/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Waybar..........."
    mkdir -p "$HOME/.config/waybar"
    yes | cp -rf $1/dotfiles/waybar/* "$HOME/.config/waybar/"
    chmod +x "$HOME/.config/waybar/scripts/mediaplayer.py" "$HOME/.config/waybar/scripts/wlrecord.sh"
    chmod +x "$HOME/.config/waybar/scripts/playerctl/playerctl.sh"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Dunst............"
    mkdir -p "$HOME/.config/dunst"
    yes | cp -rf $1/dotfiles/dunst/* "$HOME/.config/dunst/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Rofi............."
    mkdir -p "$HOME/.config/rofi"
    yes | cp -rf $1/dotfiles/rofi/* "$HOME/.config/rofi/"
    chmod +x "$HOME/.config/rofi/powermenu/powermenu.sh"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure ZSH.............."
    sudo usermod --shell /usr/bin/zsh $USER
    sudo usermod --shell /usr/bin/zsh root
    yes | cp -rf "$1/dotfiles/.zshrc" "$HOME/"
    sudo ln -s -f "$HOME/.zshrc" "/root/.zshrc"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Code Flags......."
    yes | cp -rf "$1/dotfiles/code-flags.conf" "$HOME/.config/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Powerlevel10k...."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
    #yes | cp -rf $1/dotfiles/powerlevel10k/user/.p10k.zsh "$HOME/"
    #sudo yes | sudo cp -rf $1/dotfiles/powerlevel10k/root/.p10k.zsh "/root/"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Sudo Plugin......"
    cd /usr/share
    sudo mkdir -p zsh-sudo
    sudo chown $USER:$USER zsh-sudo/
    cd zsh-sudo
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Scripts.........."
    mkdir -p "$HOME/.config/scripts"
    yes | cp -rf $1/dotfiles/scripts/* "$HOME/.config/scripts"
    chmod +x -R $HOME/.config/scripts/
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Swappy..........."
    mkdir -p "$HOME/.config/swappy"
    yes | cp -rf $1/dotfiles/swappy/* "$HOME/.config/swappy"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Thunar.........."
    mkdir -p "$HOME/.config/xfce4"
    yes | cp -rf $1/dotfiles/xfce4/* "$HOME/.config/xfce4"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1

    printf "Configure Swaylock........."
    mkdir -p "$HOME/.config/swaylock"
    yes | cp -rf $1/dotfiles/swaylock/* "$HOME/.config/swaylock"
    echo -e "\e[36m [ OK ]\e[0m"
    sleep 1
    
    printf "Configure SDDM............."
    sudo systemctl enable sddm > /dev/null 2>&1
    sudo yes | sudo cp -rf "$1/dotfiles/sddm/wallpaper.jpg" "/usr/share/sddm/themes/Sugar-Candy/Backgrounds/"
    sudo yes | sudo cp -rf "$1/dotfiles/sddm/theme.conf" "/usr/share/sddm/themes/Sugar-Candy/"
    sudo yes | sudo cp -rf "$1/dotfiles/sddm/sddm.conf" "/etc/"
    echo -e "\e[36m [ OK ]\e[0m"

    printf "Settings Icons and Font...."
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
    gsettings set org.gnome.desktop.interface icon-theme Papirus
    gsettings set org.gnome.desktop.interface font-name "Segoe UI Regular 11"
    echo -e "\e[36m [ OK ]\e[0m"
}

# INSTALLATION REQUIREMENTS
function requirements() {
    # Update
    printf "Updating System............"
    sudo pacman -Syu --noconfirm
    echo -e "\e[36m [ OK ]\e[0m"
    # yay
    printf "Instaling AUR Helper Yay..."
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg --noconfirm -si
    echo -e "\e[36m [ OK ]\e[0m"
}

# INSTALLATION OF ALL PACKAGES
function packages() {
    printf "Installing Packages........"
    yay -S --noconfirm kitty wl-clip-persist swaylock-effects sddm-theme-sugar-candy-git adw-gtk3-git jq papirus-icon-theme lxappearance xfce4-settings kate thunar thunar-archive-plugin gfvs visual-studio-code-bin
    sudo pacman -S --noconfirm rofi sddm zsh lsd bat zsh-syntax-highlighting zsh-autosuggestions swayidle xautolock hyprpaper waybar polkit polkit-gnome pavucontrol slurp grim swappy wget unzip 
    echo -e "\e[36m [ OK ]\e[0m"
}
function fonts() {
    printf "Installing Fonts..........."
    mkdir -p "$HOME/.local/share/fonts"
    yes | cp -rf $1/dotfiles/fonts/* "$HOME/.local/share/fonts/"
    cd "$HOME/.local/share/fonts"
    fc-cache -f
    echo -e "\e[36m [ OK ]\e[0m"
}
function drivers() {
    printf "${YELLOW}Installing NVIDIA drivers.."
    yay -S linux-headers nvidia-beta --noconfirm --overwrite
    echo -e "\e[36m [ OK ]\e[0m"
}
function config_kernel() {
    printf "${YELLOW}Installing kernel NVIDIA..."
    sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf 
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    if [ -f /etc/default/grub ]; then
        sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia_drm.modeset=1"/' /etc/default/grub
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    fi
    echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/nouveau.conf
    if [ -f "/etc/modprobe.d/blacklist.conf" ]; then
        echo "install nouveau /bin/true" | sudo tee -a "/etc/modprobe.d/blacklist.conf"
    else
        echo "install nouveau /bin/true" | sudo tee "/etc/modprobe.d/blacklist.conf"
    fi
    echo -e "\e[36m [ OK ]\e[0m"
}
function hyprland() {
    printf "${YELLOW}Installing Hyprland........"
    yay -S --noconfirm hyprland-git
    echo -e "\e[36m [ OK ]\e[0m"
}
# COMPLETION

function complete() {
    echo ""
    echo "INSTALLATION COMPLETED. Please reboot your PC"
    echo ""
}

# CHECKS IF THE INSTALLER IS RUNNING AS ROOT

if [ $(whoami) != 'root' ]; then
    ruta=$(pwd)
    sudo touch /tmp/hyprv.tmp
    message
    requirements
    drivers
    config_kernel
    hyprland
    packages
    fonts "$ruta"
    copy "$ruta"
    complete
else
    echo 'Error, the script should not be run as root.'
    exit 0
fi