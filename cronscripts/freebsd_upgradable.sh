#!/bin/sh
svnlite st -u /usr/src | tail -r | tail -n +2 > /tmp/base_updates.txt
