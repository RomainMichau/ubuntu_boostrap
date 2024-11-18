#!/bin/bash
install_with_snap() {
    local package="$1"
    local flags="$2"

    # Check if the package is already installed
    if snap list | grep -q "^$package "; then
        echo "$package is already installed."
    else
        echo "Installing $package via Snap..."
        sudo snap install "$package" "$flags"
    fi
}




install_with_apt() {
    local package="$1"
    sudo apt install -y "$package"
}

sudo apt update -y
install_with_apt git

# Clone .conf files
if [ ! -d "$HOME/.rcfg" ]; then
    alias rgit='/usr/bin/git --git-dir=$HOME/.rcfg/ --work-tree=$HOME'
    rgit config --local status.showUntrackedFiles 
    git clone --bare git@github.com:RomainMichau/linux_config.git $HOME/.rcfg
    rm -f ~/.bashrc
    rm -f ~/.zshrc
    rgit checkout
fi
# END



# ZSH
install_with_apt fzf
install_with_apt zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# END

install_with_snap slack
install_with_snap zoom-client
install_with_snap spotify

install_with_apt blueman
install_with_apt wget
install_with_apt curl
install_with_apt gpg
install_with_apt vim

sudo add-apt-repository -y ppa:maveonair/helix-editor
install_with_apt helix

# TOIL FOR VS CODE
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
install_with_apt apt-transport-https
install_with_apt code 
# END

# VPN
install_with_apt network-manager-openconnect
install_with_apt openconnect
install_with_apt network-manager-openconnect-gnome
# END

# WM
install_with_apt i3-wm
install_with_apt rofi
install_with_apt polybar
install_with_apt xscreensaver
# END
