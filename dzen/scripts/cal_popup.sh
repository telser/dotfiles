#!/bin/sh

LINES="8"

DZEN_EVENT='onstart=uncollapse,hide;button1=collapse;button3=collapse'

cal=$(cal -h)

(echo "??"; echo " ^fg()$cal"; sleep 5) | nezd -w 25% -x 75% -y 18 -ta l -l 9% -e $DZEN_EVENT -fn xft:Hack:size=10:antialias=true
