#!/system/bin/sh

DIRS="
/system/app/
/system/bin/
/system/lib/
/system/lib64/
/system/framework/
/system/priv-app/
"

for dir in $DIRS; do
    echo "\n$dir: "
    vmtouch -v $dir 2>&1 | grep -v "vmtouch: WARNING: not following symbolic link"
done
