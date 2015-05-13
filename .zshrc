# Antigen loading:

if [[ "$OSTYPE" == darwin* ]]; then
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
fi

# Get rid of bell
set bell-style none

# Some aliases to make things nicer
export EDITOR='emacs'

# Laptop options:
if [[ "$HOST" == 'charmy' ]]; then
    #    alias fl='wine .wine/drive_c/Program\ Files/Image-Line/FL\ Studio\ 11/FL.exe'

    # Export path with cabal and home bin
    PATH=$PATH:$HOME/.cabal/bin:/usr/local/sbin:$HOME/bin
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
        PATH=$HOME/Library/Haskell/bin:$HOME/.cabal/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/bin:$HOME/packer:$HOME/Downloads/adt-bundle-mac-x86_64-20140702/sdk/platform-tools:./.cabal-sandbox/bin/
        export PATH

        # Use emacsclient
        export EDITOR='emacsclient -nw'

    fi
fi
