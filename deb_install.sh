#!/bin/sh
# install script for debian

# Dotfiles!
dotfiles()
{
  # Get the dotfiles
  git clone http://github.com/trev311/dotfiles.git;
  # actually install the dotfiles
  cp -r dotfiles/.* ~/;
  rm -rf dotfiles/;
  
  # Get oh-my-zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh;

  # Make zsh default shell
  chsh -s /bin/zsh;

}

# Install "non-free" softs from outside of main repos
softs() {

  # Steam
  #TODO: Check if installation is easier 
  # This might be installable as of Jessie, without Ubuntu trickery
  wget http://media.steampowered.com/client/installer/steam.deb;
  
  #Skype :/
  sudo apt-get update;
  wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb;
  sudo apt-get -f install;
  sudo dpkg -i skype-install.deb;

  # FL Studio
  wget demodownload.image-line.com/flstudio/flstudio_11.exe;
  wine flstudio_11.exe;
  
  #Spotify
  # *sigh*
  sudo chmod 777 /etc/apt/sources.list
  sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list;
  chmod 644 /etc/apt/sources.list
  sudo apt-get update;
  sudo apt-get install spotify-client;

}

#TODO: Setup cabal/leiningen env/packages
            
# Haskell
hs() {
                       
  cabal update;

}

# Clojure

cj() {
 lein version;
}


# Setup directories for desktop/laptop
dldir() {

  mkdir projects;
  mkdir school;

}

base(){


# Perform base installation

echo "Installing main packages"
sudo apt-get install --install-suggests `cat deb_pkgs.txt`

sudo update-command-not-found
}


set -e

NAME=$(uname "-n")

# Manipulate repos

sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list

# Install correct software

echo "Installing system specific software"

case $NAME in
  "charmy")
    #Add i386 arch
    sudo dpkg --add-architecture i386;
    sudo apt-get update;
    # Intel graphics drivers
    sudo apt-get install --install-suggests xserver-xorg-video-intel;

    # Generic OpenCl stuff
    sudo apt-get install --install-suggests ocl-icd-opencl-dev;

    # Charmy gets the other default softs/dotfiles
    base;
    dotfiles;
    softs;
    dldir;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "shadow")
    #Add i386 arch
    sudo dpkg --add-architecture i386;
    sudo apt-get update;
    # Shadow needs non-free firmware :/
    sudo apt-get install --install-suggests firmware-realtek
    # Nvidia Metapackage + ensure use of DKMS
    sudo apt-get install --install-suggests nvidia-kernel-dkms nvidia-glx nvidia-xconfig;
    
    # Nvidia cuda/opencl packages
    sudo apt-get install --install-suggests nvidia-cuda-toolkit nvidia-cuda-gdb nvidia-cuda-doc libcupti-dev python-pycuda nvidia-opencl-dev;

    #TODO: edit xorg.conf
    sudo nvidia-xconfig;

    # Shadow gets the other default softs/dotfiles
    base;
    dotfiles;
    softs;
    dldir;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "espio")
    #TODO: espio will need a different pkg list
    #Use rasbian instead of debian?
    base;
    dotfiles;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "vector")
    #TODO: vector will need a different pkg list
    #Use stable instead?
    base;
    dotfiles;
    ;;
  *)
    # Who is this??
    echo "unkown system installing video-all"
    sudo apt-get install --install-suggests xserver-xorg-video-all;
    # skipping default softs
    echo "Skipping non-packaged software. Proceeding to dotfiles"
    # Still want dotfiles for applications
    base;
    dotfiles;
    ;;
esac

