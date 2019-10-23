#!/bin/sh
NAME=$( uname "-n")

## Devel fbsd box
if [ "$NAME" = "double2" ]; then
    conky -c ~/.conkyLeftrc &
    clipit &
    nitrogen --restore &
    tint2 -c ~/tint2.conf &                   # Topbar and systray
    xset fp+ /usr/local/share/fonts/urwfonts
    xset fp+ /usr/local/share/fonts/Hack
    xset fp rehash
fi

if [ "$NAME" = "zero" ]; then
    xrandr --dpi 144
    xrandr --output eDP-1 --mode 2880x1620
    export GDK_SCALE=2
    conky -c .conkyLeftrc &
    stalonetray &
    clipit &
    nitrogen --restore &
    eval "$(ssh-agent)"
    /usr/sbin/rfkill block bluetooth
    sh ~/dzen/scripts/start_dzen.sh &
    wicd-gtk &
#    sh use_headphone_amp.sh
    export "$(dbus-launch)"
fi

if [ "$NAME" = "magmadragoon" ]; then
    /usr/sbin/rfkill block bluetooth # turn off bluetooth, don't need it anyway
    conky -c .conkyLeftrc & # put basic system info on "desktop" screen
    stalonetray & # systray
    clipit & # clipboard manager
    nitrogen --restore & # set wallpaper
    wicd-gtk & # wireless management
    sh ~/dotfiles/cronscripts/apt_upgradable.sh & # populates file with updatable packages, checked in start_dzen
    sh ~/dzen/scripts/start_dzen.sh & # start top right bar with update info, clock, battery, etc
    brightnessctl -c backlight set 75% # because having the brightness all the way up is just silly
    emacs --daemon # go ahead and fire up an editor daemon
    redshift -c ~/.redshift.conf & # adjust screen temperature at night
fi

# Set the locale before launching xmonad to prevent character funkiness
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MM_CHARSET=UTF-8

xset b off &                             # Turn off term bell

xrdb -merge ~/.Xresources                # Set term font/color

xmodmap ~/.Xmodmap                       # Rebind keys

xsetroot -cursor_name left_ptr
exec xmonad
