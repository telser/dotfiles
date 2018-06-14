#!/bin/sh
apt list --upgradable | cut -d'/' -f1 | tail -n +2 > /tmp/updates.txt
