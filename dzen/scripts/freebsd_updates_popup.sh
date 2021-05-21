#!/bin/sh

XPOS="3240"
WIDTH="600"
YPOS="19"
LINES="49"

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'


NUM=$(wc -l /tmp/base_updates.txt | cut -wf2)
NUM=$((NUM + 1))

PKG=$(cat /tmp/base_updates.txt)


(echo "??"; printf "^fg()Updates available:\n"; echo "$PKG"; sleep 15) | nezd -w 45% -x 55% -y $YPOS -l "$NUM" -e $DZEN_EVENT
