#!/system/bin/sh

for file in `showmap $@ | awk '{print $10}' | grep ^/system/`; do
echo $file

vmtouch $file
done
