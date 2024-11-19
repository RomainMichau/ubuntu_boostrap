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
install_with_apt unzip
install_with_apt libfuse2
install_with_apt wget
sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
$ sudo apt install -y build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 

if ! fc-list | grep 'Font Awesome 6'; then

# Install awesome fonts
    URL="https://use.fontawesome.com/releases/v6.7.0/fontawesome-free-6.7.0-desktop.zip"
    DEST_FILE="fontawesome-free-6.7.0-desktop.zip"

    # Download the ZIP file
    wget -O "$DEST_FILE" "$URL"

    # Unzip the file
    unzip "$DEST_FILE" -d "fontawesome-free-6.7.0-desktop"

    # Optionally, remove the ZIP file after extracting
    rm "$DEST_FILE"
    mkdir -p $HOME/.fonts 
    mv ./fontawesome-free-6.7.0-desktop/fontawesome-free-6.7.0-desktop/otfs/* $HOME/.fonts
    rm -rf fontawesome-free-6.7.0-desktop
fi
# END


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

CURRENT_SHELL=$(getent passwd "$USER" | awk -F: '{print $7}')

# Check if the shell is NOT zsh
if [[ "$CURRENT_SHELL" != "/bin/zsh" ]]; then
    install_with_apt fzf
    install_with_apt zsh
    chsh -s /bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    source $HOME/.cargo/env
fi
# END

if ! command -v ghcup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi


if ! command -v cargo &> /dev/null; then
    curl https://sh.rustup.rs -sSf | sh
fi
install_with_snap slack
install_with_snap zoom-client
install_with_snap spotify
install_with_snap helix

install_with_apt blueman
install_with_apt wget
install_with_apt curl
install_with_apt gpg
install_with_apt neofetch
install_with_apt vim

cargo install alacritty


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

# Install docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# END

cabal install --lib base xmonad xmonad-contrib
cabal install base xmonad xmonad-contrib