brew_installed=0;
brew_retry=0;

install_brew() {
    if [[ $brew_retry -ge 5 ]];
    then
        echo "Already reached max retry for brew installation, bailing out."
        return 1;
    else
        ruby_brew_get () {
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        }
        until [[ $brew_retry -ge 5 ]]
        do
            ruby_brew_get && break
            echo "Homebrew install $brew_retry failed, sleeping 10 and trying again"
            brew_retry=$[$brew_retry+1]
            sleep 10;
        done
    fi
}

retry_brew() {
    echo "Did not find homebrew! Installing and retrying."
    install_brew;
}

emacs() {
    if [[ "$brew_installed"=true ]];
    then
        if [[ -e /usr/local/bin/emacs ]];
        then
            echo "Emacs already installed, nothing to do here."
        else
            brew tap railwaycat/homebrew-emacsmacport
            brew install emacs --with-spacemacs-icon
            brew linkapps
        fi
    else
        echo "Did not find homebrew! Installing and retrying."
        install_brew;
        emacs;
    fi
}

haskell() {
    if [[ -e "$HOME:/.local/bin/stack" ]];
    then
        echo "Stack already installed nothing to do here."
    else
        if [[ "$brew_installed"=true ]];
        then
            brew install haskell-stack
        else
            retry_brew;
            haskell;
        fi
    fi

    # Make sure we're in home to use the 'global' stack settings
    cd ~;

    stack_packages='"alex" "happy" "stylish-haskell" "hindent" "dash-haskell" "hackage" "hasktags"'
    for i in $stack_packages; do
        stack install $i;
    done
}

npm() {
    if [[ -e "/usr/local/bin/npm" ]];
    then
        echo "npm already installed nothing to do here"
    else
        if [[ "$brew_installed"=true ]];
        then
            echo "installing npm"
            brew install npm
        else
            retry_brew;
            npm;
        fi
    fi
}

purescript() {
    npm;
    echo "Installing purescript globally, using sudo"
    sudo npm -g install purescript pulp;
}

golang() {
    if [[ "$brew_installed"=true ]];
    then
        echo "installing go"
        brew install go;
    else
        retry_brew;
        golang;
    fi

    cd ~;
    go get github.com/tools/godep
}

tex() {
    if [[ "$brew_installed"=true ]];
    then
        echo "installing tex and graphviz"
        brew tap caskroom/cask
        brew cask install mactex
        brew install graphviz
    else
        retry_brew;
        tex;
    fi
}

gen_dev() {
    if [[ "$brew_installed"=true ]];
    then
        echo "Installing some basic dev tools"
        brew install mosh gcc sloccount the_silver_searcher
    else
        retry_brew;
        gen_dev;
    fi
}

ruby() {
    if [[ "$brew_installed"=true ]];
    then
        echo "Installing ruby and some tools";
        brew install rbenv;
        rbenv install 2.3.0;
        gem install bundler;

    else
        retry_brew;
        ruby;
    fi
}

# run xcode-select for the path, if this returns an error no dev tools are installed
xcode-select -p 1>/dev/null
if [[ "$?" -eq 0 ]];
then
    echo "Successfully found XCode";
else
    echo "Did not find Xcode! Requesting install"
    xcode-select --install
fi

# Always try to install homebrew
if [[ -e /usr/local/bin/brew ]];
then
    brew_installed=1;
    echo "Found homebrew"
else
    install_brew;
    brew_installed=1;
fi

emacs;
gen_dev;
golang;
haskell;
purescript
ruby;
tex;
