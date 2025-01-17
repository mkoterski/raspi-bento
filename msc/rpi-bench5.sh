#!/bin/bash

[ "$(whoami)" == "root" ] || { echo "Must be run as sudo!"; exit 1; }

# Install dependencies
if [ ! `which hdparm` ]; then
  apt-get install -y hdparm
fi
if [ ! `which sysbench` ]; then
  apt-get install -y sysbench
fi
if [ ! `which speedtest-cli` ]; then
  apt-get install -y speedtest-cli
fi

# Check for command-line argument to omit Internet speed test
run_speedtest="y"
if [ "$1" == "--no-speedtest" ]; then
  run_speedtest="n"
fi

# Script start!
# Show simple system information
clear
sync
model_info=$(cat /proc/device-tree/model | tr -d '\0')
os_info=$(lsb_release -d | cut -f2)
echo "Raspi Bento - Version 3.02"
echo "$(hostname) | $os_info | $(uname -m) | $model_info"
echo "$(date +%Y-%m-%d - %H:%M)"

# Show current hardware
vcgencmd measure_temp
vcgencmd get_config int | grep arm_freq
vcgencmd get_config int | grep core_freq
vcgencmd get_config int | grep sdram_freq
vcgencmd get_config int | grep gpu_freq
printf "sd_clock="
grep "actual clock" /sys/kernel/debug/mmc0/ios 2>/dev/null | awk '{printf("%0.3f MHz", $3/1000000)}'
echo

# Run Internet speed test if not omitted
if [ "$run_speedtest" == "y" ]; then
  echo "Running InternetSpeed test..."
  speedtest-cli --simple
else
  echo "Skipping InternetSpeed test..."
fi

echo "Running CPU test..."
sysbench cpu --cpu-max-prime=5000 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp

echo "Running THREADS test..."
sysbench threads --thread-yields=4000 --thread-locks=6 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp

echo "Running MEMORY test..."
sysbench memory --memory-block-size=1K --memory-total-size=3G --memory-access-mode=seq --threads=4 run | grep 'Operations\|transferred\|total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp

echo "Running HDPARM test..."
hdparm -t /dev/mmcblk0 | grep Timing
vcgencmd measure_temp

echo "Running DD WRITE test..."
rm -f ~/test.tmp && sync && dd if=/dev/zero of=~/test.tmp bs=1M count=512 conv=fsync 2>&1 | grep -v records
vcgencmd measure_temp

echo "Running DD READ test..."
echo 3 > /proc/sys/vm/drop_caches && sync && dd if=~/test.tmp of=/dev/null bs=1M 2>&1 | grep -v records
vcgencmd measure_temp
rm -f ~/test.tmp

echo "Raspi Bento is done!🍱"