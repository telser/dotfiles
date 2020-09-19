#!/bin/sh
pkg version -l '<' | cut -wf1 > /tmp/updates.txt
