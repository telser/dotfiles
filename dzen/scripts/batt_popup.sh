#!/bin/sh

HOST=`hostname`
if [ "$HOST" = 'zero-void' ] ; then
  . $(dirname $0)/../host-settings/zero.sh
fi
XPOS=1340
LINES="2"
FONT='xft:Hack:size=12:antialias=true'
POPUP_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'
POPUP_W="600"
POPUP_Y="36"

BATT_W="275"


battime=$(acpi -b | sed -n "1p" | awk -F " " '{print $5}')
batstatus=$(acpi -b | cut -d',' -f1 | awk -F " " '{print $3}')

POPUP_DZEN="dzen2 -w $BATT_W -x $XPOS -y $POPUP_Y -l $LINES -e $POPUP_EVENT -fn $FONT"
(echo " "; echo " ^fg()$batstatus"; echo " $battime ^fg()left"; sleep 5) | $POPUP_DZEN
