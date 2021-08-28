#!/bin/sh

conky -c ~/dzen/dzen_conky.lua | nezd -x '64%' -w '36%' -h '4%' -ta r -fn "xft:Hack:size=12:antialias=true" -title-name dzenstatus -bg "#000000" -dock
