#!/bin/bash

cat /sys/class/power_supply/battery/charging_enabled | grep 1 > /dev/null

if [[ $? -eq 0 ]] ; then
    echo "charging on"
else
    echo "charging off"
fi
