#!/bin/bash

set -x

usage() {
cat <<USAGE

Usage: setcharging value 

USAGE
}

echo $1 > /sys/class/leds/lcd-backlight/brightness
