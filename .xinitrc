NAME=$( uname "-n")

#. /etc/X11/xinit/xinitrc.d/*

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

if [ "$NAME" == "charmy" ];
then
  tint2 -c tint2.conf &                   # Topbar and systray
  conky -c .conkyLeftrc &                 # Status
  conky -c .conkyRightrc &
  clipit &                                # Clipboard manager
  nitrogen --restore &                    # Set wallpaper
  gtmixer &
fi
if [ "$NAME" == "tails" ];
then
  tint2 -c tint2.conf &                   # Topbar and systray
  conky -c .conkyLeftrc &                 # Status
  conky -c .conkyRightrc &
  clipit &                                # Clipboard manager
  nitrogen --restore &                    # Set wallpaper
  gtmixer &
fi
if ["$NAME" == "shadow"];
then
  wicd-gtk &                              # Wireless
  conky -c .conkyLeftrc &
  conky -c .conkyRightrc &
fi

## Devel fbsd box
if [ "$NAME" == "double" ]; then
    conky -c .conkyLeftrc &
    conky -c .conkyRightrc &
    clipit &
    nitrogen --restore &
    xset fp+ /usr/local/share/fonts/urwfonts
    xset fp rehash
fi

# Set the locale before launching urxvt and xmonad to prevent character funkiness
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MM_CHARSET=UTF-8

xset b off &                             # Turn off term bell

xrdb -merge ~/.Xresources                # Set term font/color

xmodmap ~/.Xmodmap                       # Rebind keys

urxvtcd -q -o -f &                        # Start terminal daemon

xsetroot -cursor_name left_ptr
xmonad
