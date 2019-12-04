#!/bin/sh

symlink_if_not_exists()
{
    if [ ! -e "$2" ]; then
        if [ -e "$1" ]; then
            ln -s "$1" "$2"
        else
            echo "Link source, $1, does not exist, cannot install"
        fi
    else
        echo "Link target, $2 already exists! Not relinking"
    fi

}

symlink_if_not_exists ~/dotfiles/.xinitrc ~/.xinitrc
symlink_if_not_exists ~/dotfiles/.emacs ~/.emacs
symlink_if_not_exists ~/dotfiles/emacs ~/emacs
symlink_if_not_exists ~/dotfiles/.zshenv ~/.zshenv
symlink_if_not_exists ~/dotfiles/.zshrc ~/.zshrc
symlink_if_not_exists ~/dotfiles/.vimrc ~/.vimrc
symlink_if_not_exists ~/dotfiles/display.sh ~/display.sh
symlink_if_not_exists ~/dotfiles/.Xmodmap ~/.Xmodmap
symlink_if_not_exists ~/dotfiles/.Xresources ~/.Xresources
symlink_if_not_exists ~/dotfiles/.xmonad ~/.xmonad
symlink_if_not_exists ~/dotfiles/.stalonetrayrc ~/.stalonetrayrc
symlink_if_not_exists ~/dotfiles/.conkyLeftrc ~/.conkyLeftrc
symlink_if_not_exists ~/dotfiles/.alacritty.yml ~/.alacritty.yml
symlink_if_not_exists ~/dotfiles/dzen ~/dzen
symlink_if_not_exists ~/dotfiles/.redshift.conf ~/.redshift.conf
symlink_if_not_exists ~/dotfiles/.dunstrc ~/.dunstrc
