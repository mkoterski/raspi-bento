#!/bin/bash

[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

# Function to check for required packages
check_packages() {
    REQUIRED_PACKAGES=("hdparm" "sysbench" "speedtest-cli")
    for pkg in "${REQUIRED_PACKAGES[@]}"; do
        if ! dpkg -l | grep -q "$pkg"; then
            echo "Package $pkg is not installed."
        else
            echo "Package $pkg is installed."
        fi
    done
}

# Function to install required packages
install_packages() {
    REQUIRED_PACKAGES=("hdparm" "sysbench" "speedtest-cli")
    for pkg in "${REQUIRED_PACKAGES[@]}"; do
        if ! dpkg -l | grep -q "$pkg"; then
            echo "Installing $pkg..."
            apt-get install -y "$pkg"
        else
            echo "Package $pkg is already installed."
        fi
    done
}

# Interactive menu
while true; do
    clear
    echo "System Information:"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "Date: $(date +%F)"
    echo "Time: $(date +%T)"
    echo ""
    echo "Select an option:"
    echo "1. Check for required packages"
    echo "2. Install required packages"
    echo "3. Exit"
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            check_packages
            read -p "Press [Enter] key to continue..."
            ;;
        2)
            install_packages
            read -p "Press [Enter] key to continue..."
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press [Enter] key to continue..."
            ;;
    esac
done