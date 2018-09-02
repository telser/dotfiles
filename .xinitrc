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
    xrandr --dpi 192
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

# Set the locale before launching xmonad to prevent character funkiness
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MM_CHARSET=UTF-8

xset b off &                             # Turn off term bell

xrdb -merge ~/.Xresources                # Set term font/color

xmodmap ~/.Xmodmap                       # Rebind keys

xsetroot -cursor_name left_ptr
exec "$(command -v xmonad)"
