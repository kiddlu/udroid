## Ubuntu on Android

1. first, you need adb root.

2. download ubuntu cloud image base on armhf/arm64

TODO


there are 3 ways to run gnu binary elf on android

1. use `mount -o bind && chroot` to create a new root evn for ubuntu arm

2. use `mount -o remount,rw / && ln -s` to create env for ubuntu arm share wich android root

3. use `wrapper scripts` for android shell to run ubuntu binary 
