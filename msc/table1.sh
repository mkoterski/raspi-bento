#!/bin/bash

# Function to get network information
get_network_info() {
  local interface=$1
  local ip=$(ip addr show $interface | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
  echo $ip
}

# Function to get public IP
get_public_ip() {
  curl -s ifconfig.me
}

# Get system information
cpu_name=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | xargs)
cpu_speed=$(lscpu | grep 'CPU MHz' | awk -F: '{print $2}' | xargs)
cpu_cores=$(lscpu | grep '^CPU(s):' | awk -F: '{print $2}' | xargs)
gpu_name=$(vcgencmd version | grep -oP 'version \K.*')
gpu_speed=$(vcgencmd measure_clock arm | awk -F= '{print $2/1000000 " MHz"}')
os_name=$(lsb_release -d | awk -F: '{print $2}' | xargs)
os_version=$(lsb_release -r | awk -F: '{print $2}' | xargs)
os_architecture=$(uname -m)
eth_ip=$(get_network_info eth0)
wifi_ip=$(get_network_info wlan0)
public_ip=$(get_public_ip)

# Display the table
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mCPU Name         \e[1;34m| \e[1;32m$cpu_name\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mCPU Speed        \e[1;34m| \e[1;32m$cpu_speed MHz\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mCPU Cores        \e[1;34m| \e[1;32m$cpu_cores\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mGPU Name         \e[1;34m| \e[1;32m$gpu_name\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mGPU Speed        \e[1;34m| \e[1;32m$gpu_speed\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mOS Name          \e[1;34m| \e[1;32m$os_name\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mOS Version       \e[1;34m| \e[1;32m$os_version\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mOS Architecture  \e[1;34m| \e[1;32m$os_architecture\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mEthernet IP      \e[1;34m| \e[1;32m$eth_ip\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mWiFi IP          \e[1;34m| \e[1;32m$wifi_ip\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"
echo -e "\e[1;34m| \e[1;33mPublic IP        \e[1;34m| \e[1;32m$public_ip\e[1;34m |\e[0m"
echo -e "\e[1;34m+------------------+------------------+\e[0m"