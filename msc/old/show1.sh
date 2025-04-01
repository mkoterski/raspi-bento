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

# Print the lines with the specified positions
clear
print_at_position 1 "${bold}Raspi Bento - v0.04${reset}"
print_at_position 62 "2025-01-18 - 13:58"
printf "\n"
print_at_position 1 "calypso | Ubuntu 24.04.1 LTS | aarch64"
print_at_position 45 "Raspberry Pi 3 Model B Plus Rev 1.3"
printf "\n"
printf "\n"
print_at_position 1 " ${bold}[1] Network Test${reset}"
print_at_position 25 "Internet"
print_at_position 53 "Local network"
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
print_at_position 1 " ${bold}Press number to run test or 'q' to quit${reset}"
printf "\n"
