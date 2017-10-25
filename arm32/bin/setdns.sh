#!/bin/bash

set -x

nameserver=`getprop net.dns1`

mkdir -p /run/resolvconf/

echo nameserver $nameserver > /run/resolvconf/resolv.conf
