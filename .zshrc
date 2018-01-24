[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
# Antigen loading:

    source $HOME/dotfiles/antigen/antigen.zsh
    # Use oh-my-zsh plugins
    antigen use oh-my-zsh

    # Use git, command-not-found, and syntax-highlighting
    antigen bundle git
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle Tarrasch/zsh-autoenv
    # Use muse theme
    antigen theme $HOME/dotfiles custom.zsh-theme

    # Finish up with antigen
    antigen apply

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Get rid of bell
set bell-style none

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 4 numeric
zstyle :compinstall filename '/home/trevis/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
