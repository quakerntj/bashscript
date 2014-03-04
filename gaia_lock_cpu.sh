#!/bin/sh
adb shell "echo 0 > /sys/module/cpu_tegra3/parameters/auto_hotplug"
adb shell "echo 0 > /sys/module/cpu_tegra3/parameters/mp_policy"

adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online"

adb shell "echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq"

adb shell "echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq"
adb shell "echo 1000000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq"

adb shell "cat /sys/devices/system/cpu/online"
adb shell "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
adb shell "cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq"
adb shell "cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq"
adb shell "cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq"
