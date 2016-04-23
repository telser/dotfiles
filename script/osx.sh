brew_installed=0;
brew_retry=0;

## Vars to save if installing a grouping
install_clojure=0
install_emacs=0
install_gcc=0
install_golang=0
install_haskell=0
install_purescript=0
install_ruby=0
install_tex=0
install_typescript=0
install_utils=0

ask_install () {
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) var=1;
                  eval "$1=$var"
                  break;;
            No ) break;;
        esac
    done
}

install_questionnaire() {
    echo "Here we go, going to ask a bunch of questions about what to install.\n";
    echo "Install Leiningen/Clojure?\n"
    ask_install "install_clojure"
    echo "Install emacs?\n"
    ask_install "install_emacs"
    echo "Install c tools?\n"
    ask_install "install_gcc"
    echo "Install golang?\n"
    ask_install "install_golang"
    echo "Install Haskell?\n"
    ask_install "install_haskell"
    echo "Install Purescript?\n"
    ask_install "install_purescript"
    echo "Install Ruby tools?\n"
    ask_install "install_ruby"
    echo "Install MacTex?\n"
    ask_install "install_tex"
    echo "Install typescript?\n"
    ask_install "install_typescript"
    echo "Install utilities? This includes mosh, sloccount, and the_silver_searcher\n"
    ask_install "install_utils"
}

install_brew() {
    if [[ $brew_retry -ge 5 ]];
    then
        echo "Already reached max retry for brew installation, bailing out.\n"
        return 1;
    else
        ruby_brew_get () {
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        }
        until [[ $brew_retry -ge 5 ]]
        do
            ruby_brew_get && break
            echo "Homebrew install $brew_retry failed, sleeping 10 and trying again.\n"
            brew_retry=$[$brew_retry+1]
            sleep 10;
        done
    fi
}

retry_brew() {
    echo "Did not find homebrew! Installing and retrying.\n"
    install_brew;
}

clojure() {
    if [[ "$install_clojure" -eq 1 ]];
    then
        if [[ "$brew_installed" -eq 1 ]];
        then
            if [[ -e /usr/local/bin/emacs ]];
            then
                echo "Lein/clojure already installed, nothing to do here."
            else
                brew install leiningen;
            fi
        else
            echo "Did not find homebrew! Installing and retrying.\n"
            install_brew;
            clojure;
        fi
    else
        echo "Chose not to install leiningen/clojure"
    fi
}

emacs() {
    if [[ "$install_emacs" -eq 1 ]];
    then
        if [[ "$brew_installed"=true ]];
        then
            if [[ -e /usr/local/bin/emacs ]];
            then
                echo "Emacs already installed, nothing to do here.\n"
            else
                brew tap railwaycat/homebrew-emacsmacport
                brew install emacs --with-spacemacs-icon
                brew linkapps
            fi
        else
            echo "Did not find homebrew! Installing and retrying.\n"
            install_brew;
            emacs;
        fi
    else
        echo "Chose not to install emacs."
    fi
}

gcc() {
    if [[ "$install_gcc" -eq 1 ]];
    then
        if [[ "$brew_installed"=true ]];
        then
            if [[ -e "/usr/bin/gcc" ]];
            then
                echo "Found gcc already!"
            else
                echo "Installing gcc"
                brew install mosh gcc sloccount the_silver_searcher
            fi

            if [[ -e "/usr/local/bin/gdb" ]];
            then
                echo "Found gdb already!"
            else
                echo "Installing gdb"
                brew install gdb
            fi

            if [[ -e "/usr/local/bin/valgrind" ]];
            then
                echo "Found valgrind already!"
            else
                echo "Installing valgrind"
                brew install valgrind
            fi
        else
            retry_brew;
            gen_dev;
        fi
    else
        echo "Chose not to install c tools"
    fi
}

golang() {
    if [[ "$install_golang" -eq 1 ]];
    then
        if [[ "$brew_installed"=true ]];
        then
            if [[ -e "/usr/local/bin/go" ]];
            then
                echo "Go already installed, nothing to do here."
            else
                echo "installing go"
                brew install go;
            fi
        else
            retry_brew;
            golang;
        fi

        cd ~;
        go get github.com/tools/godep
    else
        echo "Chose not to install golang.";
    fi
}

