#!/bin/sh

XPOS="3240"
WIDTH="600"
YPOS="19"
LINES="49"

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'


NUM=$(cat /tmp/updates.txt | wc -l)

PKG=$(cat /tmp/updates.txt)


(echo "??"; echo "^fg()Updates available:\n $PKG"; sleep 15) | dzen2 -w $WIDTH -x $XPOS -y $YPOS -l $LINES -e $DZEN_EVENT 