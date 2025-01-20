#!/bin/bash

[ "$(whoami)" == "root" ] || { echo "Raspi Bento must be run as sudo!"; exit 1; }

# Install sysbench dependency
if [ ! `which sysbench` ]; then
  apt-get install -y sysbench
fi

# Check for NVMe drive
nvme_drive=$(lsblk -d -n -o NAME,TYPE | grep nvme | awk '{print $1}')

if [ -n "$nvme_drive" ]; then
  # Install fio if NVMe drive is detected
  if [ ! `which fio` ]; then
    apt-get install -y fio
  fi

  echo -e "NVMe drive detected: $nvme_drive"
  echo -e "Running FIO tests on NVMe drive...\e[94m"

  # FIO WRITE test
  fio --name=write_test --filename=/dev/$nvme_drive --size=1G --time_based --runtime=60 --rw=write --bs=1M --ioengine=libaio --direct=1 --numjobs=1 --group_reporting
  echo -e "\e[93m"

  # FIO READ test
  fio --name=read_test --filename=/dev/$nvme_drive --size=1G --time_based --runtime=60 --rw=read --bs=1M --ioengine=libaio --direct=1 --numjobs=1 --group_reporting
  echo -e "\e[93m"
else
  # Install hdparm if no NVMe drive is detected
  if [ ! `which hdparm` ]; then
    apt-get install -y hdparm
  fi

  echo -e "No NVMe drive detected. Running tests on SD card...\e[94m"

  # SD card tests
  echo -e "Running HDPARM test...\e[94m"
  hdparm -t /dev/mmcblk0 | grep Timing
  echo -e "\e[93m"

  echo -e "Running DD WRITE test...\e[94m"
  rm -f ~/test.tmp && sync && dd if=/dev/zero of=~/test.tmp bs=1M count=512 conv=fsync 2>&1 | grep -v records
  echo -e "\e[93m"

  echo -e "Running DD READ test...\e[94m"
  echo 3 > /proc/sys/vm/drop_caches && sync && dd if=~/test.tmp of=/dev/null bs=1M 2>&1 | grep -v records
  rm -f ~/test.tmp
  echo -e "\e[0m"
fi