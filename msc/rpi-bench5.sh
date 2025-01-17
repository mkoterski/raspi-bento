#!/bin/bash

# R A S P I   B E N T O
# 
# This script serves up a variety of benchmark tests without any fuss.
# Version 3.02
# Author: Matthias Koterski
# Based on AikonCWD's Raspberry Pi Benchmark Test
#
# Backlog:
# - add more tests and make them more demanding for newer hardware
# - add more options (e.g. report export)
# - add more colors and overwork UI
# - syntax updates
# - support more devices
# 
# 3.02 Updates:
# - modified initial information displayed
# - add prompt for internet speed test - doesn't work yet and gets skipped
# 
# 3.01 Updates:
# - updated deprecated sysbench syntax
#

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

# Check for command-line argument to manually run Internet speed test
run_speedtest="y"
if [ "$1" == "--speedtest" ]; then
  run_speedtest="n"
fi

# Script start!
# Show simple system information
clear
sync
model_info=$(cat /proc/device-tree/model | tr -d '\0')
os_info=$(lsb_release -d | cut -f2)
echo -e "\e[92mRaspi Bento - Version 3.02\e[97m"
echo -e "$(hostname) | $os_info | $(uname -m) | $model_info"
echo "$(date +%Y%m%d-%H:%M)"
echo -e "\e[97m"

# Show current hardware
vcgencmd measure_temp
vcgencmd get_config int | grep arm_freq
vcgencmd get_config int | grep core_freq
vcgencmd get_config int | grep sdram_freq
vcgencmd get_config int | grep gpu_freq
printf "sd_clock="
grep "actual clock" /sys/kernel/debug/mmc0/ios 2>/dev/null | awk '{printf("%0.3f MHz", $3/1000000)}'
echo -e "\n\e[93m"

# Run Internet speed test if specified
if [ "$run_speedtest" == "y" ]; then
  echo -e "Running InternetSpeed test...\e[94m"
  speedtest-cli --simple
  echo -e "\e[93m"
else
  echo -e "Skipping InternetSpeed test...\e[93m"
fi

echo -e "Running CPU test...\e[94m"
sysbench cpu --cpu-max-prime=5000 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp
echo -e "\e[93m"

echo -e "Running THREADS test...\e[94m"
sysbench threads --thread-yields=4000 --thread-locks=6 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp
echo -e "\e[93m"

echo -e "Running MEMORY test...\e[94m"
sysbench memory --memory-block-size=1K --memory-total-size=3G --memory-access-mode=seq --threads=4 run | grep 'Operations\|transferred\|total time:\|min:\|avg:\|max:' | tr -s [:space:]
vcgencmd measure_temp
echo -e "\e[93m"

echo -e "Running HDPARM test...\e[94m"
hdparm -t /dev/mmcblk0 | grep Timing
vcgencmd measure_temp
echo -e "\e[93m"

echo -e "Running DD WRITE test...\e[94m"
rm -f ~/test.tmp && sync && dd if=/dev/zero of=~/test.tmp bs=1M count=512 conv=fsync 2>&1 | grep -v records
vcgencmd measure_temp
echo -e "\e[93m"

echo -e "Running DD READ test...\e[94m"
echo -e 3 > /proc/sys/vm/drop_caches && sync && dd if=~/test.tmp of=/dev/null bs=1M 2>&1 | grep -v records
vcgencmd measure_temp
rm -f ~/test.tmp
echo -e "\e[0m"

echo -e "\e[91mRaspi Bento is done!🍱\e[0m\n"