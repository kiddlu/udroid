#!/bin/bash

#set -x

sum=0
for vmem in $(cat /proc/vmallocinfo | awk '{print $2}'); do
  let sum=$sum+$vmem
  #sum=$(python -c  "print $sum+$vmem") 
done

let sum=$sum/1024

echo "vmalloc use $sum kB"
