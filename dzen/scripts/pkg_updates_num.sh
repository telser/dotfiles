#!/bin/sh

cat /tmp/updates.txt | wc -l | cut -wf2
