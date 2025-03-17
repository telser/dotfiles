#!/bin/sh

set -o xtrace

cd /home/trevis/void-packages
git pull
doas xi -S > /dev/null
doas xi -un > /tmp/void_updates.txt
