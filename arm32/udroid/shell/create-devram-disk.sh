#!/bin/bash

set -x

#CONFIG_BLK_DEV_INITRD=y
#CONFIG_RD_GZIP=y

#CONFIG_BLK_DEV_RAM=y
#CONFIG_BLK_DEV_RAM_COUNT=16
#CONFIG_BLK_DEV_RAM_SIZE=4096

mknod -m 0777 /dev/ram0 b 1 0

#dd if=/dev/zero of=floppy.img bs=512Mb count=1
#losetup /dev/loop1 floppy.img
