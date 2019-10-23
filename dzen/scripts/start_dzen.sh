#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | dzen2 -x 1195 -w 2560 -h 75 -ta r -fn "xft:Hack:size=14:antialias=true" -title-name dzenstatus -bg "#000000"
