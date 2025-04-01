#!/bin/bash

# Check if script is run as root
[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

# Print the lines with the specified positions
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
    os_info=$(sw_vers -productName)" "$(sw_vers -productVersion)
else
    os_info="Unknown OS"
fi

# Get hostname
hostname=$(hostname)

# Get architecture
arch=$(uname -m)

# Get current date and time
datetime=$(date +"%Y-%m-%d - %H:%M")


clear
#print_at_position 1 "${bold}Raspi Bento - v0.05${reset}"
#print_at_position 62 "2025-01-18 - 13:58"

printf "\e[1;34mRaspi Bento - v0.06%*s\n" $(( $(tput cols) - 20 )) "$datetime"
#print_at_position 1 "calypso | Ubuntu 24.04.1 LTS | aarch64"
#print_at_position 45 "Raspberry Pi 3 Model B Plus Rev 1.3"
printf "\e[1;34m%s | %s | %s%*s\e[0m\n" "$hostname" "$os_info" "$arch" $(( $(tput cols) - ${#hostname} - ${#os_info} - ${#arch} - 7 )) "$model_info"
  
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[1] Network Test${reset}"
print_at_position 25 "Internet"
print_at_position 53 "Network"
printf "\n"
print_at_position 25 "[${bold}${red}x${reset}]${reset} Dependencies missing"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[2] CPU Test${reset}"
print_at_position 25 "CPU"
print_at_position 41 "Threads"
print_at_position 57 "Memory"
printf "\n"
print_at_position 25 "[${bold}${yellow}i${reset}]${reset} Running CPU test..."
printf "\n"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[3] Storage Test${reset}"
print_at_position 25 "Write speed"
print_at_position 53 "Read speed"
printf "\n"
print_at_position 25 "[${bold}${green}✓${reset}]${reset} Ready"
print_at_position 53 "[${bold}${green}✓${reset}]${reset} Ready"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}Press number to run test or 'q' to quit${reset}"
printf "\n"
printf "\n"
