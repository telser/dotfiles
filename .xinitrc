#!/bin/sh
NAME=$(uname "-n")

# Set the locale before launching xmonad to prevent character funkiness
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MM_CHARSET=UTF-8

# Turn off term bell
xset b off

# Set term font/color
xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr

# Rebind keys
# make sure keybindings are at the defaults before applying xmodmap changes
setxkbmap
# use xmodmap to remap caps_lock to control and left control to hyper
xmodmap ~/.Xmodmap

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
#    xrandr --output eDP-1 --mode 2880x1620
    export GDK_SCALE=2

    stalonetray &
    clipit &
    nitrogen --restore &
#    eval "$(ssh-agent)"
    urxvtd -q -o -f

    sh ~/dzen/scripts/start_dzen.sh &

    # dunst is not the prettiest notification manager thing
    # But it is available most places and just works
    dunst -conf ~/.dunstrc &

    # adjust screen temperature at night
    redshift -c ~/.redshift.conf &

    export $(dbus-launch)

    intel_backlight 30

    # populates file with updatable packages, checked in start_dzen
    sh ~/dotfiles/cronscripts/pkg_upgradable.sh &

    # a mixer in the tray
    dsbmixer -i &

    # set some xinput properties here rather than needing a whole config file for this stuff

    # set pointer speed to be faster
    xinput set-prop "DLL06E5:00 06CB:7A13 Mouse" "libinput Accel Speed" 0.9

    # set palm detection on
    xinput set-prop "DLL06E5:00 06CB:7A13 TouchPad" "Synaptics Palm Detection" 1

    # Set tapping actions:
    ## Corners:
    ### Right Top: 0 - Disable
    ### Right Bottom: 0 - Disable
    ### Left Top: 0 - Disable
    ### Left Bottom: 0 - Disable
    ## Tap
    ### One Finger: 1 - Left Click (Mouse button 1)
    ### Two Finger: 3 - Right Click (Mouse button 3)
    ### Three Finger: 2 - Middle Click (Mouse button 2)
    xinput set-prop "DLL06E5:00 06CB:7A13 TouchPad" "Synaptics Tap Action" 0 0 0 0 1 3 2

    syncthingtray &

elif [ "$NAME" = "double" ]; then

     # turn off bluetooth, if it is needed can always turn it on manually
    bluetoothctl power off

    # export dbus info because some shit will fall over in unexpected ways
    # without it (I see you slack)
    export $(dbus-launch)

    # kdeconnect
    kdeconnectd &
    kdeconnect-indicator &

    # using pipewire for audio
    pipewire &

    # systray
    stalonetray &
    # previous trayer setup
    # trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --widthtype percent --width 12 --tint "0x000000" --transparent true --alpha 127 --height 42 &

    # clipboard manager
    clipit &

    # set wallpaper
    nitrogen --restore &

    # wireless management using nm again because ugh
    nm-applet &

     # populates file with updatable packages, checked in start_dzen
#    sh ~/dotfiles/cronscripts/apt_upgradable.sh &

    # start top right bar with update info, clock, battery, etc
    sh ~/dzen/scripts/start_dzen.sh &

    # reduce brightness because having it all the way up is just silly, wastes power, etc etc
    brightnessctl -c backlight set 40%

    # adjust screen temperature at night
    redshift -c ~/.config/redshift.conf &

    # dunst is not the prettiest notification manager thing
    # But it is available most places and just works
    dunst -conf ~/.dunstrc &

    # pasystray works via the pulseaudio compat with pipewire (started above)
    pasystray &

    # start syncthing minimized to tray
    syncthing-gtk -m &

fi

exec xmonad
