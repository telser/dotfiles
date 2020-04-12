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

elif [ "$NAME" = "zero" ]; then
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

elif [ "$NAME" = "magmadragoon" ]; then
     # turn off bluetooth, don't need it anyway
    /usr/sbin/rfkill block bluetooth

    # export dbus info because some shit will fall over in unexpected ways
    # without it (I see you slack)
    export "$(dbus-launch)"

    # systray
    stalonetray &

    # clipboard manager
    clipit &

    # set wallpaper
    nitrogen --restore &

    # wireless management using wicd, which is the least bad option compared to nm and connman
    wicd-gtk &
     # populates file with updatable packages, checked in start_dzen
    sh ~/dotfiles/cronscripts/apt_upgradable.sh &

    # start top right bar with update info, clock, battery, etc
    sh ~/dzen/scripts/start_dzen.sh &

    # reduce brightness because having it all the way up is just silly, wastes power, etc etc
    brightnessctl -c backlight set 50%

    # go ahead and fire up an editor daemon
    emacs --daemon

    # adjust screen temperature at night
    redshift -c ~/.redshift.conf &

    # dunst is not the prettiest notification manager thing
    # But it is available most places and just works
    dunst -conf ~/.dunstrc &

    # pulseaudio because life is a giant pit of despair
    # This is just the tray, since magmadragoon is devuan installing a demon means starting it at boot
    # so pulse is already started..
    pasystray &
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
