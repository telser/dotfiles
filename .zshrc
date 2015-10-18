# Antigen loading:

    source $HOME/antigen/antigen.zsh
    # Use oh-my-zsh plugins
    antigen use oh-my-zsh

    # Use git, command-not-found, and syntax-highlighting
    antigen bundle git
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting

    # Use muse theme
    antigen theme muse

    # Finish up with antigen
    antigen apply

# Get rid of bell
set bell-style none

# Some aliases to make things nicer
export EDITOR='emacs'

# Laptop options:
if [[ "$HOST" == 'charmy' ]]; then
    #    alias fl='wine .wine/drive_c/Program\ Files/Image-Line/FL\ Studio\ 11/FL.exe'

    # Export path with cabal and home bin
    PATH=$PATH:/usr/local/sbin:$HOME/bin
    export PATH

    # Freebsd options
    if [[ "$OSTYPE" == 'freebsd'* ]]; then
        # BSD ls options for colors etc
        alias ls='ls -hG'

        # Use Emacs24
        alias emacs='emacs24 -nw'
    fi
else
    if [[ "$OSTYPE" == darwin* ]]; then

        # BSD style ls
        alias ls='ls -hG'

        # Set some env vars for work stuff
        SERVO_CONF=$HOME/work/tom-servo/dev.conf
        export SERVO_CONF;
        ES_HEAP_SIZE=2g
        export ES_HEAP_SIZE;
        AGENT_VAGRANT_DIR=/Users/trevis/work/agentsites
        export AGENT_VAGRANT_DIR;
        SERVO_VAGRANT_DIR=/Users/trevis/work/tom-servo
        export SERVO_VAGRANT_DIR;

        # Include more dirs in the path
        PATH=/usr/local/sbin:/usr/local/bin:$PATH:$HOME/bin:$HOME/packer:$HOME/Downloads/adt-bundle-mac-x86_64-20140702/sdk/platform-tools:./.cabal-sandbox/bin/:/Library/TeX/texbin
        export PATH

        # Use emacsclient
        export EDITOR='emacsclient -nw'

        # Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
        export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
        if [ -d "$GHC_DOT_APP" ]; then
            export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
        fi

        source /Users/trevis/.iterm2_shell_integration.zsh

    fi
fi
