#!/usr/bin/env bash

mkdir /home/joaovfsousa/Projects
mkdir /home/joaovfsousa/.fonts

BASE_INSTALL_DIR="/home/joaovfsousa/install"
mkdir -p $BASE_INSTALL_DIR

GOOGLE_CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

DONWLOAD_DIR="$HOME/Downloads/"

PACKAGES_TO_INSTALL=(
  snapd
  git
  curl
  gnome-tweaks
  zsh
  neovim
  docker
  docker-compose
  flatpak
  gnome-software-plugin-flatpak
  gcc-multilib
  lib32z1
  lib32stdc++6
  flameshot
  bat
  alacritty
  cmatrix
  indicator-stickynotes
  menulibre
  pgadmin4
  vlc
  code
  sensors
  silversearcher-ag
  unzip
)

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

sudo apt update -y

wget -c "$GOOGLE_CHROME_URL"       -P "$DOWNLOAD_DIR"

sudo dpkg -i $DOWNLOAD_DIR/*.deb

# Instalar programas no apt
for package in ${PACKAGES_TO_INSTALL[@]}; do
  if ! dpkg -l | grep -q $package; then 
    apt install "$package" -y
  else
    echo "[Installed] - $package"
  fi
done

flatpak update
sudo flatpak install flathub io.dbeaver.DBeaverCommunity
sudo flatpak install flathub com.github.muriloventuroso.easyssh
sudo flatpak install flathub com.github.tchx84.Flatseal
sudo flatpak install flathub rest.insomnia.Insomnia
sudo flatpak install flathub com.spotify.Client
sudo flatpak install flathub com.getpostman.Postman
sudo flatpak install flathub com.slack.Slack

# ---------------------------------------------------------------------- #

chsh -s $(which zsh)

# ----------------------------- Post install ----------------------------- #
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

# Jetbrains Mono font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# Setup dotfiles
git clone https://github.com/joaovfsousa/dotfiles.git $BASE_INSTALL_DIR
chmod +x $BASE_INSTALL_DIR/install
$BASE_INSTALL_DIR/install

#
EXTENSIONS_TO_INSTALL = (
  Bluetooth Quick Connect
  Clipboard Indicator
  Dash to Panel
  Easy Docker Containers 
  Extension List
  gSnap
  gTile
  Remove Alt+Tab Delay v2
  Sound Input & Output Device Chooser
  Status Area Horizontal Spacing
  Tiling Assistant
  Vitals
)

for extension in ${EXTENSIONS_TO_INSTALL[@]}; do
  echo "Install $extension"
done

echo "Install Jetbrains Mono NF"
