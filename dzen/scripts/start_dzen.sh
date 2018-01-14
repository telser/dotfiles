#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | dzen2 -x 1340 -w 2500 -ta r -fn "xft:Hack:size=16:antialias=true" -title-name dzenstatus
