[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
autoload -Uz compinit
compinit
# Antigen loading:

    source $HOME/dotfiles/antigen/antigen.zsh
    # Use oh-my-zsh plugins
    antigen use oh-my-zsh

    # Use git, command-not-found, and syntax-highlighting
    antigen bundle git
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle Tarrasch/zsh-autoenv
    antigen bundle horosgrisa/zsh-gvm
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
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
# # The following lines were added by compinstall

# zstyle ':completion:*' completer _complete _ignored _approximate
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# zstyle :compinstall filename '/home/telser/.zsh_compinit'
