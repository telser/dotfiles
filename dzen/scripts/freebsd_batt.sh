#!/bin/sh

acpiconf -i0 | grep "Remaining capacity" | cut -w -f3
