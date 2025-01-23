#!/bin/bash

# Check if script is run as root
[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

# Function to display the menu
display_menu() {
  clear
  local model_info=$(cat /proc/device-tree/model | tr -d '\0')
  local os_info=$(lsb_release -d | awk -F: '{print $2}' | xargs)
  local hostname=$(hostname)
  local arch=$(uname -m)
  local datetime=$(date +"%Y-%m-%d - %H:%M")

  printf "\e[1;34mRaspi Bento - v0.04%*s\n" $(( $(tput cols) - 28 )) "$datetime"
  printf "\e[1;34m%s | %s | %s%*s\e[0m\n" "$hostname" "$os_info" "$arch" $(( $(tput cols) - ${#hostname} - ${#os_info} - ${#arch} - 4 )) "$model_info"
  echo

  printf "\e[1;33m1 - Internet Test\e[0m\n"
  printf "\e[1;32m%24s%28s\n" "Internet" "Local network"
  printf "\e[1;32m%-25s%-25s\n" "Ping: 28.975 ms" "Connection(s): eth0, wlan0"
  printf "\e[1;32m%-25s%-25s\n" "Download: 47.86 Mbit/s" "Local IP: 192.168.1.132"
  printf "\e[1;32m%-25s%-25s\n" "Upload: 52.54 Mbit/s" "Public IP: 80.12.34.88"
  echo

  printf "\e[1;33m2 - CPU Test\e[0m\n"
  printf "\e[1;32m%-15s%-15s%-15s\n" "CPU" "Threads" "Memory"
  printf "%-30s %-20s %-20s %-20s\n" "2 - CPU Test" "CPU" "Threads" "Memory"
  printf "%-30s %-20s %-20s %-20s\n" "2 - CPU Test" "CPU" "Threads" "Memory"
  printf "\e[1;32m%-15s%-15s%-15s\n" "time: 10.0014s" "time: 10.0133s" "time: 1.4694s"
  printf "\e[1;32m%-15s%-15s%-15s\n" "min: 1.39" "min: 54.33" "min: 0.00"
  printf "\e[1;32m%-15s%-15s%-15s\n" "avg: 1.41" "avg: 54.75" "avg: 0.00"
  printf "\e[1;32m%-15s%-15s%-15s\n" "max: 2.02" "max: 56.02" "max: 0.34"
  printf "\e[1;32m%-45s\n" "3072.00 MiB transferred (2070.30 MiB/sec)"
  echo

  printf "\e[1;33m3 - SD Card Test\e[0m\n"
  printf "\e[1;32m%-45s\n" "68 MB in 3.03 seconds = 22.44 MB/sec"
  printf "\e[1;32m%-25s%-25s\n" "DD WRITE test" "DD READ test"
  printf "\e[1;32m%-25s%-25s\n" "537 MB / 512 MiB copied," "537 MB / 512 MiB copied,"
  printf "\e[1;32m%-25s%-25s\n" "52.8301 s, 10.2 MB/s" "22.9001 s, 23.4 MB/s"
}

# Display the menu
display_menu