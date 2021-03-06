#!/bin/sh

XPOS="3240"
WIDTH="600"
YPOS="19"
LINES="49"

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'


NUM=$(wc -l /tmp/updates.txt | cut -wf2)
NUM=$((NUM + 1))

PKG=$(cat /tmp/updates.txt)


(echo "??"; printf "^fg()Updates available:\n"; echo "$PKG"; sleep 15) | dzen2 -w $WIDTH -x $XPOS -y $YPOS -l "$NUM" -e $DZEN_EVENT
