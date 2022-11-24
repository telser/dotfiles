[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Force the locale so zsh theme stuff will work later
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Antigen loading:

source $HOME/dotfiles/antigen/antigen.zsh
# Use oh-my-zsh plugins
antigen use oh-my-zsh

# Use git, command-not-found, and syntax-highlighting
antigen bundle git
antigen bundle command-not-found
antigen bundle pass
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle Tarrasch/zsh-autoenv
# Use muse theme
antigen theme $HOME/dotfiles custom.zsh-theme

# Finish up with antigen
antigen apply

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

# Autocd allows for an implicit cd when given just a path
setopt autocd extendedglob

# Get rid of bell
set bell-style none

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
#zstyle :compinstall filename '/home/trevis/.zsh_compinit'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

[ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env
