#!/system/bin/sh

PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin

toybox find . -name "*$1*"
