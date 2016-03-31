[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
autoload -Uz compinit
compinit
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

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob

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

        # Include more dirs in the path
        PATH=/usr/local/sbin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/bin:/Library/TeX/texbin
        export PATH

	# Set gopath
	GOPATH=$HOME/go
	export GOPATH

	# Add go bins to path
	PATH=$PATH:$HOME/go/bin

        # Use emacsclient
        export EDITOR='emacsclient -nw'

        PATH=$HOME/.stack/programs/x86_64-osx/ghc-7.10.2/bin:$PATH
        export PATH
        source /Users/trevis/.iterm2_shell_integration.zsh

    else
      PATH=$HOME/.local/bin:$PATH
      export PATH
    fi
fi
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/telser/.zsh_compinit'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export NVM_DIR="/Users/trevis/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
