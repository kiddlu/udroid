#!/bin/bash

set -x

mkdir -p /run/resolvconf/

connectedVPN=`getprop sys.net.connectedVPN`

if [[ -z "$connectedVPN" ]]; then
  nameserver=`getprop net.dns1`
  echo nameserver $nameserver > /run/resolvconf/resolv.conf
  echo nameserver 223.5.5.5  >> /run/resolvconf/resolv.conf
  echo nameserver 223.6.6.6  >> /run/resolvconf/resolv.conf
else
  nameserver=`getprop net.dns1`
  echo nameserver $nameserver > /run/resolvconf/resolv.conf
  echo nameserver 8.8.8.8    >> /run/resolvconf/resolv.conf
  echo nameserver 8.8.4.4    >> /run/resolvconf/resolv.conf
fi 
