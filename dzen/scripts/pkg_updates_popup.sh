#!/bin/sh

XPOS="3240"
WIDTH="600"
YPOS="19"
LINES="49"

DZEN_EVENT='onstart=uncollapse,hide;button1=collapse;button3=collapse'


NUM=$(wc -l /tmp/updates.txt | cut -wf2)
NUM=$((NUM + 1))

PKG=$(cat /tmp/updates.txt)


(echo "??"; printf "^fg()Updates available:\n"; echo "$PKG"; sleep 15) | nezd -w "5%" -x "95%" -y 34 -sa l -l "$NUM" -e "$DZEN_EVENT" -fn xft:Hack:size=12:antialias=true
