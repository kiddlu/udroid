#!/bin/bash

#set -x

function dcp()
{
    BIN_PATH=`which $1`

    file $BIN_PATH | grep ELF > /dev/null

    if [ "$?" = "0" ]; then
        cp -rf `readlink -f $BIN_PATH` ./bin/`basename $BIN_PATH`
        for lib in `/lib/ld-linux-armhf.so.3 --list $BIN_PATH | sed -r 's/.*(=> )/\1/g' | sed -r 's/=> //g' | sed -r 's/(\(0x.*)//g' | awk '{print $1}'`; do
            cp -rf `readlink -f $lib` ./lib/`basename $lib`
        done
    fi
}

function genexe()
{
cat <<EOF  > $(basename $1)
#!/system/bin/sh

#BUSYBOXPATH=/system/bin/busybox
BUSYBOXPATH=

CURDIR=\$(\$BUSYBOXPATH dirname \$(\$BUSYBOXPATH readlink -f \$0))

\$CURDIR/lib/ld-linux-armhf.so.3 \
--library-path \$CURDIR/lib \
\$CURDIR/bin/\$(basename \$0) \
\$@
EOF

}


if [ ! -e ./bin ]; then
     mkdir ./bin
fi
if [ ! -e ./lib ]; then
    mkdir ./lib
fi

dcp $1
genexe $1
