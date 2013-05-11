#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#[[ $TERM != screen* ]] && exec tmux
set bell-style none

# Some aliases to make things nicer
alias ls='ls --color=auto'

alias lab='ssh -X telser@lab0z.mathcs.emory.edu'

alias fl='wine .wine/drive_c/Program\ Files/Image-Line/FL\ Studio\ 10/FL.exe'

#Make sure the ENV is setup
export EDITOR='vim'

PATH=$PATH:/home/trevis/.cabal/bin
export PATH



export _JAVA_AWT_WM_NONREPARENTING=1

PS1='[\u@\h \W]\$ '
[[ -f "/home/trevis/.local/share/Steam/setup_debian_environment.sh" ]] && source "/home/trevis/.local/share/Steam/setup_debian_environment.sh"
