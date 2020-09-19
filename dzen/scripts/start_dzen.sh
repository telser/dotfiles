#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | dzen2 -x 1380 -w 1000 -h 70 -ta r -fn "xft:Hack:size=14:antialias=true" -title-name dzenstatus -bg "#000000" -dock
