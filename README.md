## 如何在Android环境下运行Ubuntu

为什么使用arm-linux-***-gcc交叉编译的程序，不能直接在android手机下运行？必须静态编译才可以？

例子：hello.c
```
#include <stdio.h>

int main()
{
    printf("Hello World!!\n");
    return 0;
}
```


ubuntu arm下编译:

```
root at localhost in /data/repo/hello
$ gcc hello.c -o hello

root at localhost in /data/repo/hello
$ ldd hello
        libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xf6f62000)
        /lib/ld-linux-armhf.so.3 (0xaae03000)

root at localhost in /data/repo/hello
$ gcc hello.c -o hello-static  -static

root at localhost in /data/repo/hello
$ ldd hello-static
        not a dynamic executable
```

android下运行：

```
root@colombo:/data/local/tmp # ./hello
/system/bin/sh: ./hello: No such file or directory

root@colombo:/data/local/tmp # ./hello-static
Hello World!!
```

然后我们回到ubuntu arm，查看一下hello这个elf的头部和一个android程序的elf的头部

```
root at localhost in /data/repo/hello
$ readelf -l hello

Elf file type is EXEC (Executable file)
Entry point 0x10319
There are 9 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  EXIDX          0x00046c 0x0001046c 0x0001046c 0x00008 0x00008 R   0x4
  PHDR           0x000034 0x00010034 0x00010034 0x00120 0x00120 R E 0x4
  INTERP         0x000154 0x00010154 0x00010154 0x00019 0x00019 R   0x1
      [Requesting program interpreter: /lib/ld-linux-armhf.so.3]
  LOAD           0x000000 0x00010000 0x00010000 0x00478 0x00478 R E 0x10000
  LOAD           0x000f0c 0x00020f0c 0x00020f0c 0x0011c 0x00120 RW  0x10000
  DYNAMIC        0x000f18 0x00020f18 0x00020f18 0x000e8 0x000e8 RW  0x4
  NOTE           0x000170 0x00010170 0x00010170 0x00044 0x00044 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10
  GNU_RELRO      0x000f0c 0x00020f0c 0x00020f0c 0x000f4 0x000f4 R   0x1



# /system/bin/app_process32是一个android exe
$ readelf -l /system/bin/app_process32

Elf file type is DYN (Shared object file)
Entry point 0x1808
There are 9 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x00000034 0x00000034 0x00120 0x00120 R   0x4
  INTERP         0x000154 0x00000154 0x00000154 0x00013 0x00013 R   0x1
      [Requesting program interpreter: /system/bin/linker]
  LOAD           0x000000 0x00000000 0x00000000 0x04578 0x04578 R E 0x1000
  LOAD           0x004cd8 0x00005cd8 0x00005cd8 0x00328 0x00951 RW  0x1000
  DYNAMIC        0x004d88 0x00005d88 0x00005d88 0x00148 0x00148 RW  0x4
  NOTE           0x000168 0x00000168 0x00000168 0x00038 0x00038 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0
  EXIDX          0x003878 0x00003878 0x00003878 0x001d8 0x001d8 R   0x4
  GNU_RELRO      0x004cd8 0x00005cd8 0x00005cd8 0x00328 0x00328 RW  0x8
```

可以看出ubuntu程序和android程序的program interpreter是不一样的。

由于两者的连接器存在区别，android环境默认情况下并没有`/lib/ld-linux-armhf.so.3`这个链接器，导致hello程序运行失败。



那么，有几种方式能让ubuntu程序在android环境下运行？我目前现在发现的有五种

### 1.静态编译

这样程序就可以不依赖链接器(ld or linker)，成为一个独立跑在linux内核上的程序。
这样的缺点是，不能使用dlopen()等依赖linker完成的系统调用，需要全部重新编译依赖库和程序。工作量太大，只适合一些简单小工具小程序的临时分发。

```
gcc hello.c -o hello-static  -static
```

### 2.wrapper

使用一个wrapper脚本，让gnu-ld搜索指定的动态库路径，用来加载程序。
这样的缺点是，需要重新封装大量的程序，而且部分程序在wrapper脚本下存在问题，工作量同样不小，还需要解决部分动态库软链接的问题。

```
$ cat strace-aarch64
#!/bin/bash

CURDIR=`dirname \`readlink -f $0\``

$CURDIR/lib64/ld-linux-aarch64.so.1 \
--library-path $CURDIR/lib64 \
$CURDIR/bin64/strace \
$@
```



### 3.skeleton

ubuntu程序运行的条件，rootfs满足[Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)，它才是一个GNU/Linux系统，
android不是。
这就是需要重新remount rootfs，将android的目录架构建成和FHS一致。
能解决大部分问题，但是缺点是会对android系统造成各种影响，比如selinux的分区需要从rw编程ro，否则apt install会失败，还有就是休眠，系统休眠失败，不推荐这种方式。

```
mount -o remount,rw /

rm /bin
rm /etc
rm /lib
rm -rf /root
rm /run
rm -rf /sbin
rm /srv
rm /tmp
rm /usr
rm /var

ln -sf /data/ubuntu/bin /bin
ln -sf /data/ubuntu/etc /etc
ln -sf /data/ubuntu/lib /lib
ln -sf /data/ubuntu/root /root
ln -sf /data/ubuntu/run /run
ln -sf /data/ubuntu/sbin /sbin
ln -sf /data/ubuntu/srv /srv
ln -sf /data/ubuntu/tmp /tmp
ln -sf /data/ubuntu/usr /usr
ln -sf /data/ubuntu/var /var

HOME=/data/ubuntu/root /data/ubuntu/bin/bash
```



### 4.chroot 

把某个子目录重新当作程序的根目录，欺骗程序路径。
这个的优点是，在一个类似容器的环境中也运行，不影响android进系统。
缺点是需要root权限，部分android程序缺少环境变量或者目录结构导致在chroot中运行失败，但是目前都有比较好的方式walkaround，是推荐的方式。

```
mount -o bind /proc /data/ubuntu/proc
mount -o bind /sys /data/ubuntu/sys
mount -t debugfs none /sys/kernel/debug
mount -o bind /sys/kernel/debug /data/ubuntu/sys/kernel/debug
mount -o remount,ro,bind /sys/fs/selinux /data/ubuntu/sys/fs/selinux
mount -o bind /dev /data/ubuntu/dev
mount -o bind /dev/pts /data/ubuntu/dev/pts

mkdir -p /dev/block/udroid/data
mkdir -p /dev/block/udroid/system
mkdir -p /dev/block/udroid/sdcard
mount -o bind /data   /dev/block/udroid/data
mount -o bind /system /dev/block/udroid/system
mount -o bind /sdcard /dev/block/udroid/sdcard


chroot /data/ubuntu/ /usr/bin/env HOME=/root /bin/bash
```



### 5.proot

使用ptrace()这个系统调用做钩子，伪造一个类似chroot的环境。
优点是不需要root权限，缺点是不能查看系统级别的信息，而且部分程序需要移植工作，[termux](https://termux.com/)使用的就是这种方式。


udroid使用的方式就是chroot方式，为ubuntu arm创建一个类似于容器的环境，在这个环境下运行。请确保adb是以root权限运行的，并且selinux处于关闭状态。当然确保硬件平台一致，Android是ARM手机的就下载Ubuntu ARM版本，Android是X86平板的就下载Ubuntu X86版本。
