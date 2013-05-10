#!/bin/sh
# install script for debian


set -e

# Manipulate repos

sudo sed 's/jessie/testing/' </etc/apt/sources.list >/etc/apt/sources.list
sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list

# Perform base installation

echo "Installing main packages";
sudo apt-get update;
sudo apt-get upgrade;
sudo apt-get install `cat deb_pkgs.txt`;

sudo update-command-not-found;


# Dotfiles!

# Install "non-free" softs from outside repos

# Steam

wget http://media.steampowered.com/client/installer/steam.deb

# FL Studio
wget demodownload.image-line.com/flstudio/flstudio_11.exe



