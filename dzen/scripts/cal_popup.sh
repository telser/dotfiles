#!/bin/sh
XPOS=3440
WIDTH="400"
YPOS="16"
LINES="7"

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'

cal=$(cal)

(echo " ^fg()$cal"; sleep 5) | dzen2 -w $WIDTH -x $XPOS -y $YPOS -l $LINES -e $DZEN_EVENT -fn xft:Hack:size=12:antialias=true
