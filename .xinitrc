#!/bin/sh
#

NAME=$( uname "-n")

#. /etc/X11/xinit/xinitrc.d/*

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

## test for an existing bus daemon, just to be safe
#if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    ## if not found, launch a new one
 #   eval `dbus-launch --sh-syntax --exit-with-session`
  #  echo "D-Bus per-session daemon address is: 
#$DBUS_SESSION_BUS_ADDRESS"
#fi

if [ "$NAME" == "charmy" ];               
then
  mkdir /tmp/paconky
  blueman-applet &                        # Setup wireless services
  wicd-gtk &
  rfkill block 0
  xbacklight -set 60                      # Dim laptop screen --saves battery life
  udiskie &
  conky -c .conkyLeftrc &
  conky -c .conkyRightrc &
else                                      
  synergys -c ~/.synergyS # Start Synergy Server
fi

xset b off

xrdb -merge ~/.Xresources

xmodmap ~/.Xmodmap

trayer --edge top --align left --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --alpha 0 --tint 0x303030 --height 19 --padding 15& 

thunar --daemon &

urxvtd -q -o -f &

~/./wallpaper.sh &

conky -c .conkyLeftrc &
conky -c .conkyRightrc &

xsetroot -cursor_name left_ptr
xmonad
