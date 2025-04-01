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

# Animation
animation_running() {
  local animation_running_delay=0.5
  local animation_running_dots=(
    "[${bold}${yellow}i${reset}] Running test.  \n"
    "[${bold}${yellow}i${reset}] Running test.. \n"
    "[${bold}${yellow}i${reset}] Running test...\n"
    "[${bold}${yellow}i${reset}] Running test.. \n"
    "[${bold}${yellow}i${reset}] Running test.  \n"
    "[${bold}${yellow}i${reset}] Running test   \n"
  )
  
  while true; do
    for dot in "${animation_running_dots[@]}"; do
      printf "\r%s" "$dot"
      sleep $animation_running_delay
    done
  done
}

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

# Function to display the menu
display_menu() {
    clear
    printf "\e[1;34mRaspi Bento - v0.06%*s\n" $(( $(tput cols) - 20 )) "$datetime"
    printf "\e[1;34m%s | %s | %s%*s\e[0m\n" "$hostname" "$os_info" "$arch" $(( $(tput cols) - ${#hostname} - ${#os_info} - ${#arch} - 7 )) "$model_info"
    printf "\n"
    printf "\n"
    print_at_position 1 " ${bold}[1] Network Test${reset}"
    print_at_position 25 "Internet"
    print_at_position 53 "Network"
    printf "\n"
    print_at_position 25 "$network_test_status"
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
    printf "\n"
    printf "\n"
    printf "\n"
    printf "\n"
}

# Main loop to display the menu and handle user input
while true; do
    display_menu
    read -p "${bold}Press number to run test or 'q' to quit: ${reset}" choice
    case $choice in
        1)
            animation_running &
            animation_pid=$!
            check_network
            speedtest-cli --simple
            kill $animation_pid
            printf "\n"
            read -p "Press [Enter] key to continue..."
            ;;
        2)
            animation_running &
            animation_pid=$!
            check_cpu
            sysbench cpu --cpu-max-prime=5000 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
            sysbench threads --thread-yields=4000 --thread-locks=6 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
            sysbench memory --memory-block-size=1K --memory-total-size=3G --memory-access-mode=seq --threads=4 run | grep 'Operations\|transferred\|total time:\|min:\|avg:\|max:' | tr -s [:space:]
            kill $animation_pid
            printf "\n"
            read -p "Press [Enter] key to continue..."
            ;;
        3)
            animation_running &
            animation_pid=$!
            check_storage
            hdparm -t /dev/mmcblk0 | grep Timing
            rm -f ~/test.tmp && sync && dd if=/dev/zero of=~/test.tmp bs=1M count=512 conv=fsync 2>&1 | grep -v records
            echo 3 > /proc/sys/vm/drop_caches && sync && dd if=~/test.tmp of=/dev/null bs=1M 2>&1 | grep -v records
            rm -f ~/test.tmp
            kill $animation_pid
            printf "\n"
            read -p "Press [Enter] key to continue..."
            ;;
        a)
            animation_running &
            animation_pid=$!
            check_network
            speedtest-cli --simple
            check_cpu
            sysbench cpu --cpu-max-prime=5000 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
            sysbench threads --thread-yields=4000 --thread-locks=6 --threads=4 run | grep 'total time:\|min:\|avg:\|max:' | tr -s [:space:]
            sysbench memory --memory-block-size=1K --memory-total-size=3G --memory-access-mode=seq --threads=4 run | grep 'Operations\|transferred\|total time:\|min:\|avg:\|max:' | tr -s [:space:]
            check_storage
            hdparm -t /dev/mmcblk0 | grep Timing
            rm -f ~/test.tmp && sync && dd if=/dev/zero of=~/test.tmp bs=1M count=512 conv=fsync 2>&1 | grep -v records
            echo 3 > /proc/sys/vm/drop_caches && sync && dd if=~/test.tmp of=/dev/null bs=1M 2>&1 | grep -v records
            rm -f ~/test.tmp
            kill $animation_pid
            printf "\n"
            read -p "Press [Enter] key to continue..."
            ;;
        q)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press [Enter] key to continue..."
            ;;
    esac
done