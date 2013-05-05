#!/bin/sh
# install script for debian


set -e

# Manipulate repos

# Perform base installation

echo "Installing main packages";
sudo apt-get update;
sudo apt-get install `cat deb_pkgs.txt`;


# Install "non-free" softs

# Dotfiles!
