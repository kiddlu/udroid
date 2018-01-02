#!/bin/bash

set -x

TPREFIX=/data/data/com.termux/files/usr
LDD=ldd-aarch64

mkdir -p ./bin
mkdir -p ./lib

function bincp()
{
cp $(readlink -f $TPREFIX/bin/$1) ./bin/$1
for libs in `$LDD $TPREFIX/bin/$1 |awk '{print $1}' `; do
    cp $(readlink -f $TPREFIX/lib/$libs) ./lib/$libs 
done
}

function libcp()
{
    cp $(readlink -f $TPREFIX/lib/$1) ./lib/$1
}

bincp ltrace
bincp strace
bincp objdump

libcp libandroid-support.so
libcp libbz2.so.1.0
libcp liblzma.so
