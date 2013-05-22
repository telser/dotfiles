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

echo "Installing system specific software"

case $NAME in
  "charmy")
    # Intel graphics drivers
    sudo apt-get install xserver-xorg-video-intel;

    # Charmy gets the other default softs/dotfiles
    dotfiles;
    softs;
    dldir;
    ;;
  "shadow")
    # Nvidia graphics drivers
    sudo apt-get install xserver-xorg-video-nvidia;
    
    # Shadow gets the other default softs/dotfiles
    dotfiles;
    softs;
    dldir;
    ;;
  "espio")
    #TODO: espio will need a different pkg list
    #Use rasbian instead of debian?
    dotfiles;
    ;;
  "vector")
    #TODO: vector will need a different pkg list
    #Use stable instead?
    dotfiles;
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
  # Get the dotfiles
  git clone http://github.com/trev311/dotfiles.git;
  cd dotfiles;
  # actually install the dotfiles
  cp .[^.]* ~/; cp -R dotfiles/.[^.]* ~/;

  cd ~/;
  rm -r dotfiles/;
  
  # Get oh-my-zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  # Make zsh default shell
  chsh -s /bin/zsh;

}

# Install "non-free" softs from outside of main repos
function softs {

  #Spotify
  sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list;
  sudo apt-get update;
  sudo apt-get install spotify-client;
  
  # Steam
  #TODO: Check if installation is easier 
  # Need eglibc >=15
  wget http://media.steampowered.com/client/installer/steam.deb;
  
  #Skype :/
  #Add i386 arch
  sudo dpkg --add-architecture i386
  sudo apt-get update
  wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
  sudo dpkg -i skype-install.deb
  sudo apt-get -f install

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


# Setup directories for desktop/laptop
function dldir {

  mkdir projects;
  mkdir school;

}
