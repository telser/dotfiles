#!/bin/sh
# install script for freebsd

# Dotfiles!
dotfiles()
{
  # Get the dotfiles
  git clone https://gitlab.com/telser/dotfiles.git;
  # actually install the dotfiles
  sudo cp -r --preserve=all dotfiles/. ~/;
  rm -rf dotfiles/;

  # Get oh-my-zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh;

  # Make zsh default shell
  chsh -s /local/bin/zsh;
}

# Haskell
hs() {

  cabal update;
  cabal install cabal-install;
  cabal install happy alex;
  cabal install ghc-mod stylish-haskell;
  cabal install structured-haskell-mode --constraint=haskell-src-exts==1.15.0.1;

}

# Clojure
clj() {
 wget https://raw.github.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein --no-check-certificate;
 chmod 755 ~/bin/lein;
 lein version;
}

# Setup directories for desktop/laptop
dldir() {

  mkdir projects;
  cd projects;
  # git clone git@bitbucket.org:telser/retrograde-music-player.git;
  # git clone git@bitbucket.org:telser/hlibvlc.git;
  git clone https://gitlab.com/telser/dep-graph.git;
  git clone https://gitlab.com/telser/lein-report.git;
  cd ~;
  mkdir school;
  mkdir books;

}

set -e

NAME=$(uname "-n")

# Install correct software by machine

case $NAME in
    "charmy")
        dotfiles;
        dldir;
        clj;
        hs;
    ;;
esac
