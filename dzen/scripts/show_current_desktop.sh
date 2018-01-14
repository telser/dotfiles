#!/bin/sh

wmctrl -d | grep \* | cut -d ' ' -f 12,13 -s | awk '{$1=$1;print}'