haskell() {
    if [[ "$install_haskell" -eq 1 ]];
    then
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

        stack setup;

        stack_packages='"alex" "happy" "stylish-haskell" "hindent" "dash-haskell" "hackage" "hasktags"'
        for i in $stack_packages; do
            stack install $i;
        done
    else
        echo "Chose not to install Haskell";
    fi
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
    if [[ "$install_purescript" -eq 1 ]];
    then
        echo "Need npm for purescript, checking for it now."
        npm;
        if [[ -e "/usr/local/bin/psc" ]];
        then
            echo "Found psc skipping."
        else
            echo "Installing purescript globally, using sudo"
            sudo npm -g install purescript;
        fi

        if [[ -e "/usr/local/bin/pulp" ]];
        then
            echo "Found pulp, skipping"
        else
            echo "Installing pulp globally, using sudo"
            sudo npm -g install pulp
        fi
    else
        echo "Chose not to install purescript";
    fi
}

ruby() {
    if [[ "$install_ruby" -eq 1 ]];
    then
        if [[ "$brew_installed"=true ]];
        then
            echo "Installing ruby 2.3.0 and some tools";
            brew install rbenv;
            rbenv install 2.3.0;
            sudo gem install bundler;

        else
            retry_brew;
            ruby;
        fi
    else
        echo "Chose not to install ruby & tools.";
    fi
}

tex() {
    if [[ "$install_tex" -eq 1 ]];
    then
        if [[ "$brew_installed"=true ]];
        then
            echo "installing tex and graphviz"
            if [[ -e "/Library/TeX/texbin/latex" ]];
            then
                echo "Found latex, skipping mactex install";
            else
                brew tap caskroom/cask;
                brew cask install mactex;
            fi

            if [[ -e "/usr/local/bin/dot" ]];
            then
                echo "Found graphviz, nothing to do here";
            else
                brew install graphviz;
            fi
        else
            retry_brew;
            tex;
        fi
    else
        echo "Chose not to install MacTeX";
    fi
}

typescript() {
    if [[ "$install_purescript" -eq 1 ]];
    then
        echo "Need npm for typescript, checking for it now."
        npm;
        if [[ -e "/usr/local/bin/tsc" ]];
        then
            echo "Found tsc skipping."
        else
            echo "Installing typescript globally, using sudo"
            sudo npm -g install typescript;
        fi

        if [[ -e "/usr/local/bin/tslint" ]];
        then
            echo "Found tslint, skipping"
        else
            echo "Installing tslint globally, using sudo"
            sudo npm -g install tslint
        fi

        if [[ -e "/usr/local/bin/typings" ]];
        then
            echo "Found typings, skipping"
        else
            echo "Installing typings globally, using sudo"
            sudo npm -g install typings
        fi
    else
        echo "Chose not to install typescript";
    fi
}

utils() {
    if [[ "$install_utils" -eq 1 ]];
    then
        if [[ -e "/usr/local/bin/mosh" ]];
        then
            echo "Found mosh, skipping";
        else
            brew install mosh;
        fi

        if [[ -e "/usr/local/bin/ag" ]];
        then
            echo "Found Ag, skipping";
        else
            brew install the_silver_searcher;
        fi

        if [[ -e "/usr/local/bin/sloccount" ]];
        then
            echo "Found sloccount, skipping";
        else
            brew install sloccount;
        fi
    else
        echo "Chose not to install utils";
    fi
}

install_questionnaire;

# run xcode-select for the path, if this returns an error no dev tools are installed
xcode-select -p 1>/dev/null
if [[ "$?" -eq 0 ]];
then
    echo "Successfully found XCode";
else
    echo "Did not find Xcode! Requesting install and sleeping 2 minutes to download/install."
    xcode-select --install;
    sleep 120;
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

clojure;
emacs;
gcc;
golang;
haskell;
purescript
ruby;
tex;
typescript;
utils;
