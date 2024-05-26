#!/bin/sh

doas xbps-install -S > /dev/null
xbps-install -Sun > /tmp/void_updates.txt
