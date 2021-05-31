#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | nezd -x 1180 -w 700 -h '2%' -ta r -fn "xft:Hack:size=10:antialias=true" -title-name dzenstatus -bg "#000000" -dock
