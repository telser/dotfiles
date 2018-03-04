#!/bin/sh

HOST=`hostname`
if [ "$HOST" = 'zero-void' ] ; then
  . $(dirname $0)/../host-settings/zero.sh
fi
XPOS="3240"
LINES=`expr 1 + ${VOID_NUM}`

if [ $LINES -gt 1 ] ; then
  TXT="^fg()Updates available:\n$($VOID_PKG)"
else
  TXT="Nothing to update right now"
fi

POPUP_DZEN="dzen2 -w $POPUP_W -x $XPOS -y $POPUP_Y -l $LINES -e $POPUP_EVENT -fn $FONT"
(echo "??"; echo "$TXT"; sleep 15) | $POPUP_DZEN
