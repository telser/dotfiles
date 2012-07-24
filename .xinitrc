#!/bin/sh
#

NAME=$( uname "-n")

. /etc/X11/xinit/xinitrc.d/*

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

## test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    ## if not found, launch a new one
    eval `dbus-launch --sh-syntax --exit-with-session`
    echo "D-Bus per-session daemon address is: 
$DBUS_SESSION_BUS_ADDRESS"
fi

xrdb -merge ~/.Xresources

xmodmap ~/.Xmodmap

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x000000 --height 19 & 

thunar --daemon &

urxvtd -q -o -f &

if [ "$NAME" == "charmy" ];               # If on laptop start wireless services
then
  blueman-applet &
  wicd-gtk &
else
  echo "Not on laptop, don't start wireless"
fi

~/./wallpaper.sh &

mkdir /tmp/paconky

conky -c .conkyLeftrc &
conky -c .conkyRightrc &

udiskie &

xsetroot -cursor_name left_ptr
exec ck-launch-session xmonad
