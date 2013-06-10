# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(cabal rails ruby lein rake git battery github colorize colored-man)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#

#[[ $TERM != screen* ]] && exec tmux
set bell-style none

# Some aliases to make things nicer
#alias ls='ls --color=auto'

alias lab='ssh -X telser@lab0z.mathcs.emory.edu'

alias fl='wine .wine/drive_c/Program\ Files/Image-Line/FL\ Studio\ 11/FL.exe'

#Make sure the ENV is setup
export EDITOR='vim'

PATH=$PATH:$HOME/.cabal/bin
export PATH



#export _JAVA_AWT_WM_NONREPARENTING=1

#PS1='[\u@\h \W]\$ '
[[ -f "/home/trevis/.local/share/Steam/setup_debian_environment.sh" ]] && source "/home/trevis/.local/share/Steam/setup_debian_environment.sh"
