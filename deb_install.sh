#!/bin/sh
# install script for debian


set -e

NAME=$(uname "-n")

# Manipulate repos

sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list
sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list

# Perform base installation

echo "Installing main packages"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install `cat deb_pkgs.txt`

sudo update-command-not-found

# Install correct software

case $NAME in
  "charmy")
    # Intel graphics drivers
    sudo apt-get install xserver-xorg-video-intel;

    # Charmy gets the other default softs/dotfiles
    dotfiles;
    softs;
    ;;
  "shadow")
    # Nvidia graphics drivers
    sudo apt-get install xserver-xorg-video-nvidia;
    
    # Shadow gets the other default softs/dotfiles
    dotfiles;
    softs;
    ;;
  *)
    # Who is this??
    echo "unkown system installing video-all"
    sudo apt-get install xserver-xorg-video-all;
    # skipping default softs
    echo "Skipping non-packaged software. Proceeding to dotfiles"
    # Still want dotfiles for applications
    dotfiles;
    ;;
esac

# Dotfiles!

function dotfiles {
 cp .[^.]* ~/; cp -R dotfiles/.[^.]* ~/;
}
# Install "non-free" softs from outside repos


function softs {

  #Spotify
  sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list;
  sudo apt-get update;
  sudo apt-get install spotify-client;
  
  # Steam
  #TODO: Check if installation is easier as of jessie
  wget http://media.steampowered.com/client/installer/steam.deb;
  
  #TODO: Add i386 arch
  #TODO: sudo apt-get update
  #TODO: Add Skype :/

  # FL Studio
  wget demodownload.image-line.com/flstudio/flstudio_11.exe;
  wine flstudio_11.exe
}

#TODO: Setup cabal/leiningen env/packages
            
# Haskell
function hs {
                       
  cabal update

}

# Clojure

function cj {

}
