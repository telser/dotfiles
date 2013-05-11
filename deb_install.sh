#!/bin/sh
# install script for debian


set -e

NAME=$(uname "-n")

# Manipulate repos

sudo sed 's/jessie/testing/' </etc/apt/sources.list >/etc/apt/sources.list
sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list

# Perform base installation

echo "Installing main packages";
sudo apt-get update;
sudo apt-get upgrade;
sudo apt-get install `cat deb_pkgs.txt`;

sudo update-command-not-found;

# Install correct software

case $NAME in
  "charmy")
    # Intel graphics drivers
    sudo apt-get install xserver-xorg-video-intel;
    # Charmy gets the other default softs/dotfiles
    dotfiles
    softs
    ;;
  "shadow")
    # Nvidia graphics drivers
    sudo apt-get install xserver-xorg-video-nvidia;
    # Shadow gets the other default softs/dotfiles
    dotfiles
    softs
    ;;
  *)
    # Who is this??
    echo "unkown system installing video-all"
    sudo apt-get install xserver-xorg-video-all;
    # skipping default softs
    echo "Skipping non-packaged software. Proceeding to dotfiles"
    # Still want dotfiles for applications
    dotfiles
    ;;
esac

# Dotfiles!

function dotfiles {
 cp .[^.]* ~/; cp -R dotfiles/.[^.]* ~/;
}
# Install "non-free" softs from outside repos

function softs {
  # Steam
  wget http://media.steampowered.com/client/installer/steam.deb;

  # FL Studio
  wget demodownload.image-line.com/flstudio/flstudio_11.exe;
}
