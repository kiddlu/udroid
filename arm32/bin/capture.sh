#!/bin/bash

set -x

function capture_func()
{
    #/proc
    for index in bootprof buddyinfo cgroups cmdline config.gz cpuinfo devices diskstats \
                 filesystems interrupts iomem ioports kallsyms last_kmsg latency_stats loadavg \
    			 lockdep lockdep_chains lockdep_stats locks meminfo misc mounts \
    			 pagetypeinfo partitions schedstat sched_debug softirqs stat swaps tasks_all tasks_rq \
    			 timer_list uptime version vmallocinfo vmstat zoneinfo zraminfo; do
        cat /proc/$index > !proc!$index &
    done
    
    
    #sys
    cat /sys/kernel/debug/blockio > !sys!kernel!debug!blockio
    cat /sys/kernel/debug/tracing/trace > !sys!kernel!debug!tracing!ftrace
    cat /sys/kernel/debug/wakeup_sources > !sys!kernel!debug!wakeup_sources
    cat /sys/kernel/debug/shrinker > !sys!kernel!debug!shrinker

    #tools
    /bin/dmesg > !bin!dmesg
    /sbin/ifconfig > !sbin!ifconfig
    /bin/ps -auxww > !bin!ps@-auxww
    pidstat -l > tools_pidstat-l
    iostat > tools_iostat
    top -bc -n1 > tools_top-bcn1
    vmstat -d > tools_vmstat-d
    vmstat -D > tools_vmstat-D
    vmstat -w > tools_vmstat-w
    /bin/df -h > !bin!df@-h
    /usr/local/android/bin/procrank > !usr!local!android!bin!procrank

    /system/bin/getprop > !system!bin!getprop
    /system/bin/lsof > !system!bin!_lsof
    /system/bin/dumpsys > !system!bin!_dumpsys
    /system/bin/ps -P -p -c > !system!bin!ps@-P@-p@-c
    /system/bin/logcat -d > !system!bin!logcat@-d
}

capture_func 2>&1 | tee capture_log
