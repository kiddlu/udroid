#!/system/bin/sh

du -s -h \
    /data/dalvik-cache \
    /data/data \
    /data/user \
    /data/media \
    /data/app \
    /data/app-lib \
    /data/system \
    /data/misc

echo ""

du -s -h \
    /data/core \
    /data/anr \
    /data/tombstones \
    /data/local \

echo ""

du -s -h \
    /data/repo \
    /data/ubuntu 
