#!/bin/sh
XPOS=3540
WIDTH="350"
YPOS="16"
LINES="2"

battime=$(acpi -b | sed -n "1p" | awk -F " " '{print $5}')
batperc=$(acpi -b | sed -n "1p" | awk -F " " '{print $4}' | head -c3)
batstatus=$(acpi -b | cut -d',' -f1 | awk -F " " '{print $3}')

(echo " Battery"; echo " ^fg()$batstatus"; echo " $battime ^fg()left"; sleep 5) | dzen2 -w $WIDTH -x $XPOS -y $YPOS -l $LINES -e 'onstart=uncollapse,hide;button1=exit;button3=exit'
