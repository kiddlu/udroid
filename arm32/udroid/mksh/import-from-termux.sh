#!/bin/bash

set -x

TPREFIX=/data/data/com.termux/files/usr
mkdir -p ./bin
mkdir -p ./lib

function bincp()
{
cp $(readlink -f $TPREFIX/bin/$1) ./bin/$1
for libs in `objdump -p $TPREFIX/bin/$1 | grep NEED | awk '{print $2}' `; do
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
