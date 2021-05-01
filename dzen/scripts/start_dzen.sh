#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | dzen2 -x 880 -w 700 -h 70 -ta r -fn "xft:Hack:size=14:antialias=true" -title-name dzenstatus -bg "#000000" -dock
