#!/bin/sh

XPOS="3240"
WIDTH="600"
YPOS="19"

DZEN_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'
FONT='xft:Hack:size=12:antialias=true'

PKG=$(cat /tmp/pkgsrc_updates.txt)
NUM=$(cat /tmp/pkgsrc_updates.txt | wc -l)
LINES=`expr 1 + $NUM`

if [ $LINES -gt 1 ] ; then
  TXT="^fg()Updates available:\n $PKG"
else
  TXT="Nothing to update right now"
fi

(echo "??"; echo $TXT; sleep 15) | dzen2 -w $WIDTH -x $XPOS -y $YPOS -l $LINES -e $DZEN_EVENT -fn $FONT
