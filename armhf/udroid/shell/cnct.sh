#!/bin/bash

WORK=user5@10.150.20.15
ROUTE=root@10.0.0.1
PHONE=root@192.168.0.3
ADBADDR=root@localhost
#ADBPORT=$(python -c "print (((22 + 19880307) * 1989 - 0603) % 20160103 % 1314 + 18000)")
ADBPORT=18553

echo "connect to $1"
case "$1" in  
	work) ssh $WORK -p 22 -o ForwardX11Trusted=yes -o ForwardX11=yes -C -o Compression=yes;;
	route) ssh $ROUTE -p 22 -o ForwardX11Trusted=yes -o ForwardX11=yes -C -o Compression=yes;;
	phone) ssh $PHONE -p 22 -o ForwardX11Trusted=yes -o ForwardX11=yes -C -o Compression=yes;;
	adb) shift;adb $@ forward tcp:$ADBPORT tcp:22;ssh $ADBADDR -p $ADBPORT -o ForwardX11Trusted=yes -o ForwardX11=yes -C -o Compression=yes;;
	*) echo "no target for $1" >&2;;
esac
