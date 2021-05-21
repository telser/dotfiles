#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | nezd -x 55% -w 45% -h 70 -ta r -fn "xft:Hack:size=12:antialias=true" -title-name nezdstatus -bg "#000000" -dock
