#!/usr/bin/env zsh
OS=$(uname)
brew_installed=0;
brew_retry=0;

## Vars to save if installing a grouping
install_c_tools=0
install_clojure=0
install_emacs=0
install_golang=0
install_haskell=0
install_purescript=0
install_ruby=0
install_spacemacs=0
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
    ask_install "install_c_tools"
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
    eecho "Install spacemacs?\n"
    ask_install "install_spacemacs"
cho "Install typescript?\n"
    ask_install "install_typescript"
    echo "Install utilities? This includes mosh, sloccount, and the_silver_searcher\n"
    ask_install "install_utils"
}

install_brew() {
    if [[ $brew_retry -ge 5 ]]; then
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

brew_check_or_install() {
    if [[ "$brew_installed" = true ]]; then
        echo "installing $1"
        brew install "$1"
    else
        retry_brew;
        brew_check_or_install "$1"
    fi
}

os_install_switch() {
    if [[ "$OS" == "FreeBSD" ]]; then
        echo "installing $1"
        sudo pkg install "$1"
    else
        if [[ "$OS" == "Darwin" ]]; then
            brew_check_or_install "$1"
        fi
    fi
}

os_pkg_install() {
    if [[ "$OS" == "FreeBSD" ]]; then
        case "$1" in
            "emacs" )
                os_install_switch "emacs24";;
            "gem" )
                os_install_switch "ruby21-gems";;
            "stack" )
                # As of 2016/4 there is no stack package for freebsd, so this is a workaround
                sudo ln -s /lib/libutil.so.9 /lib/libutil.so.8
                os_install_switch "hs-cabal-install"
                cabal update
                cabal install stack
                stack setup;;
            * )
                echo "No mapping found for pkg, trying just name"
                os_install_switch "$1";;
        esac
    else
        if [[ "$OS" == "Darwin" ]]; then
            case "$1" in
                "emacs" )
                    brew tap railwaycat/homebrew-emacsmacport
                    os_install_switch "emacs-mac --with-spacemacs-icon"
                    brew linkapps;;
                "gem" ) ## rubygems is already installed on Darwin, no-op here
                    ;;
                "ruby" ) ## ruby is already installed on Darwin, no-op here
                    ;;
                "stack" )
                    brew install haskell-stack
                    stack setup;;
                * )
                    echo "No mapping found for $1 trying just name"
                    os_install_switch "$1";;
            esac
        fi
    fi
}

pkg_install() {
    case "$1" in
        "gem" )
            echo "Warning, installing gem pkg $2. Needs sudo!"
            sudo gem install "$2";;
        "go" )
            go get "$2";;
        "npm" )
            echo "Warning installing $2 as global npm pkg. Needs sudo!"
            sudo npm -g install "$2";;
        "stack" )
            cd ~;
            stack install "$2";;
        "os")
            os_pkg_install "$2";;
        * )
            echo "Warning!!! Attempt to use unknown package source, $1";;
    esac
}

file_found() {
    if [[ -e "$1" ]]; then
        0;
    else
        1;
    fi
}

find_or_install_pkg_mgr() {
    ## FIXME: Implement this.
    ## FIXME: Other pkg managers?.
    case "$1" in
        # "gem" )
        #     echo "dnf"
        #     break;;
        "go" )
            find_or_install_pkg 1 "/usr/local/bin/go" go os;;
        # "lein" )
        #     echo "dnf"
        #     break;;
        "npm" )
            find_or_install_pkg 1 "/usr/local/bin/npm" npm os;;
        "stack" )
            find_or_install_pkg 1 "$HOME:/.local/bin/stack" stack os;;
        "os" ) # no-op use system pkgs
            ;;
        * )
            echo "Warning!! Attempt to use unknown pkg source $1";;
    esac
}

install_with_version_mgr() {
    case "$1" in
        "rbenv" )
            find_or_install_pkg 1 "/usr/local/bin/rbenv" rbenv os
            rbenv install "$2";;
        * )
            echo "Warning!! Attempt to use unknown version mgr $1";;
    esac
}

find_or_install_pkg() {
    if [[ "$1" -eq 1 ]]; then
        if [[ -e "$2" ]]; then
            echo "$3 found! Skipping install"
        else
            find_or_install_pkg_mgr "$4"
            pkg_install "$4" "$3"
        fi
    fi
}

c_tools() {
    if [[ "$install_c_tools" -eq 1 ]]; then
        if [[ "$OS" == "FreeBSD" ]]; then
            if [[ -e "/usr/local/bin/gcc" ]]; then
                gcc_installed=1
            else
                gcc_installed=0
            fi
        else
            if [[ "$OS" == "Darwin" ]]; then
               if [[ -e "/usr/bin/gcc" ]]; then
                   gcc_installed=1
               else
                   gcc_installed=0
               fi
            fi
        fi

        # Now time for the actual gcc switch
        if [[ "$gcc_installed" -eq 1 ]]; then
            echo "gcc found! Skipping install"
        else
            os_pkg_install gcc
        fi

        # gdb isn't installed somewhere else on Darwin, so this is easier
        find_or_install_pkg 1 "/usr/local/bin/gdb" gdb os

        find_or_install_pkg 1 "/usr/local/bin/valgrind" valgrind os
    else
        echo "Chose not to install c tools"
    fi
}

clojure() {
    find_or_install_pkg "$install_clojure" "${HOME}/.local/bin/lein" leiningen os
}

emacs() {
    find_or_install_pkg "$install_emacs" "/usr/local/bin/emacs" "emacs" os
}

golang() {
    find_or_install_pkg "$install_golang" "$HOME:/go/bin/godep" github.com/tools/godep go
}

haskell() {
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/alex" alex stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/happy" happy stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/stylish-haskell" stylish-haskell stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/hindent" hindent stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/dash-haskell" dash-haskell stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/hackage" hackage stack
    find_or_install_pkg "$install_haskell" "$HOME:/.local/bin/hasktags" hasktags stack
}

purescript() {
    find_or_install_pkg "$install_purescript" "/usr/local/bin/psc" purescript "npm"
    find_or_install_pkg "$install_purescript" "/usr/local/bin/pulp" pulp "npm"
}

ruby() {
    install_with_version_mgr "rbenv" "2.3.0"
    find_or_install_pkg "$install_ruby" "/usr/local/bin/bundler" bundler "gem"
}

spacemacs() {
    #FIXME: create git pkg management fn?
    if [[ "$install_spacemacs" -eq 1 ]]; then
        echo "Spacemacs is being placed in ~/.emacs.d Starting emacs will install it's own pkgs"
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    fi
}

tex() {
    #FIXME: Implement this
}

typescript() {
    find_or_install_pkg "$install_typescript" "/usr/local/bin/tsc" typescript "npm"
    find_or_install_pkg "$install_typescript" "/usr/local/bin/tslint" tslint "npm"
    find_or_install_pkg "$install_typescript" "/usr/local/bin/typings" typings "npm"
}

utils() {
    find_or_install_pkg "$install_utils" "/usr/local/bin/mosh" mosh os
    find_or_install_pkg "$install_utils" "/usr/local/bin/ag" the_silver_searcher os
    find_or_install_pkg "$install_utils" "/usr/local/bin/sloccount" sloccount os
}

xcode() {
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
}

### Actually start executing ###

# Run questionnaire for tools to install
install_questionnaire;

if [[ "$OS" == "Darwin" ]]; then
    echo "Running Darwin, need xcode before we can do anything"
    xcode;
fi

c_tools;
clojure;
emacs;
golang;
haskell;
purescript;
ruby;
spacemacs;
tex;
typescript;
utils;
