#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Some aliases to make things nicer
alias ls='ls --color=auto'
alias spotify="wine .wine/drive_c/users/trev/Application\ Data/Spotify/spotify.exe"


#Make sure the ENV is setup
export EDITOR='vim'

PATH=$PATH:/home/trevis/.cabal/bin
export PATH


PS1='[\u@\h \W]\$ '
