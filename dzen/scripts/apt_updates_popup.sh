#!/bin/sh

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'

SCREEN_X_Y=$(xrandr |grep primary| cut -d' ' -f4| cut -d'+' -f1)

SCREEN_WIDTH=$(echo "$SCREEN_X_Y" | cut -d'x' -f1)

SCREEN_HEIGHT=$(echo "$SCREEN_X_Y" | cut -d'x' -f2)

# 20% of screen width
WIDTH=$(($(echo "$SCREEN_WIDTH"|cut -c1-3) * 2))

XPOS=$((SCREEN_WIDTH - WIDTH))

PKG=$(cat /tmp/updates.txt)

NUM=$(echo "$PKG" | wc -l)

(echo "??"; echo "^fg()Updates available:\n $PKG"; sleep 15) | dzen2 -w "$WIDTH" -x "$XPOS" -y "$SCREEN_HEIGHT" -l "$NUM" -e $DZEN_EVENT
