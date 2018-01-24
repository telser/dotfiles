#!/bin/sh

FONT='xft:Hack:size=12:antialias=true'

PKGSRC=1
VOID=1

VOID_PKG="cat /tmp/void_updates.txt"
VOID_NUM=$($VOID_PKG | wc -l)
PKGSRC_PKG="cat /tmp/pkgsrc_updates.txt"
PKGSRC_NUM=$($PKGSRC_PKG | wc -l)

POPUP_EVENT='onstart=uncollapse,hide;button1=exit;button3=exit'
POPUP_W="600"
POPUP_Y="36"

BATT_W="275"
