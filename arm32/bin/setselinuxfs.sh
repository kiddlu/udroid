#!/bin/bash

usage() {
cat <<USAGE

Usage: setselinuxfs rw/ro

USAGE
}

case $1 in
rw) mount -o remount,rw /sys/fs/selinux;;
ro) mount -o remount,rw /sys/fs/selinux;;
*） exec echo "$usage";; 
esac
