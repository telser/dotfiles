# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [ -n "$INSIDE_EMACS" ]; then
   ZSH_THEME="sorin"
   unsetopt zle
else
   ZSH_THEME="muse"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cabal lein battery colorize colored-man)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#

#[[ $TERM != screen* ]] && exec tmux
set bell-style none

# Some aliases to make things nicer
export EDITOR='emacs'

# Work laptop options
if [[ "$HOST" == 'charmy' ]]; then
#    alias ls='ls --color=auto -h'
#    alias update-all='sudo apt-get update && sudo apt-get dist-upgrade'
#    alias fl='wine .wine/drive_c/Program\ Files/Image-Line/FL\ Studio\ 11/FL.exe'
    PATH=$PATH:$HOME/.cabal/bin:/usr/local/sbin:$HOME/bin
    export PATH
    if [[ "$OSTYPE" == 'freebsd'* ]]; then
        alias ls='ls -hG'
        alias emacs='emacs24 -nw'
    fi
else
    if [[ "$OSTYPE" == darwin* ]]; then
        alias ls='ls -hG'
        SERVO_CONF=$HOME/work/tom-servo/dev.conf
        export SERVO_CONF;
        ES_HEAP_SIZE=2g
        export ES_HEAP_SIZE;
        PATH=$HOME/Library/Haskell/bin:$HOME/.cabal/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/bin:$HOME/packer:$HOME/Downloads/adt-bundle-mac-x86_64-20140702/sdk/platform-tools:./.cabal-sandbox/bin/
        export PATH
        # source /usr/local/opt/chruby/share/chruby/chruby.sh
        # source /usr/local/opt/chruby/share/chruby/auto.sh
        export EDITOR='emacsclient -nw'
        AGENT_VAGRANT_DIR=/Users/trevis/work/agentsites
        export AGENT_VAGRANT_DIR;
        SERVO_VAGRANT_DIR=/Users/trevis/work/tom-servo
        export SERVO_VAGRANT_DIR;
    fi
fi

#Make sure the ENV is setup

#export _JAVA_AWT_WM_NONREPARENTING=1

#PS1='[\u@\h \W]\$ '
