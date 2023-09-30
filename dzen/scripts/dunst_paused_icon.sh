#!/bin/sh

IS_PAUSED=$(dunstctl is-paused)

if [ "$IS_PAUSED" = 'false' ]; then
    echo "$HOME/dzen/icons/play50.xpm"
else
   echo "$HOME/dzen/icons/pause50.xpm"
fi
