#!/bin/bash

#set -x

for links in $(ls -1 arm-linux-*); do
    echo $links
    echo $(echo $links | sed 's/arm-linux-//g')
    ln -sf $links $(echo $links | sed 's/arm-linux-//g')
done
