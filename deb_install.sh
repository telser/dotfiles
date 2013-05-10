#!/bin/sh
# install script for debian


set -e

NAME=$(uname "-n")

# Manipulate repos

# Perform base installation

echo "Installing main packages";
sudo apt-get update;
sudo apt-get install `cat deb_pkgs.txt`;

# Install correct software

case $NAME in
  "charmy")
    # Intel graphics drivers
    sudo apt-get install xserver-xorg-video-intel;
    # Charmy gets the other default softs/dotfiles
    ;;
  "shadow")
    # Nvidia graphics drivers
    sudo apt-get install xserver-xorg-video-nvidia;
    # Shadow gets the other default softs/dotfiles
    ;;
  *)
    # Who is this??
    echo "unkown system installing video-all"
    sudo apt-get install xserver-xorg-video-all;
    # skipping default softs
    echo "Skipping non-packaged software. Proceeding to dotfiles"
    # Still want dotfiles for applications
    ;;
esac

# Install "non-free" softs

# Dotfiles!

function dotfiles {
 cp .[^.]* ~/; cp -R dotfiles/.[^.]* ~/;
}
