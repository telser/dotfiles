#!/bin/sh
# install script for debian

# Dotfiles!
dotfiles()
{
  # Get the dotfiles
  git clone https://github.com/telser/dotfiles.git;
  # actually install the dotfiles
  #TODO Clean this up
  sudo cp -r dotfiles/.* ~/;
  rm -rf dotfiles/;
  
  # Get oh-my-zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh;

  # Make zsh default shell
  chsh -s /bin/zsh;
}

# Desktop/laptop software that isn't needed elsewhere
softs() {

  # Pull emacs from unstable
  # How unstable could an operating system, err text editor really be? :)
  sudo apt-get install -t unstable emacs
  
  #Get Mozilla Release, not ESR
  sudo apt-get install -t experimental iceweasel

  #Make sure the pulse module for switching soundcards is loaded
  sudo chmod 777 /etc/pulse/default.pa;
  sudo echo "load-module module-connect-on-switch" >> /etc/pulse/default.pa;
  sudo chmod 644 /etc/pulse/default.pa;

# Install "non-free" softs from outside of main repos

  # Steam
  sudo apt-get install steam;
  
  #Skype :/
  sudo apt-get update;
  wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb;
  sudo apt-get -f install;
  sudo dpkg -i skype-install.deb;

  # FL Studio
  # Installation actually requires xorg to be running
  wget demodownload.image-line.com/flstudio/flstudio_11.exe;
  
  #Spotify
  #TODO Spotify is hard linked against an old libssl, uninstallable unless using old stable ie NOT AN OPTION.
  # *sigh* modify permissions to echo
  sudo chmod 777 /etc/apt/sources.list
  sudo echo "deb http://repository.spotify.com/ stable non-free" >> /etc/apt/sources.list;
  # change perms back
  sudo chmod 644 /etc/apt/sources.list
 # sudo apt-get update;
 # sudo apt-get install spotify-client;

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
  cd projects;
  git clone git@bitbucket.org:telser/retrograde-music-player.git;
  git clone git@bitbucket.org:telser/hlibvlc.git;
  cd ~;
  mkdir school;

}

extra(){

#Don't worry we use pinning to not pull from unstable/experimental unless needed
sudo chmod 777 /etc/apt/sources.list
sudo echo "deb http://ftp.us.debian.org/debian/ unstable main" >> /etc/apt/sources.list
sudo echo "deb http://ftp.us.debian.org/debian/ experimental main" >> /etc/apt/sources.list
sudo echo "deb http://cdn.debian.net/debian/ experimental main" >> /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list

sudo cp apt_preferences /etc/apt/preferences

}

set -e

NAME=$(uname "-n")

# Install correct software by machine

case $NAME in
  "charmy")
    # Manipulate repos
    extra;
    sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list;

    #Add i386 arch
    sudo dpkg --add-architecture i386;
    sudo apt-get update;
    # Intel graphics drivers
    sudo apt-get install xserver-xorg-video-intel;

    # Generic OpenCl stuff
    sudo apt-get install ocl-icd-opencl-dev;

    # Charmy gets the other default softs/dotfiles
    sudo apt-get install `cat deb_pkgs.txt`;
    dotfiles;
    softs;
    dldir;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "shadow")
    # Manipulate repos
    extra;
    sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list;

    #Add i386 arch
    sudo dpkg --add-architecture i386;
    sudo apt-get update;
    # Shadow needs non-free firmware :/
    sudo apt-get install firmware-realtek
    # Nvidia Metapackage + ensure use of DKMS
    sudo apt-get install nvidia-kernel-dkms nvidia-glx;
    
    # Nvidia cuda/opencl packages
    sudo apt-get install nvidia-cuda-toolkit nvidia-cuda-gdb nvidia-cuda-doc libcupti-dev python-pycuda nvidia-opencl-dev;

    #TODO: edit xorg.conf

    # Shadow gets the other default softs/dotfiles
    sudo apt-get install `cat deb_pkgs.txt`;
    dotfiles;
    dldir;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    softs;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "espio")
    # Manipulate repos
    sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list;

    #TODO: espio will need a different pkg list
    #Use rasbian instead of debian?
    sudo apt-get install `cat deb_pkgs.txt`;
    dotfiles;
    sudo sed -in 's/jessie/testing/g' /etc/apt/sources.list;
    sudo apt-get update && sudo apt-get upgrade;
    ;;
  "vector")
    # Manipulate repos
    sudo sed -in 's/main/main non-free contrib/g' /etc/apt/sources.list;
    #TODO: vector will need a different pkg list
    #Use stable instead?
    sudo apt-get install `cat deb_pkgs.txt`;
    dotfiles;
    ;;
  *)
    # Who is this??
    echo "unkown system installing video-all"
    sudo apt-get install xserver-xorg-video-all;
    # skipping default softs
    echo "Skipping non-packaged software. Proceeding to dotfiles"
    # Still want dotfiles for applications
    base;
    dotfiles;
    ;;
esac
