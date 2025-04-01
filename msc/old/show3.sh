#!/bin/bash

# Check if script is run as root
[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

print_at_position() {
    local position=$1
    local text=$2
    printf "\e[%sG%s" "$position" "$text"
}

# Define colors and bold text using tput
red=$(tput setaf 1)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
reset=$(tput sgr0)
bold=$(tput bold)

# Get Sys Info

# Determine the OS type
os_type=$(uname)

# Get model information
if [ "$os_type" == "Linux" ]; then
    model_info=$(cat /proc/device-tree/model 2>/dev/null | tr -d '\0' || echo "Unknown Model")
elif [ "$os_type" == "Darwin" ]; then
    model_info=$(sysctl -n hw.model)
else
    model_info="Unknown Model"
fi

# Get OS information
if [ "$os_type" == "Linux" ]; then
    os_info=$(lsb_release -d | awk -F: '{print $2}' | xargs)
elif [ "$os_type" == "Darwin" ]; then
    os_info=$(system_profiler SPSoftwareDataType | grep "System Version" | sed 's/.*: //; s/ (.*)//')
else
    os_info="Unknown OS"
fi

# Get hostname
hostname=$(hostname)

# Get architecture
arch=$(uname -m)

# Get current date and time
datetime=$(date +"%Y-%m-%d - %H:%M")

# Check if speedtest-cli is installed
if command -v speedtest-cli &> /dev/null; then
    network_test_status="[${bold}${green}✓${reset}]${reset} Ready"
else
    network_test_status="[${bold}${red}x${reset}]${reset} Dependencies missing"
fi

# Check if hdparm and sysbench are installed

if command -v hdparm &> /dev/null && command -v sysbench &> /dev/null; then
    cpu_test_status="[${bold}${green}✓${reset}]${reset} Ready"
else
    cpu_test_status="[${bold}${red}x${reset}]${reset} Dependencies missing"
fi

# Check if dd or fio are installed

if command -v dd &> /dev/null || command -v fio &> /dev/null; then
    storage_test_status="[${bold}${green}✓${reset}]${reset} Ready"
else
    storage_test_status="[${bold}${red}x${reset}]${reset} Dependencies missing"
fi


# Display the header
clear
printf "\e[1;34mRaspi Bento - v0.06%*s\n" $(( $(tput cols) - 20 )) "$datetime"
printf "\e[1;34m%s | %s | %s%*s\e[0m\n" "$hostname" "$os_info" "$arch" $(( $(tput cols) - ${#hostname} - ${#os_info} - ${#arch} - 7 )) "$model_info"
  

# display the menu
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[1] Network Test${reset}"
print_at_position 25 "Internet"
print_at_position 53 "Network"
printf "\n"
print_at_position 25 "$network_test_status"
#print_at_position 53 "$network_test_status"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[2] CPU Test${reset}"
print_at_position 25 "CPU"
print_at_position 41 "Threads"
print_at_position 57 "Memory"
printf "\n"
print_at_position 25 "$cpu_test_status"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[3] Storage Test${reset}"
print_at_position 25 "Write speed"
print_at_position 53 "Read speed"
printf "\n"
print_at_position 25 "$storage_test_status"
#print_at_position 53 "[${bold}${green}✓${reset}]${reset} Ready"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}Press number to run test or 'q' to quit${reset}"
printf "\n"
printf "\n"
