#!/bin/sh

acpi -b | cut -d ' ' -f4 | cut -d ',' -f1
