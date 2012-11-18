#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set bell-style none

# Some aliases to make things nicer
alias ls='ls --color=auto'

alias lab='ssh -X telser@lab0z.mathcs.emory.edu'

alias fl='wine .wine/drive_c/Program\ Files\ \(x86\)/Image-Line/FL\ Studio\ 10/FL.exe'

#Make sure the ENV is setup
export EDITOR='vim'

PATH=$PATH:/home/trevis/.cabal/bin
export PATH



export _JAVA_AWT_WM_NONREPARENTING=1

PS1='[\u@\h \W]\$ '
