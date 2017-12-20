#!/bin/bash
#find by name

SYS=""
case `uname` in
    Linux) SYS=linux ;;
    FreeBSD) SYS=fbsd ;;
    *CYGWIN*) SYS=cygwin ;;
    *MINGW*) SYS=mingw ;;
    Darwin) SYS=darwin ;;
esac

if [ "$SYS" == "cygwin" ]; then
    find . -name "*$1*"
elif [ "$SYS" == "darwin" ]; then
    find . -name "*$1*"
elif [ "$SYS" == "linux" ]; then
    find . -name "*$1*"
else
    echo "Can not regonize your system"
fi
